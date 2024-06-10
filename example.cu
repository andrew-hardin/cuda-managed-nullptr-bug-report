#include <iostream>

__device__ float CallbackFunction() {
  return 0.0;
}

__managed__ float(*callback_addr)() = &CallbackFunction;

int main() {
  if(callback_addr == nullptr) {
    printf("FAILURE! callback addr = %p\n", callback_addr);
    return EXIT_FAILURE;
  } else {
    printf("Success; callback addr = %p\n", callback_addr);
    return EXIT_SUCCESS;
  }
}