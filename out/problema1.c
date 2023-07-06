#include <stdio.h>
int main()
{
    float x = 3.500000;
    float y = 1.200000;
    int c = 5;
    float resultado = x * x - y + c;
    printf("O resultado da expressao x^2 - y + c eh: %.2f\n", resultado);
    return 0;
}