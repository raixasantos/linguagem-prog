#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "table.h"

Symbol* symbolTable;
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

int lookup(char* name, char* type) {
    for(int i=0; i<symbolCount; i++){
        if(strcmp(symbolTable[i].name, name) && symbolTable[i].scope == currentScope){
            return 1;
        }
    }
    return 0;
}

int insert(char* name, char* type) {
    Symbol symbol;
    symbol.name = strdup(name);
    symbol.type = type;
    symbol.scope = currentScope;

    symbolCount++;
    symbolTable = (Symbol*)realloc(symbolTable, sizeof(Symbol) * symbolCount);
    symbolTable[symbolCount - 1] = symbol;
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