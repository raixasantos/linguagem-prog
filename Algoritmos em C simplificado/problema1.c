#include <stdio.h>

int main() {
    double x = 3.5; // Valor de x (número racional)
    double y = 1.2; // Valor de y (número racional)
    int c = 5;      // Valor de c (número inteiro)

    double resultado = x * x - y + c; // Avaliação da expressão

    printf("O resultado da expressao x^2 - y + c eh: %.2f\n", resultado);

    return 0;
}