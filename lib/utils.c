#include "utils.h"

void initialize() {
    init_scopes();
    int symboltableSize = 200;
    create_symboltable(symboltableSize);
}

void insert_scope(char* name_scope) {
    push(name_scope);
    print_scopes(); 
}

void verify_multipledecls(char* name, int noline) {
    symbol_attributes* symbolchecked = get_symbol(name);

    char* string = strdup(name);
    char* token = strtok(string, "&");
    token = strtok(NULL, "&");

    if(symbolchecked != NULL) {
        printf("error: multiple declaration of '%s' at line %d\n", token, noline);
        exit(0);
    }  
}

void verify_declaration(char* name, int noline) {
    symbol_attributes* symboltofind;
    struct element* scoperesearched = head();

    // Se não encontra no escopo atual, busca no próximo
    while (scoperesearched != NULL)
    {
        char* buffer = malloc(strlen(scoperesearched->name));
        strcpy(buffer, strdup(scoperesearched->name));
        strcat(buffer, "&");
        strcat(buffer, strdup(name));
        symboltofind = get_symbol(buffer);
        if(symboltofind == NULL) {
            scoperesearched = scoperesearched->next;
        } else {
            break;
        }
    }

    if(symboltofind == NULL) {
        printf("error: '%s' undeclared at line %d\n", name, noline);
        exit(0);
    } 
    if(symboltofind != NULL) { // TODO: remover
        printf("\n(id: %s, element: %s, type: %s, scope: %s)\n", symboltofind->identifier, symboltofind->element_name,
            symboltofind->type, symboltofind->scope);
    }

}

void insert_symboltab(char* identifier, char* element_name, char* type) {
    symbol_attributes* attributes = (symbol_attributes*)malloc(sizeof(symbol_attributes));
    attributes->identifier = strdup(identifier);
    attributes->element_name = strdup(element_name);
    attributes->scope = strdup(top());
    attributes->type = strdup(type);

    char* key = strdup(top()); 
    strcat(key,"&");
    strcat(key, strdup(identifier));
    insert_symbol(key, attributes);
    print_symboltable();
}