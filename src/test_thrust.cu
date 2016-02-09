#include <thrust/device_vector.h>
#include <thrust/reduce.h>
#include <thrust/transform.h>
#include <thrust/functional.h>
#include <cstdlib>

using namespace std;
using namespace thrust;

struct saxpy_functor{ 
    const float a;
    
    saxpy_functor(float _a):a(_a){} 
    
    __host__ __device__ float operator()(const float& x, const float& y) const {
        return a * x + y; } 
    }; 

int add_up(std::vector<int> xs, int &total){
    
    device_vector<int> xs_d(xs.begin(),xs.end());

    thrust::transform(
            xs_d.begin(),xs_d.end(),
            xs_d.begin(),
            xs_d.begin(),
            saxpy_functor(2));

    total=reduce(xs_d.begin(), xs_d.end(), 0, thrust::plus<int>());

    return 0;
}
