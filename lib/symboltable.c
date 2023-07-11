#include "symboltable.h"

hashtable* symboltable;

// Função para criar a hashtable
void create_symboltable(int size) {
    symboltable = (hashtable*)malloc(sizeof(hashtable));
    symboltable->size = size;
    symboltable->buckets = (symbol**)malloc(size * sizeof(symbol*));
  
    // Inicializa cada bucket como NULL
    for (int i = 0; i < size; i++) {
        symboltable->buckets[i] = NULL;
    }
}

unsigned int generate_hash(char* key) {
    unsigned int hash = 5381;
    int c;
    while ((c = *key++) != 0)
        hash = ((hash << 5) + hash) + c;
    return hash % symboltable->size;
}

void insert_symbol(char* key, symbol_attributes* attributes) {
    // Calcula o índice do bucket com base na chave    
    int index = generate_hash(key);

    // Cria um novo nó-símbolo
    symbol_attributes* attributesReceived = attributes;

    symbol* newSymbol = (symbol*)malloc(sizeof(symbol));
    newSymbol->key = key;
    newSymbol->attributes = attributesReceived;
    newSymbol->next = NULL;

    // Insere o nó no início da lista ligada do bucket correspondente
    if (symboltable->buckets[index] == NULL) {
        symboltable->buckets[index] = newSymbol;
    } else {
        symbol* current = symboltable->buckets[index];
        while (current->next != NULL) {
            current = current->next;
        }
        current->next = newSymbol;
    }
}

// Função para obter um valor da hashtable com base na chave
symbol_attributes* get_symbol(char* key) {
    // Calcula o índice do bucket com base na chave
    int index = generate_hash(key);

    // Percorre a lista ligada do bucket correspondente para encontrar o valor
    symbol* current = symboltable->buckets[index];
    while (current != NULL) {
        if (current->key == key) { // ver se vai ser por escopo&id ou id
            return current->attributes;
        }
        current = current->next;
    }

    // Retorna NULL se a chave não for encontrada
    return NULL;
}

// Função para imprimir os elementos da hashtable
void print_symboltable() {
    printf("\n");
    printf("Symbol Table\n");
    printf("--------------------\n");
    for (int i = 0; i < symboltable->size; i++) {
        printf("Bucket %d: ", i);
        symbol* current = symboltable->buckets[i];
        while (current != NULL) {
            printf("(%s, id: %s, element: %s, type: %s, scope: %s) ", current->key, current->attributes->identifier, current->attributes->element_name,
            current->attributes->type, current->attributes->scope);
            current = current->next;
        }
        printf("\n");
    }

    printf("--------------------\n");
}

/*
int main() {
    int hashtableSize = 200;
    create_symboltable(hashtableSize);

    // Inserção de elementos
    insert_symbol("main&var1", "var1", "main", "float");
    insert_symbol("global&varglob", "varglob", "global", "string");
    insert_symbol("ifsingle&i", "i", "ifsingle", "int");
    insert_symbol("ifsingle&i", "i", "ifsingle", "int");
    insert_symbol("else&var2", "var2", "else", "bool");
    insert_symbol("global&varText", "varText", "global", "float");  // Chave duplicada para ilustrar colisão

    // Impressão dos elementos
    print_symboltable();

    // Busca de símbolo por scopo
    symbol_attributes* value1;
    value1 = get_symbol("main&var1");
    symbol_attributes* value2;
    value2 = get_symbol("global&varglob");
    symbol_attributes* value3; 
    value3 = get_symbol("ifsingle&i");
    symbol_attributes* value4;
    value4 = get_symbol("else&var2");

    printf("Valor encontrado para chave main&var1: %s\n", value1->identifier);
    printf("Valor encontrado para chave global&varglob: %s\n", value2->identifier);
    printf("Valor encontrado para chave ifsingle&i: %s\n", value3->identifier);
    printf("Valor encontrado para chave else&var2: %s\n", value4->identifier);

    free(value1);
    free(value2);
    free(value3);
    free(value4);

    // Libera a memória alocada
    for (int i = 0; i < symboltable->size; i++) {
        symbol* current = symboltable->buckets[i];
        while (current != NULL) {
            symbol* next = current->next;
            free(current);
            current = next;
        }
    }
    free(symboltable->buckets);
    free(symboltable);

    return 0;
}
*/
