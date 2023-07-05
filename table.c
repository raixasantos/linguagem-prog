#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "table.h"

#define MAX_SYMBOLS 100

Symbol symbolTable[MAX_SYMBOLS];
int symbolCount = 0;
int currentScope = 0;

void up() {
    currentScope++;
}

void down() {
    currentScope--;
    if (currentScope < 0) {
        currentScope = 0;
    }
}

int lookup(char* name, Symbol* symb) {
    for (int i = symbolCount - 1; i >= 0; i--) {
        if (strcmp(symbolTable[i].name, name) == 0 && symbolTable[i].scope <= currentScope) {
            *symb = symbolTable[i];
            return 1;
        }
    }
    return 0;
}

int insert(char* name, char* type) {
    if (symbolCount >= MAX_SYMBOLS) {
        printf("Tabela de símbolos está cheia.\n");
        return 0;
    }

    Symbol symbol;
    symbol.name = strdup(name);
    symbol.type = strdup(type);
    symbol.scope = currentScope;

    symbolTable[symbolCount++] = symbol;
    return 1;
}

void print_table() {
    printf("Tabela de símbolos:\n");
    for (int i = 0; i < symbolCount; i++) {
        printf("Nome: %s, Tipo: %s, Escopo: %d\n", symbolTable[i].name, symbolTable[i].type, symbolTable[i].scope);
    }
}

void free_table() {
    for (int i = 0; i < symbolCount; i++) {
        free(symbolTable[i].name);
        free(symbolTable[i].type);
    }
}