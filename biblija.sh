#!/bin/sh
# kjv: Read the Word of God from your terminal
# License: Public domain

SELF="$0"

get_data() {
	sed '1,/^#EOF$/d' < "$SELF" | tar xzf - -O "$1"
}

if [ -z "$PAGER" ]; then
	if command -v less >/dev/null; then
		PAGER="less"
	else
		PAGER="cat"
	fi
fi

show_help() {
	exec >&2
	echo "korištenje: ./biblija [zastavice] [reference...]"
	echo
        echo "  -l      popis knjiga"
        echo "  -W      bez prelamanja redaka"
        echo "  -h      pomoć"
	echo
        echo "  Tipovi referenci:"
        echo "      <Knjiga>"
        echo "          Individualna knjiga"
        echo "      <Knjiga>:<Poglavlje>"
        echo "          Individualno poglavlje neke knjige"
        echo "      <Knjiga>:<Poglavlje>:<Stih>[,<Stih>]..."
        echo "          Individualni stih(ovi) nekog poglavlja neke knjige"
        echo "      <Knjiga>:<Poglavlje>-<Poglavlje>"
        echo "          Od-do poglavlja neke knjige."
        echo "      <Knjiga>:<Poglavlje>:<Stih>-<Stih>"
        echo "          Od-do stiha nekog poglavlja neke knjige."
        echo "      <Knjiga>:<Poglavlje>:<Stih>-<Poglavlje>:<Stih>"
        echo "          Od stiha iz nekog poglavlja do stiha iz nekog drugog poglavlja"
	echo
        echo "      /<Pojam za pretraživanje>"
        echo "          Svi stihovi koji sadrže pojam za pretraživanje"
        echo "      <Knjiga>/<Pojam za pretraživanje>"
        echo "          Svi stihovi unutar neke knjige koji sadrže pojam za pretraživanje"
        echo "      <Knjiga>:<Poglavlje>/<Pojam za pretraživanje>"
        echo "          Svi stihovi unutar nekog poglavlja neke knjige koji sadrže pojam za pretraživanje"
	exit 2
}

while [ $# -gt 0 ]; do
	isFlag=0
	firstChar="${1%"${1#?}"}"
	if [ "$firstChar" = "-" ]; then
		isFlag=1
	fi

	if [ "$1" = "--" ]; then
		shift
		break
	elif [ "$1" = "-l" ]; then
		# List all book names with their abbreviations
		get_data biblija.tsv | awk -v cmd=list "$(get_data biblija.awk)"
		exit
	elif [ "$1" = "-W" ]; then
		export KJV_NOLINEWRAP=1
		shift
	elif [ "$1" = "-h" ] || [ "$isFlag" -eq 1 ]; then
		show_help
	else
		break
	fi
done

cols=$(tput cols 2>/dev/null)
if [ $? -eq 0 ]; then
	export KJV_MAX_WIDTH="$cols"
fi

if [ $# -eq 0 ]; then
	if [ ! -t 0 ]; then
		show_help
	fi

	# Interactive mode
	while true; do
		printf "biblija> "
		if ! read -r ref; then
			break
		fi
		get_data biblija.tsv | awk -v cmd=ref -v ref="$ref" "$(get_data biblija.awk)" | ${PAGER}
	done
	exit 0
fi

get_data biblija.tsv | awk -v cmd=ref -v ref="$*" "$(get_data biblija.awk)" | ${PAGER}
