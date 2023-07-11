#include "record.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void freeRecord(record * r){
  if (r) {
    if (r->code != NULL) free(r->code);
    if (r->type != NULL) free(r->type);
    if (r->params != NULL) free(r->params);
    free(r);
  }
}

record * createRecord(char * c1, char* c2, char* c3){
  record * r = (record *) malloc(sizeof(record));

  if (!r) {
    printf("Allocation problem. Closing application...\n");
    exit(0);
  }

  r->code = strdup(c1);
  r->type = strdup(c2);
  if (r->params != NULL) {
    strcat(r->params, ",");
    strcat(r->params, strdup(c3));
  } else {
    r->params = strdup(c3);
  }

  return r;
}

char * cat(char * s1, char * s2, char * s3, char * s4, char * s5){
  int tam;
  char * output;

  tam = strlen(s1) + strlen(s2) + strlen(s3) + strlen(s4) + strlen(s5)+ 1;
  output = (char *) malloc(sizeof(char) * tam);
  
  if (!output){
    printf("Allocation problem. Closing application...\n");
    exit(0);
  }
  
  sprintf(output, "%s%s%s%s%s", s1, s2, s3, s4, s5);
  
  return output;
}

// char* concat_params(char* c1) {
//   char * params = malloc(strlen(scoperesearched->name));;
//   return params;
// }