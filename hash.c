#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TABLE_SIZE 100

typedef struct {
    char* chave;
    int valor;
} TabelaSimbolo;

typedef struct {
    TabelaSimbolo* tabela[TABLE_SIZE];
} Hashtable;

/* serve para converter uma chave (no caso, uma string)
em um valor inteiro correspondente, que será usado 
como índice em uma tabela de hash*/
unsigned int hash(const char* chave) {
    unsigned int valor = 0;
    int i;
    int len = strlen(chave);
    for (i = 0; i < len; i++) {
        valor = valor * 37 + chave[i];
    }
    return valor % TABLE_SIZE;
}

Hashtable* criarHashtable() {
    Hashtable* ht = (Hashtable*)malloc(sizeof(Hashtable));
    int i;
    for (i = 0; i < TABLE_SIZE; i++) {
        ht->tabela[i] = NULL;
    }
    return ht;
}

int lookup(Hashtable* ht, int valor) {
    int i;
    for (i = 0; i < TABLE_SIZE; i++) {
        TabelaSimbolo* entrada = ht->tabela[i];
        if (entrada != NULL && entrada->valor == valor) {
            return 1; // Valor encontrado na hashtable
        }
    }
    return 0; // Valor não encontrado na hashtable
}

void insert(Hashtable* ht, const char* chave, int valor) {
    unsigned int indice = hash(chave);
    TabelaSimbolo* entrada = (TabelaSimbolo*)malloc(sizeof(TabelaSimbolo));
    entrada->chave = strdup(chave);
    entrada->valor = valor;
    ht->tabela[indice] = entrada;
}

void removeValue(Hashtable* ht, int valor) {
    int i;
    for (i = 0; i < TABLE_SIZE; i++) {
        TabelaSimbolo* entrada = ht->tabela[i];
        if (entrada != NULL && entrada->valor == valor) {
            free(entrada->chave);
            free(entrada);
            ht->tabela[i] = NULL;
            return; // Valor removido com sucesso
        }
    }
}

void freeHashtable(Hashtable* ht) {
    int i;
    for (i = 0; i < TABLE_SIZE; i++) {
        if (ht->tabela[i] != NULL) {
            free(ht->tabela[i]->chave);
            free(ht->tabela[i]);
        }
    }

    free(ht);
}

