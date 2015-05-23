clc;
close;
clear;

%% specify the image for test
index = 4;
testImageName = strcat('figure/test',num2str(index-1),'.jpg');
generatePatches(index);

%% read positive and negative image patches
numPos = 5; % number of positive examples
numNeg = 100; % number of negative example
[resizeHeight,resizeWidth] = size(im2double(imread('figure/positive/test0Train.jpg')));
templateHeight = resizeHeight/8;
templateWidth = resizeWidth/8;
% resize the positive patches
resizePosPatch = zeros(resizeHeight,resizeWidth,numPos);
for i = 1:numPos
    imname = strcat('figure/positive/test',num2str(i - 1),'Train.jpg');
    resizePosPatch(:,:,i) = im2double(imread(imname));
end

% resize the negative patches
resizeNegPatch = zeros(resizeHeight,resizeWidth,numNeg);
for i = 1:numNeg
    imname = strcat('figure/negative/patch',num2str(i - 1),'.jpg');
    resizeNegPatch(:,:,i) = im2double(imread(imname));
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
Itest= im2double(rgb2gray(imread(testImageName)));


% find top 5 detections in Itest
ndet = 5;
resizeFactor = 0.7;
[x,y,score,level] = multiscale_detect(Itest,template,ndet,resizeFactor);

%display top ndet detections
figure
imshow(Itest);
for i = 1:ndet
    
    blockHeight = templateHeight*8/(resizeFactor^level(i));
    blockWidth = templateWidth*8/(resizeFactor^level(i));
    
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',[x(i)-(blockWidth/2) y(i)-(blockHeight/2) blockWidth blockHeight],...
      'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],...
      'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end