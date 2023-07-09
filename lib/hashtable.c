#include <stdio.h>
#include <stdlib.h>

// Estrutura do nó da lista ligada
struct Symbol {
    int key;
    int value;
    struct Symbol* next;
};

// Estrutura da hashtable
struct Hashtable {
    int size;
    struct Symbol** buckets;
};

struct Hashtable* hashtable;

// Função para criar uma hashtable
void createHashtable(int size) {
    hashtable = (struct Hashtable*)malloc(sizeof(struct Hashtable));
    hashtable->size = size;
    hashtable->buckets = (struct Symbol**)malloc(size * sizeof(struct Symbol*));
  
    // Inicializa cada bucket como NULL
    for (int i = 0; i < size; i++) {
        hashtable->buckets[i] = NULL;
    }
}

// Função para inserir um valor na hashtable
void insert(int key, int value) {
    // Calcula o índice do bucket com base na chave
    int index = key % hashtable->size;

    // Cria um novo nó
    struct Symbol* newSymbol = (struct Symbol*)malloc(sizeof(struct Symbol));
    newSymbol->key = key;
    newSymbol->value = value;
    newSymbol->next = NULL;

    // Insere o nó no início da lista ligada do bucket correspondente
    if (hashtable->buckets[index] == NULL) {
        hashtable->buckets[index] = newSymbol;
    } else {
        struct Symbol* current = hashtable->buckets[index];
        while (current->next != NULL) {
            current = current->next;
        }
        current->next = newSymbol;
    }
}

// Função para obter um valor da hashtable com base na chave
int get(int key) {
    // Calcula o índice do bucket com base na chave
    int index = key % hashtable->size;

    // Percorre a lista ligada do bucket correspondente para encontrar o valor
    struct Symbol* current = hashtable->buckets[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }

    // Retorna -1 se a chave não for encontrada
    return -1;
}

// Função para imprimir os elementos da hashtable
void printHashtable() {
    for (int i = 0; i < hashtable->size; i++) {
        printf("Bucket %d: ", i);
        struct Symbol* current = hashtable->buckets[i];
        while (current != NULL) {
            printf("(%d, %d) ", current->key, current->value);
            current = current->next;
        }
        printf("\n");
    }
}

int main() {
    int hashtableSize = 200;
    createHashtable(hashtableSize);

    // Inserção de elementos
    insert(15, 150);
    insert(7, 70);
    insert(25, 250);
    insert(33, 330);
    insert(7, 71);  // Chave duplicada para ilustrar colisão

    // Impressão dos elementos
    printHashtable();

    // Busca de valores
    int value1 = get(15);
    int value2 = get(33);
    int value3 = get(7);
    int value4 = get(99);

    printf("Valor encontrado para chave 15: %d\n", value1);
    printf("Valor encontrado para chave 33: %d\n", value2);
    printf("Valor encontrado para chave 7: %d\n", value3);
    printf("Valor encontrado para chave 99: %d\n", value4);

    // Libera a memória alocada
    for (int i = 0; i < hashtable->size; i++) {
        struct Symbol* current = hashtable->buckets[i];
        while (current != NULL) {
            struct Symbol* next = current->next;
            free(current);
            current = next;
        }
    }
    free(hashtable->buckets);
    free(hashtable);

    return 0;
}
