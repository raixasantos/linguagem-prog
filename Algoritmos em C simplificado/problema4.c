#include <stdio.h>
#include <stdbool.h>

// Definição do tipo rational_t
typedef struct {
    int numerador;
    int denominador;
} rational_t;

// Subprograma para criar um número racional a partir de dois inteiros a e b
rational_t criarRacional(int a, int b) {
    rational_t racional;
    racional.numerador = a;
    racional.denominador = b;
    return racional;
}

// Subprograma para verificar se dois números racionais são iguais
bool saoIguais(rational_t r1, rational_t r2) {
    return (r1.numerador * r2.denominador) == (r2.numerador * r1.denominador);
}

// Subprograma para somar dois números racionais
rational_t somarRacionais(rational_t r1, rational_t r2) {
    int numerador = (r1.numerador * r2.denominador) + (r2.numerador * r1.denominador);
    int denominador = r1.denominador * r2.denominador;
    return criarRacional(numerador, denominador);
}

// Subprograma para negar um número racional
rational_t negarRacional(rational_t r) {
    int numerador = -r.numerador;
    int denominador = r.denominador;
    return criarRacional(numerador, denominador);
}

// Subprograma para subtrair dois números racionais
rational_t subtrairRacionais(rational_t r1, rational_t r2) {
    rational_t negativo = negarRacional(r2);
    return somarRacionais(r1, negativo);
}

// Subprograma para multiplicar dois números racionais
rational_t multiplicarRacionais(rational_t r1, rational_t r2) {
    int numerador = r1.numerador * r2.numerador;
    int denominador = r1.denominador * r2.denominador;
    return criarRacional(numerador, denominador);
}

// Subprograma para calcular o inverso de um número racional
rational_t inversoRacional(rational_t r) {
    if (r.numerador == 0) {
        printf("Erro: Divisão por zero!\n");
        return criarRacional(0, 1);
    }
    int numerador = r.denominador;
    int denominador = r.numerador;
    return criarRacional(numerador, denominador);
}

// Subprograma para dividir dois números racionais
rational_t dividirRacionais(rational_t r1, rational_t r2) {
    rational_t inverso = inversoRacional(r2);
    return multiplicarRacionais(r1, inverso);
}

int main() {
    // Testando os subprogramas

    rational_t racional1 = criarRacional(3, 4);
    rational_t racional2 = criarRacional(6, 8);

    printf("Numerador de racional1: %d\n", racional1.numerador);
    printf("Denominador de racional1: %d\n", racional1.denominador);

    printf("Numerador de racional2: %d\n", racional2.numerador);
    printf("Denominador de racional2: %d\n", racional2.denominador);

    bool iguais = saoIguais(racional1, racional2);
    if (iguais) {
        printf("Os racionais sao iguais\n");
    } else {
        printf("Os racionais sao diferentes\n");
    }

    rational_t soma = somarRacionais(racional1, racional2);
    printf("Soma dos racionais: %d/%d\n", soma.numerador, soma.denominador);

    rational_t negativo = negarRacional(racional1);
    printf("Negativo de racional1: %d/%d\n", negativo.numerador, negativo.denominador);

    rational_t subtracao = subtrairRacionais(racional1, racional2);
    printf("Subtracao dos racionais: %d/%d\n", subtracao.numerador, subtracao.denominador);

    rational_t multiplicacao = multiplicarRacionais(racional1, racional2);
    printf("Multiplicacao dos racionais: %d/%d\n", multiplicacao.numerador, multiplicacao.denominador);

    rational_t inverso = inversoRacional(racional1);
    printf("Inverso de racional1: %d/%d\n", inverso.numerador, inverso.denominador);

    rational_t divisao = dividirRacionais(racional1, racional2);
    printf("Divisao dos racionais: %d/%d\n", divisao.numerador, divisao.denominador);

    return 0;
}
