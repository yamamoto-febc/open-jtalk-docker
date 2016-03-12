#!/bin/bash

set -eo pipefail

JTALK_DICTIONARY=/var/lib/mecab/dic/open-jtalk/naist-jdic 
JTALK_VOICE=/jtalk/hts-voice/mei_normal.htsvoice 
JTALK_OPTIONS="-s 48000 -s 48000 -p 300 -u 0.5 -jm 0.5 -jf 0.5"

tmpfile=`mktemp`
if [ -p /dev/stdin ]; then
  cat -
else
  if [ -z "$1" ]; then
    exit 1;
  fi
  echo $1 
fi | open_jtalk \
          -x $JTALK_DICTIONARY \
          -m $JTALK_VOICE \
          $JTALK_OPTIONS -ow $tmpfile
#cp $tmpfile ./test.wav
cat $tmpfile ; rm -f $tmpfile
