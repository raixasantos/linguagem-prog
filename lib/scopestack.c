#include "scopestack.h"

scope_stack* scopes;
int noscopes = 0;

void init_scopes() {
    scopes = (scope_stack*) malloc(sizeof(scope_stack));
    scopes->head = NULL;
}

void push(char* value) {
    scope_element* scope = (scope_element*) malloc(sizeof(scope_element));

    if(scope) {
        char *nameReceived = malloc(strlen(value) + 1);
        if(nameReceived) {
            strcpy(nameReceived, value);
        }
        scope->name = nameReceived;
        scope->next = scopes->head;
        scopes->head = scope;
    }
}

char* increment_noscopes() {
    noscopes++;
    char* noToString = (char*) calloc(256, sizeof(char));
    sprintf(noToString, "%d", noscopes);
    free(noToString);
    return noToString;
}

char* top() {
    char *top = NULL;
    if(scopes && scopes->head) {
        top = scopes->head->name;
    } 
    return top;
}

void pop() {
    if (scopes->head != NULL) {
        scope_element *scopeToDelete = scopes->head;
        scopes->head = scopes->head->next;
        free(scopeToDelete->name);
        free(scopeToDelete);
    }
}

void print_scopes(){
    printf("\n");
    printf("Stack\n");
    printf("--------------------\n");

    scope_element *scope = scopes->head;

    while (scope != NULL)
    {
        printf("%-20s\n", scope->name);
        scope = scope->next;
    }
}