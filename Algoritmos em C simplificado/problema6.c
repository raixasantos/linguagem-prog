#include <stdio.h>
#include <stdlib.h>

// Estrutura para representar um nó da árvore
typedef struct No {
    int chave;
    struct No* esquerda;
    struct No* direita;
} No;

// Subprograma para inserir um novo nó na árvore
void inserirNo(No** raiz, int chave) {
    inicio:
    if (*raiz == NULL) {
        *raiz = (No*)malloc(sizeof(No));
        (*raiz)->chave = chave;
        (*raiz)->esquerda = NULL;
        (*raiz)->direita = NULL;
        goto fim;
    } else {
        if (chave < (*raiz)->chave) {
            raiz = &(*raiz)->esquerda;
            goto inicio;
        } else if (chave > (*raiz)->chave) {
            raiz = &(*raiz)->direita;
            goto inicio;
        }
    }

    fim:
    return;
}

// Subprograma para encontrar a chave mínima da árvore e indicar o nível
void encontrarChaveMinima(No* raiz, int nivel) {
    inicio:
    if (raiz == NULL) {
        printf("A árvore está vazia.\n");
        goto fim;
    } else if (raiz->esquerda == NULL) {
        printf("A chave mínima é %d, no nível %d.\n", raiz->chave, nivel);
        goto fim;
    } else {
        raiz = raiz->esquerda;
        nivel++;
        goto inicio;
    }

    fim:
    return;
}

// Subprograma para encontrar a chave máxima da árvore e indicar o nível
void encontrarChaveMaxima(No* raiz, int nivel) {
    inicio:
    if (raiz == NULL) {
        printf("A árvore está vazia.\n");
        goto fim;
    } else if (raiz->direita == NULL) {
        printf("A chave máxima é %d, no nível %d.\n", raiz->chave, nivel);
        goto fim;
    } else {
        raiz = raiz->direita;
        nivel++;
        goto inicio;
    }

    fim:
    return;
}

// Subprograma para imprimir a árvore nível a nível
void imprimirArvore(No* raiz) {
    inicio:
    if (raiz == NULL) {
        printf("A árvore está vazia.\n");
        goto fim;
    }

    int nivel = 0;
    int nivelAtual = 0;
    int nivelAnterior = -1;
    No* fila[100];
    int frente = 0;
    int tras = 0;

    fila[tras++] = raiz;

    while (frente != tras) {
        No* noAtual = fila[frente++];
        nivelAtual = nivel;

        if (nivelAtual != nivelAnterior) {
            printf("Nível %d: ", nivelAtual);
            nivelAnterior = nivelAtual;
        }

        printf("%d ", noAtual->chave);

        if (noAtual->esquerda != NULL) {
            fila[tras++] = noAtual->esquerda;
        }

        if (noAtual->direita != NULL) {
            fila[tras++] = noAtual->direita;
        }

        if (frente == tras) {
            printf("\n");
            nivel++;
        }

        goto inicio;
    }

    fim:
    return;
}

int main() {
    No* raiz = NULL;

    int opcao;
    int valor;

    menu:
    printf("\n-- ÁRVORE BINÁRIA DE BUSCA --\n");
    printf("1. Inserir valor\n");
    printf("2. Encontrar chave mínima\n");
    printf("3. Encontrar chave máxima\n");
    printf("4. Imprimir árvore\n");
    printf("5. Sair\n");
    printf("Escolha uma opção: ");
    scanf("%d", &opcao);

    switch (opcao) {
        case 1:
            printf("Digite o valor a ser inserido: ");
            scanf("%d", &valor);
            inserirNo(&raiz, valor);
            goto menu;
        case 2:
            encontrarChaveMinima(raiz, 0);
            goto menu;
        case 3:
            encontrarChaveMaxima(raiz, 0);
            goto menu;
        case 4:
            imprimirArvore(raiz);
            goto menu;
        case 5:
            printf("Programa encerrado.\n");
            break;
        default:
            printf("Opção inválida. Tente novamente.\n");
            goto menu;
    }

    return 0;
}
