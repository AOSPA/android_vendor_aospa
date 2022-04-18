#!/bin/bash
stty -echo 2> /dev/null

numcolors=${COLORTERM}
timeout=0.25

path=$ANDROID_BUILD_TOP/vendor/aospa/logo/

if [ "${numcolors}" == "" ]; then
    numcolors=256;
fi

# ARE WE SIXELS?
IFS=";?c" read -a REPLY -s -t 1 -d "c" -p $'\e[c' >&2

for code in "${REPLY[@]}"; do
    if [[ $code == "4" ]]; then
	cat ${path}AOSPA.sixels;
        echo -n $'\e\\';# Escape sequence to stop SIXEL.
        stty echo;	# Reset terminal to show characters.
	exit 0;
    fi
done

# ARE WE CAN HAZ COLOURS?
IFS=";"  read -a REPLY -s -t ${timeout} -d "S" -p $'\e[?1;1;0S' >&2

[[ ${REPLY[1]} == "0" ]] && numcolors=${REPLY[2]}

if [ -f ${path}AOSPA.${numcolors} ]; then
    cat ${path}AOSPA.${numcolors};
    stty echo;	# Reset terminal to show characters.
    exit 0;
fi
