#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "symboltable.h"
#include "scopestack.h"

void initialize();
void insert_symboltab(char* identifier, char* element_name, char* type);
void insert_scope(char* name_scope);
void verify_multipledecls(char* name, int noline);
void verify_declaration(char* name, int noline);