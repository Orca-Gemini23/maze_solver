%% Image loading 
I = imread('C:\Users\csyas\Downloads\mzsolver.png');

%if not necessary will not convert to grayscale: 
if size(I, 3) == 3
    I = rgb2gray(I);
end

%converting to double
I = im2double(I);

%% Preprocessing includes enhancing , filtering.

% Set the desired resolution (e.g., 800x600 pixels)
desired_resolution = [800, 600];

% Resize the image to the desired resolution
resized_image = imresize(I, desired_resolution);

% Check if the image is in color and convert it to grayscale
if size(resized_image, 3) == 3
    gray_image = rgb2gray(resized_image);
else
    gray_image = resized_image;
end

%% Enhance the contrast of the grayscale image
enhanced_image = imadjust(gray_image);

% Reduce noise using a Gaussian filter
filtered_image = imgaussfilt(enhanced_image, 1);

% Perform thresholding to create a binary image
% convert an image from color from grayscale to binary image
binary_image = imbinarize(filtered_image);

%% Otsu Segmentation: 

%Otsu threshold
level = graythresh(filtered_image); 

% separates images into two classes foreground and background , based 
% on the intensity values of the pixels . 

% why ? to find the optimal threshold based on observed distribution
% of pixel values .
segmented_image = imbinarize(filtered_image, level);

%% Display() all images 
% Display the processed images
subplot(2, 3, 1);
imshow(I);
title('Original Image');

subplot(2, 3, 2);
imshow(resized_image);
title('Resized Image');

subplot(2, 3, 3);
imshow(gray_image);
title('Grayscale Image');

subplot(2, 3, 4);
imshow(enhanced_image);
title('Enhanced Image');

subplot(2, 3, 5);
imshow(filtered_image);
title('Noise Reduced Image');

subplot(2, 3, 6);
imshow(segmented_image);
title('Segmented Image');

%% Output to the next segment that is the watershed transform
imwrite(segmented_image, 'preprocessing_output.jpg');
