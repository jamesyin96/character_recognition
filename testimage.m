% about the processing of testing image
% Now compute the features of test image
testIm = imread('test.jpg');
% get the binary image of the test image
testIm2 = toBinary(testIm);

% find out the size of test image and the h to partition each character
tsize = size(testIm2);
height = tsize(1);
h = height/10;
testCounter = zeros(70,1);
% Find connnected components
for i=1:10
    temp =testIm2((i-1)*h+1:i*h,:);
    testFeatures((i-1)*7+1:i*7,:) = ReadBinarizeExtractFeatures(temp,0);
    testCounter((i-1)*7+1:i*7) = i;
end

% Normalize the test features with means and var from the training set
normaltestFeatures = zeros(70,6);
for i=1:6
normaltestFeatures(:,i)= (testFeatures(:,i) - meanFeatures(i))/sqrt(varFeatures(i));
end