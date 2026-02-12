
# remove git checks

git config --global status.showUntrackedFiles no





# eza as ls
alias ls="eza -lh -smod --git" # use eza instead of ls `eza -lh -smod --git`, smod is sorted modified
alias lsa="eza -lha -smod --git" # like ls but show hidden files
alias s1="cd /mnt/c/Users/doria/Downloads" # go do Download on C
alias sbashrc='source ~/.bashrc' # source your .bashrc
alias nbashrc='nano ~/.bashrc' # nano your .bashrc
alias bubashrc='cat ~/.bashrc > /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/bashrc.sh' # backup bashrc
alias rmFl='tail -n +2' # rm first line of a file 
alias rmLl='head -n -1' # rm last line of a file 
alias vscodium='/mnt/c/Windows/System32/cmd.exe /C "vscodium"' # open vscodium in windows
alias slugify='slugify --separator "_" --no-lowercase' # Slugify a filename

cdd() { # use cd on windows path cdd "C:\Users\doria\Downloads"
    cd "$(wslpath "$1")"
}


fjson() { # pretty print json
	
	checkdep sponge jq
	# sponge reads all input first, then writes to the file
	jq '.' "$1" | sponge "$1"
}

headers() { # print the header, names, labels from a csv file 
	head -n 1 "$1" | tr ',' '\n'
}




rlc () { # remove last character
	perl -pe "s/.$//"
}


lfunction() { # List all function that I have written

	wd="/mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/"

	
	find "$wd" -name '*.sh' | while read -r file; do
		filename=$(basename "$file")
		cecho -g "------------------ $filename ------------------------------"

		# Extract both functions and aliases
		grep -P '^\s*(\w+\s*\(\)\s*\{|alias\s+\w+=)' "$file" | \
		perl -ne '
			if (/^\s*(\w+)\s*\(\).*{\s*(#.*)$/) {
				# Function
				$func = $1;
				$comment = $2 // "";
				$comment =~ s/^#\s*//;
				print "$func\t$comment\n";
			}
			elsif (/^\s*alias\s+(\w+)=.*(#.*)$/) {
				# Alias
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


slugi () { # Slugify filenames: usage slugi "filename.txt", or slugi *.mp4 (replace special characters amd spaces and keep case)
    # for f in *\ *; do mv "$f" "${f// /_}"; done
    for file in "$@"; do
        filename="${file%.*}"
        ext="${file##*.}"
        mv "$file" "$(slugify --separator "_" --no-lowercase "${filename}").${ext}"
    done
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


riaf() { # replace string in folder or recursive (-r)
  # Replace In All Files
  local recursive=true
  local in=""
  local out=""
  
  # Parse arguments
  if [[ "$1" == "-r" ]]; then
    recursive=true
    in="$2"
    out="$3"
  else
    recursive=false
    in="$1"
    out="$2"
  fi
  
  # Validate arguments
  if [[ -z "$in" || -z "$out" ]]; then
    cecho -g "riaf=Replace in All Files"
    cecho -g "Usage: riaf [-r] \"search_string\" \"replacement\""
    cecho -g "  -r: recursive search (default if not specified)"
    cecho -g "  Without -r: search only in current directory"
    cecho -g "USE DOUBLE QUOTES: riaf \"#fa9b2c\" \"Color1\""
    return 1
  fi
  
  cecho -g "riaf=Replace in All Files, '$in' is search string, '$out' is replacement"
  
  if [[ "$recursive" == true ]]; then
    cecho -g "Searching recursively..."
    grep -rl -- "${in}" . | xargs -d '\n' -I {} perl -pi -e "s|${in}|${out}|g" "{}"
  else
    cecho -g "Searching in current directory only..."
    grep -l -- "${in}" * 2>/dev/null | xargs -d '\n' -I {} perl -pi -e "s|${in}|${out}|g" "{}"
  fi
}
