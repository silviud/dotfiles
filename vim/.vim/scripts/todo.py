import datetime

def now():
    fmt = "%H:%M - %d %b %Y"
    return datetime.datetime.utcnow().strftime(fmt)


def _template(data={'title': 'Title', 
    'description': 'Description',
    'type': 'bug|feature',
    'status': 'done|in-progress|backlog',
    'created': now(),
    'updated': now(),
    'id': 1 }):

    tmpl = """
{title}
-------

Id: {id} 
Type: {type} 
Status: {status} 
Created: {created}
Updated: {updated}
Description : {description}

""".format(**data)
    return tmpl


if __name__ == '__main__':
    print _template()
