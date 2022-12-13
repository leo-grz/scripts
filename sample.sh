#!/usr/bin/sh

# ============================================ HELPER FUNCS

# ----------------------------------#> ECHOS

COLOR_RED=`tput setaf 1`    # critical
COLOR_GREEN=`tput setaf 2`  # ok
COLOR_YELLOW=`tput setaf 3` # resolvable
COLOR_BLUE=`tput setaf 6`   # debug
COLOR_RESET=`tput sgr0`		# RESET

echo_blue () {
	echo -e "\n${COLOR_BLUE}[**] $1${COLOR_RESET}"
}

echo_green () {
	echo -e "${COLOR_GREEN}[ok] $1${COLOR_RESET}"
}

echo_yellow () {
	echo -e "${COLOR_YELLOW}[--] $1${COLOR_RESET}"
}

echo_red () {
	echo -e "${COLOR_RED}[!!] $1${COLOR_RESET}"
}

# ----------------------------------#> EXECUTION

execute () { # <cmd> <msg> <alternative cmd> <alternative msg> OR <cmd> <msg: cmd success> <msg: cmd failed>
	$1 1>/dev/null
	if [[ $? == 0 ]]; then
		echo_green "$2"	
		return 0
	elif [[ $3 != "" && $4 == "" ]]; then
		echo_red "$3"
		return 1
	elif [[ $3 != "" && $4 != "" ]]; then
		execute "$3" "$4"
	else
		echo_red "Execution of '$1' failed!"
		return 1
	fi
}
