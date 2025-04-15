#!/bin/bash

# The disk free for your information "at" batch system ( DF-FYI-AT ) is a custom bash script to scheduling a time bomb for providing notification using fyi tool for the disk free going empty by mentioning "user specified space" based on which 

b=$(tput setaf 4)
r=$(tput setaf 1)
g=$(tput setaf 10)
y=$(tput setaf 3)
reset=$(tput sgr0)
c=$(tput setaf 14)
o=$(tput setaf 208) 


usage(){
	cat << EOF
	Usage ./df-fyi-at [-h|-n|-a|-p|-l]
		-h : displays the help section 
		-n : Name of the scheduled task 
		path autodetected
		-a : Time of systemd timer scheduling
		-p : Make Persistent at scheduling
		-l : Listing current tasks scheduled
EOF
}

name=0
time=0
persistent=0
listing=0

while getopts ":hn:a:pl" OPTS ; do
	case "$OPTS" in
		p)
			persistent=${OPTARG}
				persistent=1
			;;
		n)
			name=${OPTARG}
				name=1

			;;
		a)
			time=${OPTARG}
				time=1
			;;
		l)
			listing=1
			echo ${y}$(atq)${reset}
			exit 0
			;;
		h)
			usage 
			exit 0
			;;
		\?)
			echo "Invalid option provided"
			usage
			exit 1
			;;
		:)
			echo "Missing argument"
			usage
			exit 1
	esac
done

if [[ ! -n $1 ]] ; then 
	usage
	exit 1
fi
	
if [[ $name -eq 0 ]] || [[ $time -eq 0 ]] && [[ $persistent -eq 0 ]]; then
	echo "will not run persistent"
	exit 1
fi
	
shift $((OPTIND-1))

if [[ $# -ge 1 ]]; then 
	echo "too many arguments. Exiting..."
	usage
fi
