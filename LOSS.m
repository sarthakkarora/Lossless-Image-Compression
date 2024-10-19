% Enhanced Lossless Color Image Compression using PNG and Huffman Coding

% Step 1: Read a color image with user input
[filename, pathname] = uigetfile({'*.png;*.jpg;*.bmp;*.tiff', 'Image Files (*.png, *.jpg, *.bmp, *.tiff)'; ...
                                  '*.png', 'PNG Files (*.png)'; ...
                                  '*.jpg', 'JPEG Files (*.jpg)'; ...
                                  '*.bmp', 'Bitmap Files (*.bmp)'; ...
                                  '*.tiff', 'TIFF Files (*.tiff)'}, ...
                                  'Select an Image');

% Check if the user selected a file
if isequal(filename, 0) || isequal(pathname, 0)
    error('No file selected. Please select a valid image file.');
else
    img = imread(fullfile(pathname, filename));
end


% Step 2: Save the original image size
originalSize = whos('img');
originalSizeInBytes = originalSize.bytes;

% Step 3: Compress the image using PNG format
imwrite(img, 'compressed_image.png', 'png');

% Get size of the compressed image
compressedInfo = dir('compressed_image.png');
compressedSizeInBytes = compressedInfo.bytes;

% Step 4: Implement Huffman Coding for each color channel
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

function [encodedImg, dict] = huffman_encode(channel)
    [counts, binLocations] = imhist(channel);
    probabilities = counts / sum(counts);
    symbols = num2cell(binLocations);
    dict = huffmandict(symbols, probabilities);
    encodedImg = huffmanenco(channel(:), dict);
end

[encodedR, dictR] = huffman_encode(R);
[encodedG, dictG] = huffman_encode(G);
[encodedB, dictB] = huffman_encode(B);

save('encoded_image.mat', 'encodedR', 'encodedG', 'encodedB', 'dictR', 'dictG', 'dictB');

% Calculate sizes and display compression ratio
compressionRatio = originalSizeInBytes / compressedSizeInBytes;
fprintf('Compression Ratio: %.2f\n', compressionRatio);

% Step 5: Decode the Image
load('encoded_image.mat');

function decodedChannel = huffman_decode(encodedImg, dict, originalSize)
    decodedChannel = huffmandeco(encodedImg, dict);
    decodedChannel = reshape(decodedChannel, originalSize);
end

decodedR = huffman_decode(encodedR, dictR, size(R));
decodedG = huffman_decode(encodedG, dictG, size(G));
decodedB = huffman_decode(encodedB, dictB, size(B));

decodedImg = cat(3, decodedR, decodedG, decodedB);
figure;
subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(uint8(decodedImg));
title('Decoded Image');

imwrite(uint8(decodedImg), 'decoded_image.png', 'png');

% Display size comparisons
fprintf('Original image size: %.2f KB\n', originalSizeInBytes / 1024);
fprintf('Compressed image size (PNG): %.2f KB\n', compressedSizeInBytes / 1024);
encodedDataInfo = dir('encoded_image.mat');
encodedSizeInBytes = encodedDataInfo.bytes;
fprintf('Encoded Huffman data size: %.2f KB\n', encodedSizeInBytes / 1024);
decodedInfo = dir('decoded_image.png');
decodedSizeInBytes = decodedInfo.bytes;
fprintf('Decoded image size: %.2f KB\n', decodedSizeInBytes / 1024);

% Add PSNR calculation
psnrValue = psnr(uint8(decodedImg), img);
fprintf('PSNR: %.2f dB\n', psnrValue);