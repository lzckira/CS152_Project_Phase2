%{
int line_num = 1, col_num = 1;
%}

LETTER  [a-zA-Z]
DIGIT [0-9]

%%

"function" 	{return FUNCTION;col_num += yyleng;}
"beginparams" 	{return BEGIN_PARAMS;col_num += yyleng;}
"endparams" 	{return END_PARAMS;col_num += yyleng;}
"beginlocals" 	{return BEGIN_LOCALS;col_num += yyleng;}
"endlocals" 	{return END_LOCALS;col_num += yyleng;}
"beginbody" 	{return BEGIN_BODY;col_num += yyleng;}
"endbody" 	{return END_BODY;col_num += yyleng;}
"integer" 	{return INTEGER;col_num += yyleng;}
"array" 	{return ARRAY;col_num += yyleng;}
"of" 		{return OF;col_num += yyleng;}
"if" 		{return IF;col_num += yyleng;}
"then" 		{return THEN;col_num += yyleng;}
"endif" 	{return ENDIF;col_num += yyleng;}
"else" 		{return ELSE;col_num += yyleng;}
"while" 	{return WHILE;col_num += yyleng;}
"do" 		{return DO;col_num += yyleng;}
"beginloop" 	{return BEGINLOOP;col_num += yyleng;}
"endloop" 	{return ENDLOOP;col_num += yyleng;}
"continue" 	{return CONTINUE;col_num += yyleng;}
"read" 		{return READ;col_num += yyleng;}
"write" 	{return WRITE;col_num += yyleng;}
"and" 		{return AND;col_num += yyleng;}
"or" 		{return OR;col_num += yyleng;}
"not" 		{return NOT;col_num += yyleng;}
"true" 		{return TRUE;col_num += yyleng;}
"false" 	{return FALSE;col_num += yyleng;}
"return" 	{return RETURN;col_num += yyleng;}
"-"  		{return SUB;col_num += yyleng;}
"+"  		{return ADD;col_num += yyleng;}
"*"  		{return MULT;col_num += yyleng;}
"/"  		{return DIV;col_num += yyleng;}
"%"  		{return MOD;col_num += yyleng;}
"=="  		{return EQ;col_num += yyleng;}
"<>" 		{return NEQ;col_num += yyleng;}
"<"  		{return LT;col_num += yyleng;}
">"  		{return GT;col_num += yyleng;}
"<=" 		{return LTE;col_num += yyleng;}
">=" 		{return GTE;col_num += yyleng;}
{LETTER}({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)* 	{return IDENT;yylval.ival = atoi(yytext);col_num += yyleng;}

{DIGIT}+{LETTER}+({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)*(_)*  	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", line_num, col_num, yytext); exit(0);}
{LETTER}({LETTER}|{DIGIT})*(_({LETTER}|{DIGIT})+)*(_)+ 	{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", line_num, col_num, yytext); exit(0);}

{DIGIT}+   	{return NUMBER; yylval.dval = atof(yytext);col_num += yyleng;}
";"  		{return SEMICOLON;col_num += yyleng;} 
":"  		{return COLON;col_num += yyleng;}
","  		{return COMMA;col_num += yyleng;} 
"("  		{return L_PAREN;col_num += yyleng;} 
")"  		{return R_PAREN;col_num += yyleng;} 
"["  		{return L_SQUARE_BRACKET;col_num += yyleng;} 
"]"  		{return R_SQUARE_BRACKET;col_num += yyleng;} 
":=" 		{return ASSIGN;col_num += yyleng;}
(##(.)*\n) 	{line_num++, col_num=1;}


[ \t]+ 		{/* ignore space or tab  */col_num += yyleng;}

"\n" 		{line_num++, col_num=1;}


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

