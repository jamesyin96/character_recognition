% Reading the original image and turn it into a binary image using
% thresholding
function im_out=toBinary(im)
h = imhist(im);
%figure(2);
%plot(h);
%title('Intensity Histogram');

% Get the binary image from the gray scale image
th = 235;
im2 = im;
% the character color value is 1
im2(im<th) = 1;
% the background color value is 0
im2(im>=th) = 0;
im_out = im2;
end