# CUDA: callback `nullptr` from `__managed__` function pointers
This repository contains notes and code to reproduce a breaking change in
how the CUDA driver returns function addresses via `__managed__` when
`-rdc=True`. This change breaks one of the concepts described in the
[NVIDIA Developer Blog](https://developer.nvidia.com/blog/cuda-pro-tip-use-cufft-callbacks-custom-data-processing/)
for getting callback function pointers passed to cuFFT.

## Failure cases
```bash
# Fails.
#  - Driver Version: 555.42.02
#  - CUDA: 12.5
/usr/local/cuda-12.5/bin/nvcc -rdc=true example.cu && ./a.out
# FAILURE! callback addr = (nil)


# Fails with older compiler.
#  - Driver Version: 555.42.02
#  - CUDA: 12.3
/usr/local/cuda-12.3/bin/nvcc -rdc=true example.cu && ./a.out
# FAILURE! callback addr = (nil)
```

## Success cases
```bash
# Success with older compiler *and driver*:
#  - Driver Version: 545.23.08
#  - CUDA: 12.3
/usr/local/cuda-12.3/bin/nvcc -rdc=true example.cu && ./a.out
# Success; callback addr = 0x7f8eff25d200


# Success with new compiler + driver *when we omit -rdc=true*
#  - Driver Version: 555.42.02
#  - CUDA: 12.5
/usr/local/cuda-12.5/bin/nvcc example.cu && ./a.out
# Success; callback addr = 0x1
```

## Other Details
- Operating System: RHEL9
- Device: RTX 5000