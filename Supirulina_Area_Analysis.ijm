// Spirulina Surface Area Analysis - Green Channel Extraction & Moments Thresholding

dir = getDirectory("Select input directory containing image files");
list = getFileList(dir);

// Load the universal ROI file
roi_path = File.openDialog("Select the common ROI file (.roi) for this dataset");
if (roiManager("count") > 0) {
    roiManager("Delete"); // Reset existing ROIs
}
roiManager("Open", roi_path); // Set the single ROI

// Enable batch mode for high-speed processing
setBatchMode(true); 

for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".tif") || endsWith(list[i], ".tiff")) {
        
        open(dir + list[i]);
        
        // 1. Split image into R, G, and B channels
        run("Split Channels");
        
        // 2. Identify and isolate the Green channel
        images = getList("image.titles");
        gWindow = "";
        for (j = 0; j < images.length; j++) {
            if (startsWith(images[j], "G-") || indexOf(images[j], "green") >= 0) {
                gWindow = images[j];
            } else {
                selectWindow(images[j]);
                close(); // Close Red and Blue channels
            }
        }
        
        // 3. Select the isolated Green channel window
        selectWindow(gWindow);
        
        // 4. Binarization using the Moments thresholding method
        run("Auto Threshold", "method=Moments black");
        
        // 5. Morphological operations for noise reduction (Dilate x2, Erode x2)
        run("Dilate");
        run("Dilate");
        run("Erode");
        run("Erode");
        
        // 6. Apply the universal ROI (index 0) and measure area
        roiManager("Select", 0);
        run("Measure");
        
        // Close processed image window
        close();
    }
}

// Disable batch mode and refresh display
setBatchMode(false);
updateResults(); // Force write results to table

// Ensure the Results window is visible
if (isOpen("Results")) {
    selectWindow("Results");
}

showMessage("Analysis Complete", "All images processed successfully. Please check the Results window.");