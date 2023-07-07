#include "utils.h"

char *insert_key(int id, char *type, char *auxType, struct stack *scopes, char *buffer, int lineno) {
    printf("ID: %d\n", id);
    printf("Type: %s\n", type);

    sprintf(buffer, "%s@%d", top(scopes), id);
    check_declaration(buffer);
    insert(buffer, auxType, type, lineno);
    print_stack(scopes);

    return buffer;
}

void check_declaration(char *id) {
    
}

void *set_symbol_datatype(char *id, char *type) {
    struct bucket *symbol = check_undeclared(id);
    strcpy(symbol->datatype, type);
}

bucket *check_undeclared(char *id) {
    
    struct bucket *symbol;
    
    return symbol;
}

