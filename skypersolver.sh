#!/usr/bin/env bash 
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"


echo -e "$COL_RED Please enter skype username $COL_RESET"
read username
echo -e "$COL_BLUE Please wait. We are resoving I.P. $COL_RESET"
curl --silent 'http://resolveme.org/index.php?do=resolve' -H 'Host: resolveme.org' -H 'User-Agent: Mozilla/5.0 (X11; Linux i686; rv:27.0) Gecko/20100101 Firefox/27.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Accept-Encoding: gzip, deflate' -H 'Referer: http://resolveme.org/' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Content-Type: application/x-www-form-urlencoded' --data "skypePseudo=$username" > out

if [[ -n $(cat out | grep Erreur) ]]; then
    echo "Error: Please try again later."
    rm out
else
cat out | grep IP: > temp1
rm out
ip=$(grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' temp1)
rm temp1
echo -e "$COL_YELLOW $username 's I.P is $ip $COL_RESET"
fi
