#!/bin/sh

set -e

key=""

hostname=""

ifnames="lagg0 ue0 wlan0"

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
