%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

%option yylineno

%%

  /* Conditions */
"<="        return LEQ;
">="        return GEQ;
"<>"        return NEQ;
"=="        return EQ;
"<"         return LT;
">"         return GT;

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
[a-z]+      { yylval.str = strdup(yytext); return VAR; }
[0-9]+      { yylval.str = strdup(yytext); return NUM; }
";"         return SEMI;

"\n"        ;
[ ]+        ;
.           return JUNK;

%%
