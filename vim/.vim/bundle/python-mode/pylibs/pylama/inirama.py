"""
    Parse INI files.

"""
from __future__ import absolute_import

import io
import re
import logging
from collections import MutableMapping
try:
    from collections import OrderedDict
except ImportError as e:
    from ordereddict import OrderedDict


__version__ = '0.2.9'
__project__ = 'Inirama'
__author__ = "Kirill Klenov <horneds@gmail.com>"
__license__ = "BSD"


NS_LOGGER = logging.getLogger('inirama')


class Scanner(object):

    def __init__(self, source, ignore=None, patterns=None):
        """ Init Scanner instance.

            :param patterns: List of token patterns [(token, regexp)]
            :param ignore: List of ignored tokens
        """
        self.reset(source)
        if patterns:
            self.patterns = []
            for k, r in patterns:
                self.patterns.append((k, re.compile(r)))

        if ignore:
            self.ignore = ignore

    def reset(self, source):
        """ Reset scanner.

            :param source: Source for parsing
        """
        self.tokens = []
        self.source = source
        self.pos = 0

    def scan(self):
        """ Scan source and grab tokens.
        """
        self.pre_scan()

        token = None
        end = len(self.source)

        while self.pos < end:

            best_pat = None
            best_pat_len = 0

            # Check patterns
            for p, regexp in self.patterns:
                m = regexp.match(self.source, self.pos)
                if m:
                    best_pat = p
                    best_pat_len = len(m.group(0))
                    break

            if best_pat is None:
                raise SyntaxError(
                    "SyntaxError[@char {0}: {1}]".format(
                        self.pos, "Bad token."))

            # Ignore patterns
            if best_pat in self.ignore:
                self.pos += best_pat_len
                continue

            # Create token
            token = (
                best_pat,
                self.source[self.pos:self.pos + best_pat_len],
                self.pos,
                self.pos + best_pat_len,
            )

            self.pos = token[-1]
            self.tokens.append(token)

    def pre_scan(self):
        """ Prepare source.
        """
        pass

    def __repr__(self):
        """ Print the last 5 tokens that have been scanned in
        """
        return '<Scanner: ' + ','.join(
            "{0}({2}:{3})".format(*t) for t in self.tokens[-5:]) + ">"


class INIScanner(Scanner):
    patterns = [
        ('SECTION', re.compile(r'\[[^]]+\]')),
        ('IGNORE', re.compile(r'[ \r\t\n]+')),
        ('COMMENT', re.compile(r'[;#].*')),
        ('KEY', re.compile(r'[\w_]+\s*[:=].*'))]

    ignore = ['IGNORE']

    def pre_scan(self):
        escape_re = re.compile(r'\\\n[\t ]+')
        self.source = escape_re.sub('', self.source)


undefined = object()


class Section(MutableMapping):

    def __init__(self, namespace, *args, **kwargs):
        super(Section, self).__init__(*args, **kwargs)
        self.namespace = namespace
        self.__storage__ = dict()

    def __setitem__(self, name, value):
        self.__storage__[name] = str(value)

    def __getitem__(self, name):
        return self.__storage__[name]

    def __delitem__(self, name):
        del self.__storage__[name]

    def __len__(self):
        return len(self.__storage__)

    def __iter__(self):
        return iter(self.__storage__)

    def __repr__(self):
        return "<{0} {1}>".format(self.__class__.__name__, str(dict(self)))

    def iteritems(self):
        for key in self.__storage__.keys():
            yield key, self[key]

    items = lambda s: list(s.iteritems())


class InterpolationSection(Section):

    var_re = re.compile('{([^}]+)}')

    def get(self, name, default=None):
        if name in self:
            return self[name]
        return default

    def __interpolate__(self, math):
        try:
            key = math.group(1).strip()
            return self.namespace.default.get(key) or self[key]
        except KeyError:
            return ''

    def __getitem__(self, name):
        value = super(InterpolationSection, self).__getitem__(name)
        sample = undefined
        while sample != value:
            try:
                sample, value = value, self.var_re.sub(
                    self.__interpolate__, value)
            except RuntimeError:
                message = "Interpolation failed: {0}".format(name)
                NS_LOGGER.error(message)
                raise ValueError(message)
        return value


class Namespace(object):

    default_section = 'DEFAULT'
    silent_read = True
    section_type = Section

    def __init__(self, **default_items):
        self.sections = OrderedDict()
        for k, v in default_items.items():
            self[self.default_section][k] = v

    @property
    def default(self):
        """ Return default section or empty dict.
        """
        return self.sections.get(self.default_section, dict())

    def read(self, *files, **params):
        """ Read and parse INI files.
        """
        for f in files:
            try:
                with io.open(f, encoding='utf-8') as ff:
                    NS_LOGGER.info('Read from `{0}`'.format(ff.name))
                    self.parse(ff.read(), **params)
            except (IOError, TypeError, SyntaxError, io.UnsupportedOperation):
                if not self.silent_read:
                    NS_LOGGER.error('Reading error `{0}`'.format(ff.name))
                    raise

    def write(self, f):
        """
            Write self as INI file.

            :param f: File object or path to file.
        """
        if isinstance(f, str):
            f = io.open(f, 'w', encoding='utf-8')

        if not hasattr(f, 'read'):
            raise AttributeError("Wrong type of file: {0}".format(type(f)))

        NS_LOGGER.info('Write to `{0}`'.format(f.name))
        for section in self.sections.keys():
            f.write('[{0}]\n'.format(section))
            for k, v in self[section].items():
                f.write('{0:15}= {1}\n'.format(k, v))
            f.write('\n')
        f.close()

    def parse(self, source, update=True, **params):
        """ Parse INI source.
        """
        scanner = INIScanner(source)
        scanner.scan()

        section = self.default_section

        for token in scanner.tokens:
            if token[0] == 'KEY':
                name, value = re.split('[=:]', token[1], 1)
                name, value = name.strip(), value.strip()
                if not update and name in self[section]:
                    continue
                self[section][name] = value

            elif token[0] == 'SECTION':
                section = token[1].strip('[]')

    def __getitem__(self, name):
        """ Look name in self sections.
        """
        if not name in self.sections:
            self.sections[name] = self.section_type(self)
        return self.sections[name]

    def __repr__(self):
        return "<Namespace: {0}>".format(self.sections)


class InterpolationNamespace(Namespace):

    section_type = InterpolationSection

# lint_ignore=W0201,R0924,F0401
