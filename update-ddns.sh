#!/bin/sh

set -e

. update-ddns.conf
#key=""
#hostname=""
#ifnames=""

if [ -n "$1" ]; then
	ifnames=$1
fi

for if in ${ifnames}; do
	ip=$(ifconfig ${if} 2>/dev/null | grep 'inet ' | cut -d ' ' -f 2 | cut -d '/' -f 1)
	if [ -n "${ip}" ]; then
		echo "My IP (${if}): ${ip}"
		break
	fi
done

curl -4 "http://dyn.dns.he.net/nic/update?hostname=${hostname}&password=${key}&myip=${ip}"
echo
