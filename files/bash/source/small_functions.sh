

# eza as ls
alias ls="eza -lh -smod --git" # smod is sorted modified
alias lsa="eza -lha --git"

# ln -s $(wslpath "C:\Users\doria\Downloads") down


cdd() { # use cd on windows path cdd "C:\Users\doria\Downloads"
    cd "$(wslpath "$1")"
}

cddown() { # go to C:\Users\doria\Downloads
    cd "$(wslpath "C:\Users\doria\Downloads")"
}

fjson() { # pretty print json
	
	checkdep sponge jq
	# sponge reads all input first, then writes to the file
	jq '.' "$1" | sponge "$1"
}



rlc () { # remove last character
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

# backup bashrc
alias bubashrc='cat ~/.bashrc > /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/bashrc.sh'

lfunction() { # List all function that I have written

	wd="/mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/"
	# Find all .sh files in the specified directory
	find "$wd" -name '*.sh' | while read -r file; do
	    filename=$(basename "$file")
		cecho -g "------------------ $filename ------------------------------"
		# Extract function names using grep and cut
		# grep -oP '^\s*\w+\s*\(\)\s*\{' "$file" | cut -d ' ' -f 1 | sed 's/\(\)//g'
		# grep -oP '^\s*\w+\s*\(\)\s*\{' "$file" | cut -d '#' -f 2 | sed 's/^\s//g'
		
		# grep -P '^\s*\w+\s*\(\)\s*\{' "$file" | perl -pe 's/\(\).*\#/\t\t--->\t/g'
		
		 # Extract functions and comments, sort alphabetically by function name
        grep -P '^\s*\w+\s*\(\)\s*\{' "$file" | \
        perl -ne '
            if (/^\s*(\w+)\s*\(\).*\{.*(#.*)$/) {
                $func = $1;
                $comment = $2 // "";
                $comment =~ s/^#\s*//;
                print "$func\t$comment\n";
            }
        ' | sort | while IFS=$'\t' read -r func_name comment2; do
            printf "%-25s\t%s\t%s\n" "${YELLOW}$func_name${NC}" "${CYAN}--->${NC}" "${WHITE}${comment2}${NC} "
        done
		
		echo ""

	done
}




timestamp () { # echo timestamp
  date +"%Y%m%d-%H%M%S"
}

l0() { # ...
    local num="$1"
    local width="$2"
    printf "%0${width}d" "$num"
}


addts () { # add timestamp to a filename
	# # old code
    # dirname=$(dirname "$1")
    # filename=$(basename "$1")
    # ext=$(echo "$filename" | cut -f 2 -d '.')
    # filename=$(echo "$filename" | cut -f 1 -d '.')
    # ts=$(timestamp)
    # mv "$1"  "${dirname}/${filename}_${ts}.${ext}"
	# old code
	local input="$1"
	local ts
    ts="$(date +'%Y%m%d-%H%M%S')"

    # extract basename and extension
    local base="${input%.*}"
    local ext="${input##*.}"

    # if no extension, avoid adding a trailing dot
    if [[ "$base" == "$ext" ]]; then
        local new=$(printf "%s_%s\n" "$input" "$ts")
    else
        local new=$(printf "%s_%s.%s\n" "$base" "$ts" "$ext")
    fi
    mv -- "$input" "$new"
    echo "Renamed to: $new"
}


rsf () { # Replace all spaces in filenames
  for f in *\ *; do mv "$f" "${f// /_}"; done
}


checkdep() { # check if packages are installed arguments as packages
    local args=("$@")
    deps=0
    for name in "${args[@]}"; do
        [[ $(command -v $name 2>/dev/null) ]] || { cecho -y "$name" -r " needs to be installed.";deps=1;}
    done
    # [[ $deps -ne 1 ]] && cecho -g "All depedencies fulfilled" || { cecho -r "\nInstall the above and rerun this script\n"; }
    [[ $deps -ne 1 ]] || { cecho -r "\nInstall the above and rerun this script\n"; }
}

riaf() { # replace string in all files in folder run
  # Replace In All Files
  cecho -g "riaf=Replace in All Files, '$1' is search string, '$2' is replacement: USE DOUBLE QUOTES: riaf \"#fa9b2c\" \"Color1\""
  local in="$1"
  local out="$2"
  # old \Q is opening quote and \E ending quote
  # grep -rl -- "${in}" . | xargs -d '\n' -I {} perl -pi -e "s|\Q${in}\E|${out}|g" "{}"
  grep -rl -- "${in}" . | xargs -d '\n' -I {} perl -pi -e "s|${in}|${out}|g" "{}"
}
