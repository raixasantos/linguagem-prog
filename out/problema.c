#include <stdio.h>
void mdc(int n, intint m, intint *r)
{
    if (n == 0)
    {
        *r;
    }
    else if (m == 0)
    {
        *r;
    }
    else if (n == 1 || m == 1)
    {
        *r;
    }
    else if (n > m)
    {
        n = n % m;
        mdc(n, m, r);
    }
    else
    {
        m = m % n;
        mdc(n, m, r);
    }
}
int main()
{
    int n = 0, m = 0;
    printf("Digite o valor de n: ");
    scanf("%d", &n);
    printf("Digite o valor de m: ");
    scanf("%d", &m);
    int resultado = 0;
    mdc(n, m, &resultado);
    printf("O maior divisor comum entre %d e %d é: %d\n", n, m, resultado);
    return 0;
}