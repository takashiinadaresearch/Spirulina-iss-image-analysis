# Spirulina Surface Area Analysis (ImageJ Macro)

## Overview
This repository contains an ImageJ/Fiji macro script (`.ijm`) designed for the automated, high-throughput extraction and measurement of *Spirulina* surface area from microscopic images. 

By automating channel splitting, thresholding, and morphological operations, this script eliminates human bias and ensures objective, reproducible quantitative analysis. It was developed to analyze image data from microalgae cultivation experiments under microgravity conditions on the International Space Station (ISS).

## Features
- **Batch Processing:** Automatically processes all `.tif` and `.tiff` images within a specified directory.
- **Green Channel Isolation:** Splits RGB images and isolates the green channel, optimizing the detection of chlorophyll-containing microalgae.
- **Objective Binarization:** Applies the "Moments" auto-thresholding algorithm for consistent background subtraction.
- **Noise Reduction:** Utilizes morphological operations (2x Dilate, 2x Erode) to smooth shapes and eliminate noise.
- **Universal ROI:** Applies a single, user-defined Region of Interest (`.roi`) across all images in the dataset to ensure uniform measurement boundaries.

## Prerequisites
- [Fiji (ImageJ)](https://imagej.net/software/fiji/) installed on your system.

## Usage
1. Launch **Fiji (ImageJ)**.
2. Drag and drop the macro file into the Fiji window, or open it via `Plugins > Macros > Edit...`
3. Click **Run** on the macro editor window.
4. **Prompt 1:** Select the input directory containing your `.tif`/`.tiff` images.
5. **Prompt 2:** Select the common `.roi` (Region of Interest) file for the dataset.
6. The script will run in batch mode (background processing for speed).
7. Once completed, a prompt will appear, and the extracted surface area data will be displayed in the **Results** window. You can save this table as a `.csv` file.

## Citation
If you use this code in your research, please cite our paper and the Zenodo archive:
- **Paper:** [Author Names], "[Paper Title]", *npj Microgravity* (202X). [DOI will be added upon publication]
- **Code Archive:** [DOI link from Zenodo (e.g., https://doi.org/10.5281/zenodo.XXXXXX)]

## License
This project is licensed under the MIT License - see the LICENSE file for details.
