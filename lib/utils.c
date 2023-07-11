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

void verify_declaration(char* name, int noline) {
    symbol_attributes* symbolchecked = get_symbol(name);

    char* string = strdup(name);
    char* token = strtok(string, "&");
    token = strtok(NULL, "&");

    if(symbolchecked != NULL) {
        printf("error: multiple declaration of '%s' at line %d\n", token, noline);
        exit(0);
    }     
}

void insert_symboltab(char* identifier, char* element_name, char* type) {
    symbol_attributes* attributes = (symbol_attributes*)malloc(sizeof(symbol_attributes));
    attributes->identifier = identifier;
    attributes->element_name = element_name;
    attributes->scope = top();
    attributes->type = type;

    char* key = strdup(top()); 
    strcat(key,"&");
    strcat(key, strdup(identifier));
    insert_symbol(key, attributes);
    print_symboltable();
}