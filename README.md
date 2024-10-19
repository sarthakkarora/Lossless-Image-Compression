
# Lossless Color Image Compression Using PNG and Huffman Coding

## Overview
This MATLAB project implements **lossless color image compression** by combining the PNG format and **Huffman coding** for further optimization. The aim is to reduce the image size while maintaining the original quality. Additionally, the **PSNR (Peak Signal-to-Noise Ratio)** is calculated to measure the quality of the decoded image compared to the original.

### Features:
- **PNG Compression**: Saves the image in PNG format, a widely used lossless compression method.
- **Huffman Coding**: Each color channel (Red, Green, Blue) is encoded separately using Huffman coding, further compressing the image data.
- **Compression Ratio**: Displays the ratio of the original image size to the compressed image size.
- **PSNR Calculation**: Provides the PSNR value to evaluate the quality of the decompressed image.

## Steps Involved
1. **Image Selection**: The user selects an image file from their system (supports PNG, JPG, BMP, TIFF).
2. **PNG Compression**: The selected image is compressed using the PNG format.
3. **Huffman Coding**: Each color channel (R, G, B) of the image is encoded using Huffman coding.
4. **Huffman Decoding**: The encoded image is decoded to restore the original image.
5. **Comparison**: The script compares the original image, compressed PNG, and Huffman-encoded data sizes.
6. **PSNR Calculation**: The Peak Signal-to-Noise Ratio is calculated to measure the similarity between the original and decoded images.

## File Descriptions
- **Main Script**: Contains the complete code for reading, compressing, encoding, decoding, and calculating the PSNR of the image.
- **encoded_image.mat**: Stores the Huffman-encoded data and dictionaries for each color channel.
- **compressed_image.png**: The PNG-compressed version of the selected image.
- **decoded_image.png**: The image after Huffman decoding, saved as PNG for comparison.

## Usage Instructions

### Prerequisites
You need **MATLAB** installed on your system to run this project.

### Running the Code
1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/enhanced-lossless-image-compression.git
   ```
2. Navigate to the project directory in MATLAB.
3. Run the `LOSS.m` script:
   ```matlab
   LOSS
   ```
4. A file selector window will appear, prompting you to select an image from your system (PNG, JPG, BMP, or TIFF).
5. After selecting the image, the script will:
   - Display the original and decoded images.
   - Show the compression ratio and the PSNR of the decoded image.
   - Save the compressed and decoded images in the project folder.

### Example Output:
```bash
Compression Ratio: 1.45
Original image size: 156.24 KB
Compressed image size (PNG): 108.75 KB
Encoded Huffman data size: 98.34 KB
Decoded image size: 156.22 KB
PSNR: 40.12 dB
```

## Code Breakdown
### Main Steps:
1. **Read the Image**: Allows the user to select an image file from their device.
2. **PNG Compression**: Uses MATLAB’s `imwrite` function to save the image as a PNG.
3. **Huffman Encoding**: The script splits the image into Red, Green, and Blue channels and compresses each channel using Huffman coding.
4. **Decoding**: The encoded image is decoded using the Huffman dictionaries and reshaped to its original size.
5. **PSNR Calculation**: The quality of the decoded image is measured using the `psnr` function, comparing it to the original image.

### Functions:
- **huffman_encode**: Encodes a color channel using Huffman coding based on pixel intensity frequencies.
- **huffman_decode**: Decodes the Huffman-encoded data for a color channel and reshapes it to the original dimensions.

## Contributions
Feel free to submit pull requests or issues if you find any bugs or want to enhance the functionality.

