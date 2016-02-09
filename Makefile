NAME := main

CXX 		:= clang++
CXXFLAGS 	:= -std=c++11 -Wall -isystem libs# The last flag uses local boost (silent version of -I)


CUDA		:= nvcc
CUDAFLAGS	:= -std=c++11
CUDALIBS	:= -lcuda -lstdc++ -lcudart

RM 			:= rm -f

SRC 		:= $(shell find src -name "*.cpp")
OBJ  		:= $(patsubst src/%.cpp, obj/%.o, $(SRC))

CUDA_SRC	:= $(shell find src -name "*.cu")
CUDA_OBJ 	:= $(patsubst src/%.cu, obj/%.o, $(CUDA_SRC))

all: $(NAME)


gcc: CXX=g++
gcc: all

$(NAME): $(OBJ) 
$(NAME): $(CUDA_OBJ)
	$(CXX) $(LDFLAGS) -o $(NAME) $(OBJ) $(CUDA_OBJ) $(LDLIBS) $(CUDALIBS)

$(OBJ): obj/%.o : src/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(CUDA_OBJ): obj/%.o : src/%.cu
	$(CUDA) $(CUDAFLAGS) -c $< -o $@
			
clean:
	$(RM) $(NAME)
	$(RM) $(OBJ)
	$(RM) $(CUDA_OBJ)

manual:
	nvcc -c test_thrust.cu -std=c++11 -o test_thrust.o
	g++ -std=c++11 -c cpp_thrust.cpp 
	g++ -L/usr/local/cuda ./test_thrust.o ./cpp_thrust.o -lcuda -lstdc++ -lcudart

