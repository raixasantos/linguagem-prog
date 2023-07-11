#include "scopestack.h"

scope_stack* scopes;

void init_scopes() {
    scopes = (scope_stack*) malloc(sizeof(scope_stack));
    scopes->head = NULL;
}

void push(char* value) {
    scope_element* scope = (scope_element*) malloc(sizeof(scope_element));

    if(scope) {
        char *nameReceived = malloc(strlen(value) + 1);
        if(nameReceived) {
            strcpy(nameReceived, strdup(value));
        }
        char scopes_sizestr[50];
        sprintf(scopes_sizestr, "#%d", scopes->size);
        strcat(nameReceived, scopes_sizestr);
        scope->name = strdup(nameReceived);
        scope->next = scopes->head;
        scopes->head = scope;
        scopes->size++;
    }
}

char* top() {
    char *top = NULL;
    if(scopes && scopes->head) {
        top = strdup(scopes->head->name);
    } 
    return top;
}

struct element* head() {
    struct element *head = NULL;
    if(scopes && scopes->head) {
        head = scopes->head;
    } 
    return head;
}

void pop() {
    if (scopes->head != NULL) {
        scope_element *scopeToDelete = scopes->head;
        scopes->head = scopes->head->next;
        scopes->size--;
        free(scopeToDelete->name);
        free(scopeToDelete);
    }
}

void print_scopes(){
    printf("\n");
    printf("Scopes Stack\n");
    printf("--------------------\n");

    scope_element *scope = scopes->head;

    while (scope != NULL)
    {
        printf("%-20s\n", strdup(scope->name));
        scope = scope->next;
    }
    
    printf("--------------------\n");
}