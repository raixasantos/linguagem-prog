#include <stdio.h>
void mdc(int n,m,r)
{
if(n == 0){
r = m;
}
else if(m == 0){
r = n;
}
else if(n == 1 || m == 1){
r = 1;
}
else if(n > m){
n = n % m;
}
else{m = m % n;}

}
int main(){
int n = 0, m = 0;
printf("Digite o valor de n: ");
scanf("%d", &n);
printf("Digite o valor de m: ");
scanf("%d", &m);
int resultado = 0;
mdc(n,m,resultado);
printf("O maior divisor comum entre %d e %d é: %d\n", n,m,resultado);
return 0;
}