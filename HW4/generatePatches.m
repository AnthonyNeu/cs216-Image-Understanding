function [] = generatePatches(index)
% use to pick 5 positive patches and generate 100 negative patches
% there are 7 training images
% use test_index.jpg to generate these examples, negative examples are
% generated randomly

numPos = 5; % number of positive examples
numNeg = 100; % number of negative example

positivePatch = cell(numPos,1);
x = zeros(numPos,1);
y = zeros(numPos,1);
width = zeros(numPos,1);
height = zeros(numPos,1);

%% pick 5 positive example
perm = ones(7,1) * index;
for j = 1:numPos
    % load a training example image
    imname = strcat('figure/test',num2str(perm(j) - 1),'.jpg'); 
    Itrain = im2double(rgb2gray(imread(imname)));
    figure(1); clf;
    imshow(Itrain);

    rect = getrect(figure(1));
    x(j) = floor(rect(1));
    y(j) = floor(rect(2));
    width(j) = floor(rect(3));
    height(j) = floor(rect(4));
    patch = Itrain(y(j):y(j)+height(j),x(j):x(j)+width(j));
    positivePatch{j} = patch;
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
    %imname = strcat('figure/positive/test',num2str(perm(i) - 1),'Train.jpg');
    imname = strcat('figure/positive/test',num2str(i-1),'Train.jpg');
    imwrite(resizePosPatch(:,:,i),imname,'JPEG');
end

%% for each image, generate 20 negative images
for i = 1:numPos
    imname = strcat('figure/test',num2str(perm(i) - 1),'.jpg'); 
    Itrain = im2double(rgb2gray(imread(imname)));
    imsize = size(Itrain);
    H = imsize(1)-height(i);
    W = imsize(2)-width(i);

    numPics = 20;
    index = 0;
    % for overlapping test with the positive example
    minDist = (height(i)^2 + width(i)^2);
    while index < numPics
        randXvals = floor(rand(1)*W + width(i)/2)+1;
        randYvals = floor(rand(1)*H + height(i)/2)+1;
        overlap = (((randYvals - height(i)/2 - y(i))^2 + (randXvals - width(i)/2 - x(i))^2) < minDist);
        
        if ~overlap
           imname = strcat('figure/negative/patch',num2str(index + (i-1) * numPics),'.jpg'); 
           patch = Itrain(randYvals - floor(height(i)/2) :randYvals+floor(height(i)/2),...
           randXvals - floor(width(i)/2):randXvals+floor(width(i)/2));
           imwrite(imresize(patch, [resizeHeight,resizeWidth]),imname,'JPEG');
           index = index + 1;
        end
    end 
end

end