# nonlocal-demosaicing

This repository contains the code for a general demosaicing method via joint nonlocal optimization.

![image](https://github.com/bianlab/nonlocal-demosaicing/raw/master/results/Simulation-results.png)

*Figure1. Recovered images of different methods under different MSFAs. The close-ups and corresponding error maps are shown in the right side of each image.*

## About demosaicing
The single-sensor multispectral camera attaches a multispectral ﬁlter array (MSFA) on the sensor, enabling to acquire multispectral information in a snapshot. Compared with the other existing multispectral imaging systems that imploy various spectrum splitting and detection equipments, the MSFA based multispectral camera has the advantages of compact size, low weight, low cost,exact registration, strong robustness and full frame rate.

Compared with other methods, the proposed method enables higher-ﬁdelity details and fewer artifacts, and maintains the state-of-the-art performance for different mosaic patterns and channels. *Figure1* shows a comparison of the proposed method with other methods.

## Usage

Please clone this repository by Git or download the zip file firstly. 

### [1] Demo

Run `Demo.m` file to achieve the demosaicing results of BTES algorithm、DCT algorithm、GAP-TV algorithm and Ours algorithm stored in 'results' file.

Choose datasets of different cases by these two parameters:

    `type`: change the arrangement of MSFA, including random MSFA、regular MSFA and btes MSFA;
  
    `num_pic`: change number of spectral picture for simulation, ranging from 4 to 9.
  
### [2] The proposed method
The `func_Ours.m` runs the proposed method. It can be used for other tasks as well and only requires inputs of:

    `mask`: the arrangement cube of pattern;

    `m`: the measurement cube of scene;

    `orig`: the image cube of ground truth;

    `vinitial`: the image cube of initialization.

### [3] Note
The value of input images should range from 0 to 255. 

The `func_DCT.m` is memory consuming for 'toy' dataset with size of 256x256x6. Please ensure at least 32GB memory left.

The `func_Ours.m` is time consuming for 'toy' dataset with size of 256x256x6. More physical CPU cores conduce to faster reconstruction. 

## Platform
All the experiments are implemented using MATLAB(R) with an Intel i7-9700K processor at 3.6GHz and 64GB RAM. Notice that the `func_DCT.m` requires large RAM space and the `func_Ours.m` requires Parallel Computing Toolbox.
