% about the processing of testing image
% Now compute the features of test image
testIm = imread('test.jpg');
% get the binary image of the test image
testIm2 = toBinary(testIm);

testLength = length(testFeatures);

% find out the size of test image and the h to partition each character
tsize = size(testIm2);
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

% Normalize the test features with means and var from the training set
testFeatures = zeros(testLength,6);
for i=1:6
testFeatures(:,i)= (testFeatures(:,i) - meanFeatures(i))/sqrt(varFeatures(i));
end