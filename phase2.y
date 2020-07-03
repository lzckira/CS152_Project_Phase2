/*
Xiaojun He
Zhangcheng Liang
*/

%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *msg);
extern int line_num;
extern int col_num;
FILE * yyin;
%}

%union{
	int ival;
	string* id_val;
}

%start prog_start

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY
%token OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN
%token SUB ADD MULT DIV MOD
%token EQ NEQ LT GT LTE GTE
%token <ival> NUMBER
%token <id_val> IDENT
%token SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN

%%

