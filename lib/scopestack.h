#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct element {
    char* name;
    struct element* next;
} scope_element;

typedef struct stack {
    struct element* head;
    int size;
} scope_stack;

void init_scopes();
void push(char* value);
char* top();
struct element* head();
void pop();
void print_scopes();