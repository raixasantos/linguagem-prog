#ifndef OUTRASFUNCOES_H
#define OUTRASFUNCOES_H


char *insert_key(int id, char *type);
void check_declaration(char *id);
void *set_symbol_datatype(char *id, char *type);
bucket *check_undeclared(char *id);

#endif