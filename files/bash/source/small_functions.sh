
# remove last character
rlc () {
	perl -pe "s/.$//"
}

# shorcut
ffm=/mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Batch/FFmpeg


alias sbashrc='source ~/.bashrc'
alias nbashrc='nano ~/.bashrc'

# backup bashrc
alias bubashrc='cat ~/.bashrc > /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/bashrc.sh'

timestamp () {
  date +"%Y%m%d-%H%M%S"
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
