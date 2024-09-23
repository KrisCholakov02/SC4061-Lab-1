# Computer Vision Laboratory: Point Processing, Spatial Filtering, and Frequency Filtering

## Overview

This repository contains all the materials related to **Lab 1** for the Computer Vision course. The lab introduces fundamental image processing techniques using MATLAB, including:
- **Contrast Stretching**
- **Histogram Equalization**
- **Linear Spatial Filtering**
- **Median Filtering**
- **Suppressing Noise Interference Patterns**
- **Undoing Perspective Distortion of a Planar Surface**
- **Perceptron Algorithms**

The objective of this laboratory is to explore various image processing techniques and analyze the results using MATLAB. This repository provides the MATLAB code, report, and images used for the experiments.

---

## Contents

### 1. **Report**
- `lab1_report.pdf`: A detailed report explaining the theory behind the experiments, MATLAB code analysis, and conclusions based on the results. The report covers all the experiments described in the laboratory manual, including concept explanations, experiment outcomes, and comparisons between different techniques.

### 2. **MATLAB Code**
- `lab1_code.m`: The MATLAB script that contains the full code used to perform all the experiments described in the report. This file is organized into sections corresponding to each experiment:
  - **2.1 Contrast Stretching**
  - **2.2 Histogram Equalization**
  - **2.3 Linear Spatial Filtering**
  - **2.4 Median Filtering**
  - **2.5 Suppressing Noise Interference Patterns**
  - **2.6 Undoing Perspective Distortion of Planar Surface**
  - **2.7 Perceptron Algorithms**

The script is well-commented and designed to be run sequentially. It utilizes MATLAB's **Image Processing Toolbox** for various operations.

### 3. **Images**
- `images/`: This directory contains all the images used in the lab experiments. The images are organized based on the sections of the lab they belong to.
  - `mrt-train.jpg`: Used for contrast stretching.
  - `lib-gn.jpg`: Used for experiments involving Gaussian noise removal.
  - `lib-sp.jpg`: Used for experiments involving speckle noise removal.
  - `pck-int.jpg`: Used for experiments involving frequency domain noise suppression.
  - `primate-caged.jpg`: Used for removing interference patterns and exploring frequency domain filtering.
  - `book.jpg`: Used for undoing perspective distortion.
  
Make sure the paths in the MATLAB script are correctly set up for the images in this folder.

---

## Instructions

### How to Run the Code:

1. **Pre-requisites**:
   - MATLAB with the **Image Processing Toolbox** installed. If the toolbox is not installed, you can install it via MATLAB's Add-On Explorer.

2. **Steps**:
   - Clone this repository to your local machine.
     ```bash
     git clone <repository_url>
     ```
   - Open MATLAB and navigate to the directory where the cloned repository is located.
   - Open the `lab1_code.m` script in MATLAB.
   - Ensure that all the image paths in the script are correct (they should point to the `images/` folder).
   - Run the script section by section to perform each experiment or run the entire script at once by typing:
     ```matlab
     run('lab1_code.m');
     ```

### Report
The `lab1_report.pdf` contains a comprehensive explanation of the experiments, analysis of the code, and the results. It is recommended to read the report while running the code to fully understand each experiment.

---

## Experiments and Techniques Overview

### 1. **Contrast Stretching**:
   - This experiment demonstrates how to enhance the contrast of an image using contrast stretching.

### 2. **Histogram Equalization**:
   - This section explains the process of improving image contrast using histogram equalization and compares the results with multiple passes.

### 3. **Linear Spatial Filtering**:
   - Experiments with Gaussian filtering to remove noise from images, demonstrating the effectiveness of linear filters in different noise environments.

### 4. **Median Filtering**:
   - Demonstrates the ability of median filtering to handle both Gaussian and speckle noise in images.

### 5. **Suppressing Noise Interference Patterns**:
   - Suppresses interference patterns by using frequency domain operations.

### 6. **Undoing Perspective Distortion**:
   - Demonstrates how to correct the perspective distortion in images using projective transformations.

### 7. **Perceptron Algorithms**:
   - Implementation of two perceptron algorithms and comparison of their performance.

---

## Troubleshooting

- Ensure that the **Image Processing Toolbox** is installed before running the script.
- Check that the images are correctly placed in the `images/` folder and the file paths in the MATLAB script are accurate.
- If MATLAB throws an error regarding the toolbox, confirm that you have the required license and installation for the Image Processing Toolbox.

---

## License

This repository is for educational purposes related to the Computer Vision course. All code and images are provided as part of the lab work and are not intended for commercial use.

---

## Acknowledgments

This lab is part of the Computer Vision coursework (SC4061/CE4003/CZ4003), and all materials and experiments are aligned with the objectives of the course. The MATLAB code provided here builds upon concepts taught during lectures and the lab manual provided by the course instructor.

