#!/bin/sh

ping -c "$2" "$1" &> /dev/null ; echo $?
