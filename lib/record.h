#ifndef RECORD
#define RECORD

struct record {
	   char * code; /* field for storing the output code */
	   char * opt1; /* field for another purpose */
};

typedef struct record record;
 
void freeRecord(record *);
record * createRecord(char *, char *);
char * cat(char * s1, char * s2, char * s3, char * s4, char * s5);

#endif