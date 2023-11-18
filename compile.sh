#!/bin/sh

docker run --rm -it \
  -v $(pwd)/gamemodes:/samp \
  -v $(pwd)/pawno:/pawno \
  -w /samp \
  sheenidgs/samp_pawncc_win32:0.3.DL-R1 wine start /pawno/pawncc.exe dev.pwn -odev.amx -d3 -";" -"(" -rcompile.info.log -ecompile.error.log 2> errors.txt && ls -lah && cat compile.error.log
