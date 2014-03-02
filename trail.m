% Reading the original image and turn it into a binary image using
% thresholding

im = imread('test.jpg');
figure(1);
imshow(im);

h = imhist(im);
figure(2);
plot(h);
title('Intensity Histogram');

% Get the binary image from the gray scale image
th = 235;
im2 = im;
% the character color value is 1
im2(im<th) = 1;
% the background color value is 0
im2(im>=th) = 0;

% Get the size of the test image, divide this image by different character
% groups, we have 10 groups of character, so each group has a height of
% total_height/10
tsize = size(im2);
height = tsize(1);
h = height/10;
% Find connnected components
for i=1:10
    temp = im2((i-1)*h+1:i*h,:);
    L = bwlabel(temp);
    figure();
    imagesc(L);
    title('Connected Component');
    features((i-1)*7+1:i*7,1:6) = BoundingBox(temp, L);
end
