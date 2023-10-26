%% Load and preprocess the image
I = imread('preprocessing_output.jpg'); % Provide the path to your image
if size(I, 3) == 3
    I = rgb2gray(I);
end

% Convert the image to double format
I = im2double(I);

%% Performing the watershed transform without using the direct function:

% Calculate the gradient magnitude of the image  
% grad magnitude tells us how quickly the image is changing 
% why ? to enhance the edges and boundaries to identify the path 
gradient = imgradient(I, 'sobel');

% Find regional minima in the gradient image
% regional minima represent the potential markers for segmentation 
% identifies lowerst parts of the river 
regional_minima = imregionalmin(gradient);

% Create markers for watershed segmentation
% puts markers on low points like where the hidden part might be !! 
markers = regional_minima;

% Label the markers
current_marker = 1;
L = zeros(size(I));

for row = 1:size(I, 1)
    for col = 1:size(I, 2)
        if markers(row, col) == 1
            L(row, col) = current_marker;
            current_marker = current_marker + 1;
        end
    end
end

% Apply the watershed transform manually
% start filling the picture with water !! 
L = watershed(L);

% Define region numbers for analysis (e.g., 2 for the path)
% extracting region of interest (finding the secret path)
region_number = 2;

% Create a binary mask for region 2
% the computer looks at this secret path and decides where it is by 
% drawing a line around it. 
L1 = L == region_number;

% Find the boundaries of the binary mask
% the necessary boundary detection and cleansing !!
boundaries = bwperim(L1);

% Exclude the path on the image boundary by removing the border pixels
% to remove the unwanted path on the boundary !!
boundaries(1:end, [1, end]) = 0; % Remove left and right borders
boundaries([1, end], 1:end) = 0; % Remove top and bottom borders

% Make the path thicker by dilating the binary path mask
% performing dilation !! 
thicker_path = imdilate(boundaries, strel('disk', 4)); 

% Overlay the cleaned and thicker path on the original grayscale image
% converting rgb to gray scale 
I_rgb = cat(3, I, I, I); 
P = imoverlay(I_rgb, thicker_path, [1 0 1]);

% Display and save the resulting image
figure;
imshow(P);
imwrite(P, 'yoohoo.jpeg');
