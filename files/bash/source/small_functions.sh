
# remove git checks

git config --global status.showUntrackedFiles no





# eza as ls
alias ls="eza -lh -smod --git" # use eza instead of ls `eza -lh -smod --git`, smod is sorted modified
alias lsa="eza -lha -smod --git" # like ls but show hidden files
alias cd1="cd /mnt/c/Users/doria/Downloads" # go do Download on C
alias cd2="cd /mnt/c/Users/doria/Downloads/GitHub"
alias cd3="cd /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files"
alias cd4="cd /mnt/c/Users/doria/Downloads/gdrive/RR"
alias cd5="cd /mnt/c/Users/doria/Downloads/dorian.gravier.github.io/files/bash/source"
alias cd6="cd /mnt/c/Users/doria/scoop"
alias cd7="cd /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/_pages/code"
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
	head -n 1 "$1" | tr ',' '\n' | tr ';' '\n' | sed 's/\"//g'
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

# riaf() { # replace string in all files in folder run
  # # Replace In All Files
  # cecho -g "riaf=Replace in All Files, '$1' is search string, '$2' is replacement: USE DOUBLE QUOTES: riaf \"#fa9b2c\" \"Color1\""
  # local in="$1"
  # local out="$2"
  # # old \Q is opening quote and \E ending quote
  # # grep -rl -- "${in}" . | xargs -d '\n' -I {} perl -pi -e "s|\Q${in}\E|${out}|g" "{}"
  # grep -rl -- "${in}" . | xargs -d '\n' -I {} perl -pi -e "s|${in}|${out}|g" "{}"
# }

_riaf_quote() {
  # Wrap in single quotes, escaping embedded single quotes the POSIX way
  local s="$1"
  printf "'%s'" "${s//\'/\'\\\'\'}"
}

riaf() { # replace string in folder or recursive (-r), literal by default, regex with -E
  # Replace In All Files
  local recursive=false
  local regex_mode=false
  local in=""
  local out=""

  while [[ "$1" == -* ]]; do
    case "$1" in
      -r) recursive=true ;;
      -E) regex_mode=true ;;
      *)
        cecho -r "Unknown flag: $1"
        return 1
        ;;
    esac
    shift
  done
  in="$1"
  out="$2"

  if [[ -z "$in" || -z "$out" ]]; then
    cecho -g "riaf=Replace in All Files"
    cecho -g "Usage: riaf [-r] [-E] \"search_string\" \"replacement\""
    cecho -g "  -r: recursive search"
    cecho -g "  -E: treat search/replacement as a Perl regex (default: literal, no regex)"
    cecho -g "  Without -r: search only in current directory"
    cecho -g "USE DOUBLE QUOTES: riaf \"#fa9b2c\" \"Color1\""
    return 1
  fi

  cecho -g "riaf=Replace in All Files, '$in' is search string, '$out' is replacement"

  local q_in q_out full_cmd grep_target grep_str has_matches
  q_in=$(_riaf_quote "$in")
  q_out=$(_riaf_quote "$out")

  if [[ "$recursive" == true ]]; then
    cecho -g "Searching recursively..."
    grep_target="."
    grep_str="-rlZ"
  else
    cecho -g "Searching in current directory only..."
    grep_target="*"
    grep_str="-lZ"
  fi

  if [[ "$regex_mode" == true ]]; then
    grep_str="${grep_str}P"
    full_cmd="grep ${grep_str} -- $q_in $grep_target | xargs -0 perl -pi -e $(_riaf_quote "s|${in}|${out}|g")"
  else
    grep_str="${grep_str}F"
	full_cmd="grep ${grep_str} -- $q_in $grep_target | xargs -0 env IN=$q_in OUT=$q_out perl -pi -e $(_riaf_quote 's/\Q$ENV{IN}\E/$ENV{OUT}/g')"
  fi

  

  # Quick existence check (boolean, avoids NUL-in-variable issues)
  if [[ "$recursive" == true ]]; then
    if [[ "$regex_mode" == true ]]; then
      grep -qrP -- "${in}" . 2>/dev/null; has_matches=$?
    else
      grep -qrF -- "${in}" . 2>/dev/null; has_matches=$?
    fi
  else
    if [[ "$regex_mode" == true ]]; then
      grep -qP -- "${in}" * 2>/dev/null; has_matches=$?
    else
      grep -qF -- "${in}" * 2>/dev/null; has_matches=$?
    fi
  fi

  if [[ "$has_matches" -ne 0 ]]; then
    cecho -g "No matches found."
    return 0
  fi

  if [[ "$regex_mode" == true ]]; then
    if [[ "$recursive" == true ]]; then
      grep -rlZP -- "${in}" . | xargs -0 perl -pi -e "s|${in}|${out}|g"
    else
      grep -lZP -- "${in}" * | xargs -0 perl -pi -e "s|${in}|${out}|g"
    fi
  else
    if [[ "$recursive" == true ]]; then
      grep -rlZF -- "${in}" . | xargs -0 env IN="$in" OUT="$out" perl -pi -e 's/\Q$ENV{IN}\E/$ENV{OUT}/g'
    else
      grep -lZF -- "${in}" * | xargs -0 env IN="$in" OUT="$out" perl -pi -e 's/\Q$ENV{IN}\E/$ENV{OUT}/g'
    fi
  fi
  
  local cmd_file="riaf_last_cmd.sh"
  printf '%s\n' "$full_cmd" >> "$cmd_file"

	cecho -g "Equivalent command (copy-paste ready, run in the target directory):"
  cecho -g "  $full_cmd"
  cecho -g "Also saved to $cmd_file -- cat/scp/open that file instead of copying from the terminal if you see garbage (^[[D etc.) when pasting a long line."
  
  
  
}