#!/bin/bash

set -eo pipefail

JTALK_DICTIONARY=/var/lib/mecab/dic/open-jtalk/naist-jdic 

if [ -z "$JTALK_VOICE_FILE" ]; then
  if [ -z "$JTALK_VOICE_TYPE" ] ; then
    JTALK_VOICE_TYPE=normal
  fi
  if [ "`expr "$JTALK_VOICE_TYPE" : '^\(normal\|angry\|bashful\|happy\|sad\)$'`" ]; then
    :
  else
    echo 2>&1 "$JTALK_VOICE_TYPE is invalid. any in [normal / angry / bashful / happy / sad]"
    exit 1;
  fi
  JTALK_VOICE_FILE="/jtalk/hts-voice/mei_$JTALK_VOICE_TYPE.htsvoice"
fi
 
if [ -z "JTALK_OPTIONS" ]; then
  JTALK_OPTIONS="-s 48000 -s 48000 -p 300 -u 0.5 -jm 0.5 -jf 0.5"
fi

if [ -z "$JTALK_OUTPUT" ]; then
  outfile=`mktemp`
else
  outfile="$JTALK_OUTPUT"
fi

if [ -p /dev/stdin ]; then
  cat -
else
  if [ -z "$1" ]; then
    exit 1;
  fi
  echo $1 
fi | open_jtalk \
          -x $JTALK_DICTIONARY \
          -m $JTALK_VOICE_FILE \
          $JTALK_OPTIONS -ow $outfile
if [ -z "$JTALK_OUTPUT" ] ; then 
  cat $outfile ; rm -f $outfile
fi
