#include <stdio.h>
int main(){
int numero = 0;
int intervalo1 = 0, intervalo2 = 0, intervalo3 = 0, intervalo4 = 0;
label1:
if(!numero > 0){
 goto fim; 
}
printf("Digite um numero negativo para encerrar: ");
scanf("%d", numero);
if(numero >= 0 && numero <= 25){
intervalo1 += 1;
}
if(numero >= 26 && numero <= 50){
intervalo2 += 1;
}
if(numero >= 51 && numero <= 75){
intervalo3 += 1;
}
if(numero >= 76 && numero <= 100){
intervalo4 += 1;
}
goto label1;
fim:
printf("Numeros no intervalo [0, 25]: \n", intervalo1);
printf("Numeros no intervalo [26, 50]: \n", intervalo2);
printf("Numeros no intervalo [51, 75]: \n", intervalo3);
printf("Numeros no intervalo [76, 100]: \n", intervalo4);
return 0;
}