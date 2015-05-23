% use to pick 5 positive examples for one variation of positive example

numPos = 5; % number of mixture templates

positivePatch = cell(numPos,1);
x = zeros(numPos,1);
y = zeros(numPos,1);
width = zeros(numPos,1);
height = zeros(numPos,1);

%% pick 5 positive example
for j = 1:numPos
    % load a training example image
    imname = strcat('figure/people.jpg'); 
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
    imname = strcat('figure/mix2/mix',num2str(i-1),'.jpg');
    imwrite(resizePosPatch(:,:,i),imname,'JPEG');
end