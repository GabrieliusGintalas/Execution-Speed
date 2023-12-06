#!/bin/bash

#Author: Gabrielius Gintalas
#Date: 11/06/23
#Program name: Assignment 04 - How to use strings
#Email: gabrieliusgintalas@csu.fullerton.edu
#CWID: 885861872

rm -f *.o
rm -f *.out

nasm -f elf64 -l execution.lis -o execution.o execution.asm

# Compile the C file without -fPIE
gcc -c main.c -o main.o

g++ -m64 -g -o executionspeed.out execution.o main.o -fno-pie -no-pie -std=c++17 -lc

./executionspeed.out

rm -f *.o
rm -f *.lis
