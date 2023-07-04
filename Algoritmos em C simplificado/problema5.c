#include <stdio.h>

// Subprograma para calcular o maior divisor comum entre dois números naturais
void mdc(int n, int m, int *r) {
    inicio:
    if (n == 0) {
        *r = m;
        goto fim;
    } else if (m == 0) {
        *r = n;
        goto fim;
    } else if (n == 1 || m == 1) {
        *r = 1;
        goto fim;
    } else if (n > m) {
        n = n % m;
        goto inicio;
    } else {
        m = m % n;
        goto inicio;
    }

    fim:
    return;
}

int main() {
    int n, m;
    printf("Digite o valor de n: ");
    scanf("%d", &n);
    printf("Digite o valor de m: ");
    scanf("%d", &m);

    int resultado;
    mdc(n, m, &resultado);

    printf("O maior divisor comum entre %d e %d é: %d\n", n, m, resultado);

    return 0;
}
