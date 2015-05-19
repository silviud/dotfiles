export WORKON_HOME=$HOME/Envs
export PROJECT_HOME=$HOME/PROGS
. $HOME/Envs/p/bin/virtualenvwrapper.sh


function encrypt(){
    file=$1
    openssl enc -aes-256-cbc -salt -in $file -out ${file}.enc
}

function decrypt(){
    file=$1
    openssl enc -aes-256-cbc -d -in ${file}.enc -out ${file}
}
