#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "symboltable.h"
#include "outrasfuncoes.h"
#include "stack.h"

extern struct stack *scopes;
char buffer[20000];
char auxType[40];
extern int yylineno;

char *insert_key(int id, char *type) {
    printf("ID: %d\n", id);
    printf("Type: %s\n", type);

    sprintf(buffer, "%s@%s", top(scopes), id);
    check_declaration(buffer);
    insert(buffer, auxType, type, yylineno);
    print_stack(scopes);

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

void *set_symbol_datatype(char *id, char *type) {
    struct bucket *symbol = check_undeclared(id);
    strcpy(symbol->datatype, type);
}

bucket *check_undeclared(char *id) {
    
    struct bucket *symbol;
    struct stack_bucket *sb = scopes->head;

    // Se não encontra no escopo atual, busca no próximo
    while (sb != NULL)
    {
        sprintf(buffer, "%s@%s", sb->text, id);
        symbol = lookup(buffer);
        if(symbol == NULL) {
            sb = sb->next;
        } else {
            break;
        }
    }

    if(symbol == NULL) {
        printf("error: em check_underclared\n");
        exit(0);
    }     
    return symbol;
}

