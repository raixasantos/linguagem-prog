#ifndef TABLE_H
#define TABLE_H

typedef struct symbol{
    char *name;
    char* type;
    int scope;
} Symbol;

void up();
void down();
int lookup(char* name, char* type);
int insert(char* name, char* type);
void print_table();
void free_table();

#endif