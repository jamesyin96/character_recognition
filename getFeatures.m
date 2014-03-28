% Reading the original image and turn it into a binary image using
% thresholding
% processing a
aIm = imread('a.jpg');
aFeatures = ReadBinarizeExtractFeatures(toBinary(aIm),0);
aLength = length(aFeatures);
% processing d
dIm = imread('d.jpg');
dFeatures = ReadBinarizeExtractFeatures(toBinary(dIm),0);
dLength = length(dFeatures);
% processing m
mIm = imread('m.jpg');
mFeatures = ReadBinarizeExtractFeatures(toBinary(mIm),0);
mLength = length(mFeatures);
% processing n
nIm = imread('n.jpg');
nFeatures = ReadBinarizeExtractFeatures(toBinary(nIm),0);
nLength = length(nFeatures);
% processing o
oIm = imread('o.jpg');
oFeatures = ReadBinarizeExtractFeatures(toBinary(oIm),0);
oLength = length(oFeatures);
% processing p
pIm = imread('p.jpg');
pFeatures = ReadBinarizeExtractFeatures(toBinary(pIm),0);
pLength = length(pFeatures);
% processing q
qIm = imread('q.jpg');
qFeatures = ReadBinarizeExtractFeatures(toBinary(qIm),0);
qLength = length(qFeatures);
% processing r
rIm = imread('r.jpg');
rFeatures = ReadBinarizeExtractFeatures(toBinary(rIm),0);
rLength = length(rFeatures);
% processing u
uIm = imread('u.jpg');
uFeatures = ReadBinarizeExtractFeatures(toBinary(uIm),0);
uLength = length(uFeatures);
% processing w
wIm = imread('w.jpg');
wFeatures = ReadBinarizeExtractFeatures(toBinary(wIm),0);
wLength = length(aFeatures);

tLength = aLength + dLength + mLength + nLength + oLength + pLength + ... 
qLength + rLength + uLength + wLength;

% creating the big matrix to store all the features of the characters
tFeatures = zeros(tLength, 6);
% creating the counter to store the index of each CC
tCounter = zeros(tLength, 1);

tFeatures(1:aLength,:) = aFeatures;
tCounter(1:aLength) =1;
curr = aLength;

tFeatures(aLength+1:curr + dLength,:) = dFeatures;
tCounter(aLength+1:curr+dLength) = 2;
curr = curr + dLength;

tFeatures(curr+1:curr + mLength,:) = mFeatures;
tCounter(curr+1:curr + mLength) = 3;
curr = curr + mLength;

tFeatures(curr+1:curr + nLength,:) = nFeatures;
tCounter(curr+1:curr + nLength) = 4;
curr = curr + nLength;

tFeatures(curr+1:curr + oLength,:) = oFeatures;
tCounter(curr+1:curr + oLength) = 5;
curr = curr + oLength;

tFeatures(curr+1:curr + pLength,:) = pFeatures;
tCounter(curr+1:curr + pLength) = 6;
curr = curr + pLength;

tFeatures(curr+1:curr + qLength,:) = qFeatures;
tCounter(curr+1:curr + qLength) = 7;
curr = curr + qLength;

tFeatures(curr+1:curr + rLength,:) = rFeatures;
tCounter(curr+1:curr + rLength) = 8;
curr = curr + rLength;

tFeatures(curr+1:curr + uLength,:) = uFeatures;
tCounter(curr+1:curr + uLength) = 9;
curr = curr + uLength;

tFeatures(curr+1:curr + wLength,:) = wFeatures;
tCounter(curr+1:curr + wLength) = 10;
curr = curr + wLength;

% normalize the features matrix
meanFeatures = zeros(6,1);
varFeatures = zeros(6,1);
Features = zeros(tLength,6);
for i=1:6
meanFeatures(i) = mean(tFeatures(:,i));
varFeatures(i) = var(tFeatures(:,i));
Features(:,i)= (tFeatures(:,i) - meanFeatures(i))/sqrt(varFeatures(i));
end


% recognition on training data
D = dist2(Features,Features);

figure();
imagesc(D);
title('Affinity Matrix');

[D_sorted, D_index] = sort(D ,2);

% the recognition classification vector
regclass = tCounter(D_index(:,2));

% compute the confusion matrix of each class
conf = ConfusionMatrix(tCounter,regclass,10);
figure();
imagesc(conf);
title('Confusion Matrix');

% Compute the recognition rate of each training image
T = length(regclass);
classrate = zeros(10,1);
classresult = zeros(10,1);
for i=1:T
    if (regclass(i)==tCounter(i))
        classresult(tCounter(i))=classresult(tCounter(i))+1;
    end
end
classrate(1)=classresult(1)/aLength;
classrate(2)=classresult(2)/dLength;
classrate(3)=classresult(3)/mLength;
classrate(4)=classresult(4)/nLength;
classrate(5)=classresult(5)/oLength;
classrate(6)=classresult(6)/pLength;
classrate(7)=classresult(7)/qLength;
classrate(8)=classresult(8)/rLength;
classrate(9)=classresult(9)/uLength;
classrate(10)=classresult(10)/wLength;

% The following is about the processing of testing image
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


% Now we compare the testing image features with training image

% Find the distance between each character in testing image and each
% character in training image
D2 = dist2(normaltestFeatures,Features);
% find the closest match, the first column of D2_index shows the closest
% match, for example, D2_index(2,1) is the index in training set that 
% matches closest to the 2nd element of the testing set. 
% So tCounter(D2_index(69,1)) means the num of character that best matches
% the 69 element in the testing set
[D2_sorted,D2_index] = sort(D2,2);

% Get the result of recognizing the test set
testresult = tCounter(D2_index(:,1));

% Compute the test image recognition rate
T2 = length(testresult);
testrate = zeros(10,1);
result = zeros(10,1);
for i=1:T2
    if (testresult(i)==testCounter(i))
        result(testCounter(i))=result(testCounter(i))+1;
    end
end

testrate=result/10;