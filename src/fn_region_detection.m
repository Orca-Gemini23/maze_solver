 %% Loading the image 
 % doing this to provide a visual and numerical summary of the regions
img = imread('yoohoo.jpeg');

%% Region properties 

% using regionprops to analyze each region . 
% using area (size of each region in terms of pixels )
% using centroid (center point of each region )

stats = regionprops(L, 'Area', 'Centroid', 'BoundingBox');
for i = 1 :numel(stats)
    % getting area stats for every iteration
    area = stats(i).Area;
    % prints the region number and it's area.
    fprintf('Region %d has an area of %d pixels\n', i , area);
end 

%% visualization
figure;
imshow(img);
hold on;

% draws boundary boxes around the region 
for i = 1:numel(stats)
    rectangle('Position', stats(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
end
hold off;
title('Bounding Boxes of Regions');

imwrite(img, 'regional_Detection.jpeg');


