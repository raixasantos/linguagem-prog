#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct element {
    char* name;
    struct element *next;
} scope_element;

typedef struct stack {
    struct element *head;
} scope_stack;

void init_scopes();
void push(char* value);
char* increment_noscopes();
char* top();
void pop();
void print_scopes();