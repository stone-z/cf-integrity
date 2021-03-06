#!/bin/bash

cc -c ../whitelist/snippet.c
clang-3.9 -g -emit-llvm  tetris.c -c -o tetris.bc
opt-3.9 -load whitelist/libWhiteListPass.so -whitelist -sf place -sf update -sf show_high_score -sf freeze -sf show_online_help -sf fits_in < tetris.bc > tetris_result.bc
llc-3.9 -filetype=obj ./tetris_result.bc
cc -g -rdynamic tetris_result.o snippet.o -L/usr/lib/gcc/x86_64-linux-gnu/5 -lbacktrace
