% this function takes a grey scale image matrix as input and returns 
% the feature matrix of a binary image
% k = 1, the connected component image will show up
% k = 0, the connected component image will not show up
function features = ReadBinarizeExtractFeatures(im2, k)

%h = imhist(im);
%figure(2);
%plot(h);
%title('Intensity Histogram');

% Get the binary image from the gray scale image
%th = 235;
%im2 = im;
% the character color value is 1
%im2(im<th) = 1;
% the background color value is 0
%im2(im>=th) = 0;    

% Find connnected components
L = bwlabel(im2);
if k == 1
figure();
imagesc(L);
title('Connected Component');
end

features = BoundingBox(im2, L);
end