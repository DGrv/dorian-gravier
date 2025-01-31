
# remove last character
rlc () {
	perl -pe "s/.$//"
}

alias llh='ls -lh' # (human-readable file sizes)
alias lls='ls -lhS' #(sort by size)
alias ltr='ls -ltr' #(sort by modification time)
alias lsr='ls -R' # (recursive listing)
alias lsd='ls -d */' #(list directories only)
alias lt='ls -t' # (sort by modification time)



# shorcut
alias godown="cd /mnt/c/Users/doria/Downloads"


alias sbashrc='source ~/.bashrc'
alias nbashrc='nano ~/.bashrc'
alias szshrc='source ~/.zshrc'
alias nzshrc='nano ~/.zshrc'

# backup bashrc
alias bubashrc='cat ~/.bashrc > /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/bashrc.sh'
alias buzshrc='cat ~/.zshrc > /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/zshrc.sh'

timestamp () {
  date +"%Y%m%d-%H%M%S"
}

l0() {
    local num="$1"
    local width="$2"
    printf "%0${width}d" "$num"
}


rents () {
    dirname=$(dirname "$1")
    filename=$(basename "$1")
    ext=$(echo "$filename" | cut -f 2 -d '.')
    filename=$(echo "$filename" | cut -f 1 -d '.')
    ts=$(timestamp)
    mv "$1"  "${dirname}/${filename}_${ts}.${ext}"
}


replacespacesfilename () {
  for f in *\ *; do mv "$f" "${f// /_}"; done
}


checkdep() {
    local args=("$@")
    deps=0
    for name in "${args[@]}"; do
        [[ $(command -v $name 2>/dev/null) ]] || { cecho -y "$name" -r " needs to be installed.";deps=1;}
    done
    [[ $deps -ne 1 ]] && cecho -g "All depedencies fulfilled" || { cecho -r "\nInstall the above and rerun this script\n"; }
}
