#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "symboltable.h"
#include "outrasfuncoes.h"

extern struct stack *scopes;
char buffer[20000];
char auxType[40];
extern int yylineno;


char *insert_key(int id, char *type) {
    sprintf(buffer, "%s@%s", top(scopes), id);
    check_declaration(buffer);
    insert(buffer, auxType, type, yylineno);
    return buffer;
}

void check_declaration(char *id) {
    bucket *symbol = lookup(id);

    char * string = strdup(id);
    char * token = strtok(string, "@");
    token = strtok(NULL, "@");

    if(symbol != NULL) {
        printf("error: em funcao check_declaration\n");
        exit(0);
    }     
}

