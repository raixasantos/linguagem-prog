#ifndef HASHTABLE_H
#define HASHTABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TABLE_SIZE 100

typedef struct {
    char* chave;
    int valor;
} Entry;

typedef struct {
    Entry* tabela[TABLE_SIZE];
} Hashtable;

unsigned int hash(const char* chave);

Hashtable* criarHashtable();
int lookup(Hashtable* ht, int valor);
void insert(Hashtable* ht, const char* chave, int valor);
void removeValue(Hashtable* ht, int valor);
void freeHashtable(Hashtable* ht);

#endif  // HASHTABLE_H
