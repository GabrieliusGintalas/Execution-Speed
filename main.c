#include <stdio.h>

extern unsigned long execution();

int main(){
    printf("Welcome to Langsdorff Benchmark Program by Gabrielius Gintalas. \n");
    unsigned long tics = execution();
    printf("The driver received this number %ld \n", tics);
    printf("Now 0 will be sent to the operating system. Bye \n");
    return 0;   
}