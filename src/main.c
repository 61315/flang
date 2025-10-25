#include <stdio.h>

extern void foo_(int*, int*, int*);

int main() {
    int x = 1, y = 1, z;
    foo_(&x, &y, &z);

    printf("main.c::%d + %d = %d\n", x, y, z);
    return 0;
}

