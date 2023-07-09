#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "symboltable.h"
#include "scopestack.h"

char *insert_key(int id, char *type, char *auxType, struct stack *scopes, char *buffer, int lineno);
void check_declaration(char *id);
void *set_symbol_datatype(char *id, char *type);
bucket *check_undeclared(char *id);
