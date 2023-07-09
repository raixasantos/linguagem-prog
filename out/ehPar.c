#include <stdio.h>
string ehPar(int numero){
if(numero % 2 == 0){
return "E par";
}
else{return "Nao e par";}

}
int main(){
int numero = 2;
string paridade = ehPar(numero);
printf(paridade);
return 0;
}