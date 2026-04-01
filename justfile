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
    # your P2 build command here

[group('Build')]
build-P3:
    @echo "Building P3..."
    # your P3 build command here

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

[group('Test')]
test-P3:
    @echo "Testing P3..."

[group('Clean')]
clean-P1:
    @echo "Cleaning P1..."
    @rm -f src/P1/lex.yy.c
    @rm -f src/P1/a.out

[group('Clean')]
clean-P2:
    @echo "Cleaning P2..."

[group('Clean')]
clean-P3:
    @echo "Cleaning P3..."

[group('Clean')]
clean-all: clean-P1 clean-P2 clean-P3
    @echo "All projects cleaned."
