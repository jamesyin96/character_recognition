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
conf = ConfusionMatrix(regclass, tCounter, 10);
figure();
imagesc(conf);
title('Confusion Matrix');

% Now compute the features of test image
%testIm = imread('test.jpg');
%testFeatures = ReadBinarizeExtractFeatures(testIm,0);
%testLength = length(testFeatures);

% Normalize the test features with means and var from the training set
%testFeatures = zeros(testLength,6);
%for i=1:6
%testFeatures(:,i)= (testFeatures(:,i) - meanFeatures(i))/sqrt(varFeatures(i));
%end
