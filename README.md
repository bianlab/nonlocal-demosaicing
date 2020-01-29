# nonlocal-demosaicing

This repository contains the Matlab code for a general demosaicing method via joint nonlocal optimization.

![image](https://github.com/bianlab/nonlocal-demosaicing/raw/master/results/Simulation-results.png)

*Figure1. Recovered images of different methods under different MSFAs. The close-ups and corresponding error maps are shown in the right side of each image.*

## About demosaicing
The single-sensor multispectral camera attaches a multispectral ﬁlter array (MSFA) on the sensor, enabling to acquire multispectral information in a snapshot. Compared with the other existing multispectral imaging systems that imploy various spectrum splitting and detection equipments, the MSFA based multispectral camera has the advantages of compact size, low weight, low cost,exact registration, strong robustness and full frame rate.

Compared with other methods, the proposed method enables higher-ﬁdelity details and fewer artifacts, and maintains the state-of-the-art performance for different mosaic patterns and channels.

## Platform
All the experiments are implemented using MATLAB with an Intel i7-9700K processor at 3.6GHz and 64GB RAM. Notice that the `func_DCT` requires large RAM space and the `func_Ours` requires Parallel Computing Toolbox.
