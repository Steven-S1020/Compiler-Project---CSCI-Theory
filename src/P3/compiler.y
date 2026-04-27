%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern int yylex();
extern int yylineno;
extern char *yytext;
void yyerror(char *);

int whilenum = 1;
int ifnum = 1;

int currentWhile = 0;
int currentIf = 0;
int condMode = 0;   /* 1 = while, 2 = if */
%}

%token LT LEQ GT GEQ NEQ EQ
%token PLUS MINUS
%token WHILE DO ENDWHILE
%token IF THEN ELSE ENDIF
%token ASSIGN SEMI
%token RETURN JUNK

%union {
    char *str;
}

%token <str> VAR NUM
%type <str> operand operator condition

%left PLUS MINUS

%%

prog: stmts ;

stmts:
      stmt
    | stmt stmts
    ;

stmt:
      assignment
    | while_stmt
    | if_stmt
    ;



/* ASSIGNMENTS */

assignment:
      VAR ASSIGN operand SEMI
      {
          printf("\tMOV R1, %s\n", $3);
          printf("\tMOV %s, R1\n", $1);
      }
    | VAR ASSIGN expr SEMI
      {
          printf("\tMOV %s, R1\n", $1);
      }
    ;



/* EXPRESSIONS */

expr:
      operand operator operand
      {
          printf("\tMOV R1, %s\n", $1);
          printf("\t%s R1, %s\n", $2, $3);
      }
    | expr operator operand
      {
          printf("\t%s R1, %s\n", $2, $3);
      }
    ;

operand:
      NUM { $$ = $1; }
    | VAR { $$ = $1; }
    ;

operator:
      PLUS  { $$ = "ADD"; }
    | MINUS { $$ = "SUB"; }
    ;



/* WHILE */

while_stmt:
      WHILE
      {
          currentWhile = whilenum++;
          condMode = 1;
          printf("wtop%d:  \n", currentWhile);
      }
      conditional
      DO
      stmts
      ENDWHILE SEMI
      {
          printf("        JMP wtop%d\n", currentWhile);
          printf("end%d:\n", currentWhile);
      }
    ;



/* IF */

if_stmt:
      IF
      {
          currentIf = ifnum++;
          condMode = 2;
      }
      conditional
      THEN
      stmts
      if_end
    ;

if_end:
      ENDIF SEMI
      {
          printf("end%d:\n", currentIf);
      }
    | ELSE
      {
          printf("        JMP end%d\n", currentIf);
          printf("else%d:\n", currentIf);
      }
      stmts
      ENDIF SEMI
      {
          printf("end%d:\n", currentIf+1);
      }
    ;



/* CONDITIONALS */

conditional:
      operand condition operand
      {
          printf("        MOV R8, %s\n", $1);
          printf("        MOV R7, %s\n", $3);
          printf("        CMP R7\n");

          if(condMode == 1)
              printf("        %s end%d\n", $2, currentWhile);
          else
              printf("        %s else%d\n", $2, currentIf);
      }
    ;

condition:
      LT  { $$ = "BGE"; }
    | LEQ { $$ = "BGT"; }
    | GT  { $$ = "BLE"; }
    | GEQ { $$ = "BLT"; }
    | NEQ { $$ = "BEQ"; }
    | EQ  { $$ = "BNE"; }
    ;

%%

int main()
{
    yyparse();
    return 0;
}

void yyerror(char *s)
{
    printf("syntax error line %d\n", yylineno);
}
