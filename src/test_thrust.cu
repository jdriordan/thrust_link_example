#include <thrust/device_vector.h>
#include <thrust/reduce.h>
#include <cstdlib>

using namespace std;
using namespace thrust;

int add_up(std::vector<int> xs, int &total){
    
    device_vector<int> xs_d(xs.begin(),xs.end());

    total=reduce(xs_d.begin(), xs_d.end(), 0, thrust::plus<int>());

    return 0;
}
