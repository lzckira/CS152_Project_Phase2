parse: phase2.lex phase2.y
	rm -f lex.yy.c y.tab.* y.output *.o parser
	bison -v -d --file-prefix=y phase2.y
	flex phase2.lex
	gcc -o parser y.tab.c lex.yy.c -lfl
