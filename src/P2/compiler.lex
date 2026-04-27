%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

%option yylineno

%%

  /* Conditions */
"<"         return LT;
"<="        return LEQ;
">"         return GT;
">="        return GEQ;
"<>"        return NEQ;
"=="        return EQ;

  /* Math */
"+"         return PLUS;
"-"         return MINUS;

  /* Loops */
"while"     return WHILE;
"do"        return DO;
"endwhile"  return ENDWHILE;

  /* Decisions */
"if"        return IF;
"then"      return THEN;
"else"      return ELSE;
"endif"     return ENDIF;

  /* Other */
"="         return ASSIGN;
[a-z]+      return VAR;
[0-9]+      return NUM;
";"         return SEMI;

"\n"        ;
[ ]+        ;
.           return JUNK;

%%
