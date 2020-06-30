%{
int line_num = 1, col_num = 1;
%}

LETTER  [a-zA-Z]
DIGIT [0-9]

%%

"function" {printf("FUNCTION\n");col_num += yyleng;}
"beginparams" {printf("BEGIN_PARAMS\n");col_num += yyleng;}
"endparams" {printf("END_PARAMS\n");col_num += yyleng;}
"beginlocals" {printf("BEGIN_LOCALS\n");col_num += yyleng;}
"endlocals" {printf("END_LOCALS\n");col_num += yyleng;}
"beginbody" {printf("BEGIN_BODY\n");col_num += yyleng;}
"endbody" {printf("END_BODY\n");col_num += yyleng;}
"integer" {printf("INTEGER\n");col_num += yyleng;}
"array" {printf("ARRAY\n");col_num += yyleng;}
"of" {printf("OF\n");col_num += yyleng;}
"if" {printf("IF\n");col_num += yyleng;}
"then" {printf("THEN\n");col_num += yyleng;}
"endif" {printf("ENDIF\n");col_num += yyleng;}
"else" {printf("ELSE\n");col_num += yyleng;}
"while" {printf("WHILE\n");col_num += yyleng;}
"do" {printf("DO\n");col_num += yyleng;}
"beginloop" {printf("BEGINLOOP\n");col_num += yyleng;}
"endloop" {printf("ENDLOOP\n");col_num += yyleng;}
"continue" {printf("CONTINUE\n");col_num += yyleng;}
"read" {printf("READ\n");col_num += yyleng;}
"write" {printf("WRITE\n");col_num += yyleng;}
"and" {printf("AND\n");col_num += yyleng;}
"or" {printf("OR\n");col_num += yyleng;}
"not" {printf("NOT\n");col_num += yyleng;}
"true" {printf("TRUE\n");col_num += yyleng;}
"false" {printf("FALSE\n");col_num += yyleng;}
"return" {printf("RETURN\n");col_num += yyleng;}
"-"  {printf("SUB\n");col_num += yyleng;}
"+"  {printf("ADD\n");col_num += yyleng;}
"*"  {printf("MULT\n");col_num += yyleng;}
"/"  {printf("DIV\n");col_num += yyleng;}
"%"  {printf("MOD\n");col_num += yyleng;}
"=="  {printf("EQ\n");col_num += yyleng;}
"<>" {printf("NEQ\n");col_num += yyleng;}
"<"  {printf("LT\n");col_num += yyleng;}
">"  {printf("GT\n");col_num += yyleng;}
"<=" {printf("LTE\n");col_num += yyleng;}
">=" {printf("GTE\n");col_num += yyleng;}
{LETTER}({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)* 	{printf("IDENT %s\n", yytext);col_num += yyleng;}

{DIGIT}+{LETTER}+({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)*(_)*  	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", line_num, col_num, yytext); exit(0);}
{LETTER}({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)*(_)+ 	{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", line_num, col_num, yytext); exit(0);}

{DIGIT}+   {printf("NUMBER %s\n",yytext);col_num += yyleng;}
";"  {printf("SEMICOLON\n");col_num += yyleng;} 
":"  {printf("COLON\n");col_num += yyleng;}
","  {printf("COMMA\n");col_num += yyleng;} 
"("  {printf("L_PAREN\n");col_num += yyleng;} 
")"  {printf("R_PAREN\n");col_num += yyleng;} 
"["  {printf("L_SQUARE_BRACKET\n");col_num += yyleng;} 
"]"  {printf("R_SQUARE_BRACKET\n");col_num += yyleng;} 
":=" {printf("ASSIGN\n");col_num += yyleng;}
(##(.)*\n) {line_num++, col_num=1;}


[ \t]+ {/* ignore space or tab  */col_num += yyleng;}

"\n" {line_num++, col_num=1;}


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

