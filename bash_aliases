# Luke Dennis bash alias

# general
open() {
    xdg-open "$@"
    exit
}
alias open.='open .'
alias sudo!!='sudo !!'
alias ycm='~/.vim/plugged/YCM-Generator/config_gen.py ./'
alias dotfiles='cd ~/Documents/projects/dotfiles
    ./dotfiles.sh'
alias sumo='cd ~/Documents/projects/sumoBotUNSW2017/slimSumo
    vim slimSumo.ino'

# comp related
alias cse='ssh z5117189@cse.unsw.edu.au'

csescp() {
    scp "$@" z5117189@cse.unsw.edu.au:~/scp
    cse
}

scpcse() {
    scp z5117189@cse.unsw.edu.au:~/"$@" ./
}

unziplab() {
    unzip ~/Downloads/lab.zip
    rm ~/Downloads/lab.zip
}

#17s2
alias 2500='cd ~/Documents/uni/17s2/MTRN2500/ass2'
alias 1521='cd ~/Documents/uni/17s2/COMP1521/labs'
alias 2521='cd ~/Documents/uni/17s2/COMP2521/labs'
alias 2300='open ~/Documents/uni/17s2/MMAN2300'


#alias cs1521='cd ~/1521/labs'
#alias cs2521='cd ~/2521/labs'
