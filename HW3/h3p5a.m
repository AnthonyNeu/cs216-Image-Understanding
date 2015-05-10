clc;
close;
clear;


%% some predifined parameters
% use the color of point within distance of 1
dist = 1;
lambda  = 0.001;

%% read image
image = im2double(imread('figure/segtest1.jpg'));
figure;
imshow(image);

%% find two seed points,please pick background point first and frontground second
[X,Y] = ginput(2);

%% use color of seed point to initialize the backgroud and frontgroud color model
background = [floor(Y(1)) ,floor(X(1))];
foreground = [floor(Y(2)) ,floor(X(2))];

%% get the mean of background color and frontground color
backR = image(background(1)-dist:background(1)+dist,background(2)-dist:background(2)+dist,1);
backG = image(background(1)-dist:background(1)+dist,background(2)-dist:background(2)+dist,2);
backB = image(background(1)-dist:background(1)+dist,background(2)-dist:background(2)+dist,3);
backgroundColor = [mean(mean(backR)) mean(mean(backG)) mean(mean(backB))];

foreR = image(foreground(1)-dist:foreground(1)+dist,foreground(2)-dist:foreground(2)+dist,1);
foreG = image(foreground(1)-dist:foreground(1)+dist,foreground(2)-dist:foreground(2)+dist,2);
foreB = image(foreground(1)-dist:foreground(1)+dist,foreground(2)-dist:foreground(2)+dist,3);
foregroundColor = [mean(mean(foreR)) mean(mean(foreG)) mean(mean(foreB))];

%% compute difference between pixels and background or frontground color
[H,W,D] = size(image);
N = H*W;
imagePixel = reshape(image,[N 3]);
distWithForeground = sqrt(sum((imagePixel - repmat(foregroundColor,[N 1])).^2,2));
distWithBackground = sqrt(sum((imagePixel - repmat(backgroundColor,[N 1])).^2,2));

%% Define binary classification problem
labelcost = [0 1;1 0]*lambda;
unary = [distWithForeground distWithBackground]';
segclass = zeros(N,1);
pairwise = sparse(N,N);

%% add all horizontal links
for x = 1:W-1
  for y = 1:H
    node  = 1 + (y-1) + (x-1)*H;
    right = 1 + (y-1) + x*H;
    distance = norm(imagePixel(node,:) - imagePixel(right,:));
    pairwise(node,right) = distance;
    pairwise(right,node) = distance;
  end
end

%% add all vertical nbr links
for x = 1:W
  for y = 1:H-1
    node = 1 + (y-1) + (x-1)*H;
    down = 1 + y + (x-1)*H;
    distance = norm(imagePixel(node,:) - imagePixel(down,:));
    pairwise(node,down) = distance;
    pairwise(down,node) = distance;
  end
end

[labels E Eafter] = GCMex(segclass, single(unary), pairwise, single(labelcost),0);

figure;
imagesc(image);
title('Original image');
hold on;
plot(floor(X),floor(Y),'rx','LineWidth',2);
figure;
imagesc(reshape(labels,[H W]));
title('Min-cut');
