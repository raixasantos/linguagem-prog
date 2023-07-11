#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Attributes {
    char* identifier;
    char* element_name;
    char* type;
    char* scope;
} symbol_attributes;

typedef struct Symbol {
    char* key;
    symbol_attributes* attributes;
    struct Symbol* next;
} symbol;

typedef struct Hashtable {
    int size;
    symbol** buckets;
} hashtable;


void create_symboltable(int size);
unsigned int generate_hash(char* key);
void insert_symbol(char* key, symbol_attributes* attributes);
symbol_attributes* get_symbol(char* key);
void print_symboltable();
