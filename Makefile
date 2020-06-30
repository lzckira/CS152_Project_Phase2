lexer: phase1.lex
	flex phase1.lex
	gcc -o lexer lex.yy.c -lfl

clean:
	rm -f lex.yy.c *.o lexer
