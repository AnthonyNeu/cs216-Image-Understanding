clc;
close;
clear;


%% pick positive and negative image patches from one image
numPos = 2; % number of positive examples
numNeg = 3; % number of negative example

% load a training example image
Itrain = im2double(rgb2gray(imread('figure/test1.jpg')));
figure(1); clf;
imshow(Itrain);

% pick positive patches
positivePatch = cell(numPos,1);
negativePatch = cell(numNeg,1);
width = zeros(numPos+numNeg,1);
height = zeros(numPos+numNeg,1);
for i = 1:numPos+numNeg
    display(i);
    rect = getrect(figure(1));
    x = floor(rect(1));
    y = floor(rect(2));
    width(i) = floor(rect(3));
    height(i) = floor(rect(4));
    patch = Itrain(y:y+height(i),x:x+width(i));
    if i <= numPos
        positivePatch{i} = patch;
    else
        negativePatch{i - numPos} = patch;
    end
end

% resize the width and height of image
% (a)the aspect ratio should remain as close as possible to the original aspect
% ratio marked by the user
aspectRatio = width./height;
% (b)the resized examples have a height and width which is roughly the 
% average of the training examples
resizeHeight = mean(height);
resizeWidth = resizeHeight * mean(aspectRatio);
% (c) the resized positive examples should have a height and 
% width which are multiples of 8
resizeHeight = floor(resizeHeight/8) * 8;
resizeWidth = floor(resizeWidth/8) * 8;
templateHeight = resizeHeight/8;
templateWidth = resizeWidth/8;

% resize the positive patches
resizePosPatch = zeros(resizeHeight,resizeWidth,numPos);
for i = 1:numPos
    resizePosPatch(:,:,i) = imresize(positivePatch{i},[resizeHeight,resizeWidth]);
end

% resize the negative patches
resizeNegPatch = zeros(resizeHeight,resizeWidth,numNeg);
for i = 1:numNeg
    resizeNegPatch(:,:,i) = imresize(negativePatch{i},[resizeHeight,resizeWidth]);
end  

%% contruct template
positiveTemplate = zeros(templateHeight,templateWidth,9,numPos);
negativeTemplate = zeros(templateHeight,templateWidth,9,numNeg);
positiveTemplateSum = zeros(templateHeight,templateWidth,9);
negativeTemplateSum = zeros(templateHeight,templateWidth,9);
for i = 1:numPos
    positiveTemplate(:,:,:,i) = hog(resizePosPatch(:,:,i));
    positiveTemplateSum = positiveTemplateSum + positiveTemplate(:,:,:,i);
end
for i = 1:numNeg
    negativeTemplate(:,:,:,i) = hog(resizeNegPatch(:,:,i));
    negativeTemplateSum = negativeTemplateSum + negativeTemplate(:,:,:,i);
end

% for simple center model
template = positiveTemplateSum/numPos - negativeTemplateSum/numNeg;


%% test the tempalte
%
% load a test image
%
Itest= im2double(rgb2gray(imread('figure/test1.jpg')));


% find top 5 detections in Itest
ndet = 5;
[x,y,score] = detect(Itest,template,ndet);

%display top ndet detections
figure(3); clf; imshow(Itest);
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',[x(i)-64 y(i)-64 128 128],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end