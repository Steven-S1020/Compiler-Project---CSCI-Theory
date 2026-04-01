%{
#include <stdio.h>
%}

%%

  /* Conditions */
"<"         printf("LT\n");
"<="        printf("LEQ\n");
">"         printf("GT\n");
">="        printf("GEQ\n");
"<>"        printf("NEQ\n");
"=="        printf("EQUAL\n");

  /* Math */
"+"         printf("PLUS\n");
"-"         printf("MINUS\n");

  /* Loops */
"while"     printf("WHILE\n");
"do"        printf("DO\n");
"endwhile"  printf("ENDWHILE\n");

  /* Decisions */
"if"        printf("IF\n");
"then"      printf("THEN\n");
"else"      printf("ELSE\n");
"endif"     printf("ENDIF\n");

  /* Other */
[a-z]+      printf("VAR\n");
[0-9]+      printf("NUM\n");
";"         printf("SEMI\n");

"\n"        ;
[ ]+        ;
.           printf("JUNK\n");

%%

int main()
{
  while (yylex());
}
