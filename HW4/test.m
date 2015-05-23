clc;
clear;
close;

numPos = 5;
[resizeHeight,resizeWidth] = size(im2double(imread('figure/positive/test0Train.jpg')));
templateHeight = resizeHeight/8;
templateWidth = resizeWidth/8;
% resize the positive patches
resizePosPatch = zeros(resizeHeight,resizeWidth,1,numPos);
for i = 1:numPos
    imname = strcat('figure/positive/test',num2str(i - 1),'Train.jpg');
    resizePosPatch(:,:,1,i) = im2double(imread(imname));
end

montage(resizePosPatch,'Size',[1 5]);