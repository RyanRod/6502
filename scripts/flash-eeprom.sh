#!/bin/bash
set -e # Exit on error
set -u # Exit on unset var

if [[ -z ${1:-} ]]; then
  echo "Please specify a binary file!"
  exit 1
fi

minipro -p AT28C256 -w $1
