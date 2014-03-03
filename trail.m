% Reading the original image and turn it into a binary image using
% thresholding

im = imread('a.jpg');
figure(1);
imshow(im);

h = imhist(im);
figure(2);
plot(h(1:255));
title('Intensity Histogram');

% Get the binary image from the gray scale image
th = 235;
im2 = im;
% the character color value is 1
im2(im<th) = 1;
% the background color value is 0
im2(im>=th) = 0;

figure();
imagesc(im2);
colormap gray