#include <stdio.h>

int main() {
    int numero;
    int intervalo1 = 0, intervalo2 = 0, intervalo3 = 0, intervalo4 = 0;

leitura:
    printf("Digite um numero (negativo para encerrar): ");
    scanf("%d", &numero);

    if (numero < 0)
        goto fim;

    if (numero >= 0 && numero <= 25)
        intervalo1++;
    else if (numero >= 26 && numero <= 50)
        intervalo2++;
    else if (numero >= 51 && numero <= 75)
        intervalo3++;
    else if (numero >= 76 && numero <= 100)
        intervalo4++;

    goto leitura;

fim:
    printf("Numeros no intervalo [0, 25]: %d\n", intervalo1);
    printf("Numeros no intervalo [26, 50]: %d\n", intervalo2);
    printf("Numeros no intervalo [51, 75]: %d\n", intervalo3);
    printf("Numeros no intervalo [76, 100]: %d\n", intervalo4);

    return 0;
}