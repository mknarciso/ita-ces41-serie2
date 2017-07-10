#!/bin/bash
flex ex3.l
yacc ex3.y
gcc y.tab.c main.c yyerror.c -o ex3 -ll
./ex3