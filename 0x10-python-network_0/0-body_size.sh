#!/bin/bash
# script that takes url, send a request and display size of the body curl s silent I header L location(redirection) grep i case
curl -sIL "$1" | grep -i 'Content-Length:' | awk '{print $2}'
