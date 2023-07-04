#include <stdio.h>

#define MAX 10

int main() {
    int matriz1[MAX][MAX], matriz2[MAX][MAX], soma[MAX][MAX], produto[MAX][MAX];
    int linhas, colunas;
    int i = 0, j = 0;

leitura:
    printf("Digite o numero de linhas das matrizes (maximo %d): ", MAX);
    scanf("%d", &linhas);

    printf("Digite o numero de colunas das matrizes (maximo %d): ", MAX);
    scanf("%d", &colunas);

    if (linhas <= 0 || colunas <= 0 || linhas > MAX || colunas > MAX)
        goto leitura;

    printf("Digite os elementos da matriz 1:\n");
    i = 0;
leitura_matriz1:
    j = 0;
    printf("Elemento [%d][%d]: ", i, j);
    scanf("%d", &matriz1[i][j]);
    j++;
    if (j < colunas)
        goto leitura_matriz1;

    printf("Digite os elementos da matriz 2:\n");
    i = 0;
leitura_matriz2:
    j = 0;
    printf("Elemento [%d][%d]: ", i, j);
    scanf("%d", &matriz2[i][j]);
    j++;
    if (j < colunas)
        goto leitura_matriz2;

    // Soma das matrizes
    i = 0;
soma_matrizes:
    j = 0;
    soma[i][j] = matriz1[i][j] + matriz2[i][j];
    j++;
    if (j < colunas)
        goto soma_matrizes;
    i++;
    if (i < linhas)
        goto soma_matrizes;

    // Produto das matrizes
    i = 0;
produto_matrizes:
    j = 0;
    produto[i][j] = matriz1[i][j] * matriz2[i][j];
    j++;
    if (j < colunas)
        goto produto_matrizes;
    i++;
    if (i < linhas)
        goto produto_matrizes;

    // Impressão das matrizes
    printf("\nSoma das matrizes:\n");
    i = 0;
impressao_soma:
    j = 0;
    printf("%d ", soma[i][j]);
    j++;
    if (j < colunas)
        goto impressao_soma;
    printf("\n");
    i++;
    if (i < linhas)
        goto impressao_soma;

    printf("\nProduto das matrizes:\n");
    i = 0;
impressao_produto:
    j = 0;
    printf("%d ", produto[i][j]);
    j++;
    if (j < colunas)
        goto impressao_produto;
    printf("\n");
    i++;
    if (i < linhas)
        goto impressao_produto;

    return 0;
}
