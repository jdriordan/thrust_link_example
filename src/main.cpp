#include <algorithm>
#include <cstdlib>
#include <cstdio>

#include "test_thrust.h"

int N = 1000;

int main(){

    std::vector<int> xs(N);

    int n=0;
    std::generate(xs.begin(), xs.end(), [&n]{return n++;});

    int a;

    for(auto x:xs) printf("%d\n",x);
    add_up(xs,a);

    printf("sum was %d\n",a);

    return 0;
}
