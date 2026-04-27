[private]
default:
    @just --list --list-heading $'Actions:\n' --no-aliases

[group('Build')]
build-P1:
    @echo "Building P1..."
    @flex -o src/P1/lex.yy.c src/P1/compiler.lex
    @cc src/P1/lex.yy.c -lfl -o src/P1/a.out

[group('Build')]
build-P2:
    @echo "Building P2..."
    @flex -o src/P2/lex.yy.c src/P2/compiler.lex
    @yacc -d -b src/P2/y src/P2/compiler.y
    @cc src/P2/lex.yy.c src/P2/y.tab.c -lfl -o src/P2/a.out

[group('Build')]
build-P3:
    @echo "Building P3..."
    @flex -o src/P3/lex.yy.c src/P3/compiler.lex
    @yacc -d -b src/P3/y src/P3/compiler.y
    @cc src/P3/lex.yy.c src/P3/y.tab.c -lfl -o src/P3/a.out

[group('Build')]
build-all: build-P1 build-P2 build-P3
    @echo "All projects built."

[group('Test')]
test-P1:
    @echo "Testing P1..."
    @cat tests/test-P1.txt | src/P1/a.out

[group('Test')]
test-P2:
    @echo "Testing P2..."
    @cat tests/test-P2.txt | src/P2/a.out

[group('Test')]
test-P3:
    @echo "Testing P3..."
    @cat tests/test-P3.txt | src/P3/a.out

[group('Clean')]
clean-P1:
    @echo "Cleaning P1..."
    @rm -f src/P1/a.out
    @rm -f src/P1/lex.yy.c

[group('Clean')]
clean-P2:
    @echo "Cleaning P2..."
    @rm -f src/P2/a.out
    @rm -f src/P2/lex.yy.c
    @rm -f src/P2/y.tab.h

[group('Clean')]
clean-P3:
    @echo "Cleaning P3..."
    @rm -f src/P3/a.out
    @rm -f src/P3/lex.yy.c
    @rm -f src/P3/y.tab.c

[group('Clean')]
clean-all: clean-P1 clean-P2 clean-P3
    @echo "All projects cleaned."
