%{
int line_num = 1, col_num = 1;
%}

LETTER  [a-zA-Z]
DIGIT [0-9]

%%

"function" 								{col_num += yyleng; return FUNCTION;}
"beginparams" 								{col_num += yyleng; return BEGIN_PARAMS;}
"endparams" 								{col_num += yyleng; return END_PARAMS;}
"beginlocals" 								{col_num += yyleng; return BEGIN_LOCALS;}
"endlocals" 								{col_num += yyleng; return END_LOCALS;}
"beginbody" 								{col_num += yyleng; return BEGIN_BODY;}
"endbody" 								{col_num += yyleng; return END_BODY;}
"integer" 								{col_num += yyleng; return INTEGER;}
"array" 								{col_num += yyleng; return ARRAY;}
"of" 									{col_num += yyleng; return OF;}
"if" 									{col_num += yyleng; return IF;}
"then" 									{col_num += yyleng; return THEN;}
"endif" 								{col_num += yyleng; return ENDIF;}
"else" 									{col_num += yyleng; return ELSE;}
"while" 								{col_num += yyleng; return WHILE;}
"do" 									{col_num += yyleng; return DO;}
"beginloop" 								{col_num += yyleng; return BEGINLOOP;}
"endloop" 								{col_num += yyleng; return ENDLOOP;}
"continue" 								{col_num += yyleng; return CONTINUE;}
"read" 									{col_num += yyleng; return READ;}
"write" 								{col_num += yyleng; return WRITE;}
"and" 									{col_num += yyleng; return AND;}
"or" 									{col_num += yyleng; return OR;}
"not" 									{col_num += yyleng; return NOT;}
"true" 									{col_num += yyleng; return TRUE;}
"false" 								{col_num += yyleng; return FALSE;}
"return" 								{col_num += yyleng; return RETURN;}
"-"  									{col_num += yyleng; return SUB;}
"+"  									{col_num += yyleng; return ADD;}
"*"  									{col_num += yyleng; return MULT;}
"/"  									{col_num += yyleng; return DIV;}
"%"  									{col_num += yyleng; return MOD;}
"=="  									{col_num += yyleng; return EQ;}
"<>" 									{col_num += yyleng; return NEQ;}
"<"  									{col_num += yyleng; return LT;}
">"  									{col_num += yyleng; return GT;}
"<=" 									{col_num += yyleng; return LTE;}
">=" 									{col_num += yyleng; return GTE;}
{LETTER}({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)* 			{yylval.id_val = atoi(yytext); col_num += yyleng; return IDENT;}
{DIGIT}+{LETTER}+({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)*(_)*  	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", line_num, col_num, yytext); exit(0);}
{LETTER}({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)*(_)+ 			{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", line_num, col_num, yytext); exit(0);}
{DIGIT}+   								{yylval.ival = atof(yytext); col_num += yyleng; return NUMBER;}
";"  									{col_num += yyleng; return SEMICOLON;} 
":"  									{col_num += yyleng; return COLON;}
","  									{col_num += yyleng; return COMMA;} 
"("  									{col_num += yyleng; return L_PAREN;} 
")"  									{col_num += yyleng; return R_PAREN;} 
"["  									{col_num += yyleng; return L_SQUARE_BRACKET;} 
"]"  									{col_num += yyleng; return R_SQUARE_BRACKET;} 
":=" 									{col_num += yyleng; return ASSIGN;}
(##(.)*\n) 								{line_num++, col_num=1;}
[ \t]+ 									{/* ignore space or tab  */col_num += yyleng;}
"\n" 									{line_num++, col_num=1;}


. {printf("Error at Line %d column %d :\"%s\" is an unrecognized symbol\n", line_num, col_num, yytext);exit(0);}

%%

int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
      yyin = fopen(argv[1], "r");
      if(yyin == NULL)
      {
        printf("Error: Input file not exist\n");
	exit(0);
      }
   }
   else
   {
      yyin = stdin;
   }
   yylex();
}

