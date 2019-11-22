bison -d -v makeast.y
flex hlat.l
g++ lex.yy.c makeast.tab.c
./a.out $1 $2
