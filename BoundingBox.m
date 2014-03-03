% BoundingBox.m
% This function returns the boundingbox of each connected component
% Input-binary image im2
%      -image matrix L with connected component labeled
% Output-the Features matrix of this binary image im2
function [y,Box] = BoundingBox(im2, L)
Nc = max(max(L));
figure();
imagesc(L);
hold on;
Features = [];
Box = zeros(Nc,4);
counter=1;
for i=1:Nc;
    [r,c] = find(L == i);
    maxr = max(r);
    minr = min(r);
    maxc = max(c);
    minc = min(c);
    size = (maxr - minr)*(maxc - minc);
    if (size > 100)
        Cim = im2(minr-1:maxr+1, minc-1:maxc+1);
        Box(counter,:) = [minr-1,maxr+1,minc-1,maxc+1];
        counter = counter + 1;
        [centroid, theta, roundness, inmo] = moments(Cim, 1);
        Features = [Features; centroid, theta, roundness, inmo];
        rectangle('Position',[minc, minr, maxc-minc+1, maxr-minr+1], 'EdgeColor','w');
    end
end
hold off;
y = Features;