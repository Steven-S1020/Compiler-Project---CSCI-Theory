%{
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;
void yyerror(char *);

int numval=0;
%}

  /* Tokens */
%token LT LEQ GT GEQ NEQ EQ
%token PLUS MINUS
%token WHILE DO ENDWHILE
%token IF THEN ELSE ENDIF
%token ASSIGN VAR NUM SEMI
%token RETURN JUNK

%%

prog:         stmts ;

stmts:        stmt
              | stmt stmts
              ;

stmt:         assignment
              | if_stmt
              | while_stmt
              ;

assignment:   VAR ASSIGN expr SEMI                    { printf("valid assignment\n"); }
              ;


  /* While Statement */
while_stmt:   WHILE conditional DO stmts ENDWHILE SEMI  { printf("valid while\n"); }
              ;


  /* If Statement */
if_stmt:      if_start if_end ;

if_start:     IF conditional THEN stmts ;

if_end:       ENDIF SEMI                              { printf("valid if then\n"); }
              | ELSE stmts ENDIF SEMI                 { printf("valid if then else\n"); }
              ;


  /* Expression */
expr:         operand operator operand
              | operand
              ;

operand:      NUM
              | VAR
              ;

operator:     PLUS
              | MINUS
              ;


  /* Conditionals */
conditional:  VAR condition VAR
              | NUM condition NUM
              ;

condition:    LT
              | LEQ
              | GT
              | GEQ
              | NEQ
              | EQ
              ;


  /* Error */

%%

int main()
{
  yyparse();
}

void yyerror (char *)
{
  printf("syntax error line %d\n", yylineno);
}
