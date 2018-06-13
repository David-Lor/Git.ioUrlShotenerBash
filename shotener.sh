#!/bin/bash

if [ $# -eq 0 ] || [ $1 = "-h" ] || [ $1 = "-help" ] || [ $1 = "--help" ]
then
	echo "This script will short the given URL using Git.io shortener API"
	echo "Usage: shortener.sh <url>"
	echo "Returns the shortened URL"
	exit 0
fi

out=$(curl -s -i https://git.io -F "url=$1")
statusLine=$(echo "$out" | grep 'Status: ')
status=${statusLine//Status: }
statusCode=$(echo $status | tr -dc '0-9')
if [ $statusCode = "201" ]
then
	urlLine=$(echo "$out" | grep 'Location: ')
	url=${urlLine//Location: }
	echo $url
	exit 0
else
	echo "ERROR. Could not generate link!"
	echo "Status reported: $status"
	echo ""
	echo "Output:"
	echo "$out"
	exit 1
fi
