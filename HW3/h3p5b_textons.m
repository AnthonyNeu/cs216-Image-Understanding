clc;
close;
clear;


%% some predifined parameters
% use the color of point within distance of 1
dist = 1;
lambda  = 0.0001;

%% read image
image = im2double(imread('figure/segtest1.jpg'));
figure;
imshow(image);

%% find two seed points,please pick background point first and frontground second
[X,Y] = ginput(2);

%% calculate histogram of quantized filter responses
response = calculate8FilterResponse(rgb2gray(image),[1 2 4]);

%% use color of seed point to initialize the backgroud and frontgroud color model
background = [floor(Y(1)) ,floor(X(1))];
foreground = [floor(Y(2)) ,floor(X(2))];

%% get the mean of background color and frontground color
back = response(background(1)-dist:background(1)+dist,background(2)-dist:background(2)+dist,:);
[a,b,c] = size(back);
backgroundColor = mean(reshape(back,[a*b c]));

fore = response(foreground(1)-dist:foreground(1)+dist,foreground(2)-dist:foreground(2)+dist,:);
[a,b,c] = size(fore);
foregroundColor = mean(reshape(fore,[a*b c]));

%% compute difference between pixels and background or frontground color
[H,W,D] = size(image);
N = H*W;
imagePixel = reshape(image,[N 3]);
distWithForeground = sqrt(sum((reshape(response,[N 8]) - repmat(foregroundColor,[N 1])).^2,2));
distWithBackground = sqrt(sum((reshape(response,[N 8]) - repmat(backgroundColor,[N 1])).^2,2));

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
