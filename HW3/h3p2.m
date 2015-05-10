clc;
close;
clear;
image = im2double(rgb2gray(imread('figure/zebra1.jpg')));
image = imresize(image,[600,800]);

%% gaussian derivative filter
sigma = [1,2,4];
[m,n] = size(image);
vertimage = zeros(m,n,3);
horiimage = zeros(m,n,3);
for k = 1 : 3
     [vertimage(:,:,k),horiimage(:,:,k)] = GaussianDeriFilter(image,sigma(k));
     figure;
     imagesc(vertimage(:,:,k));
     colormap gray;
     figure;
     imagesc(horiimage(:,:,k));
     colormap gray;
end

%% center around filter
result1 = GaussianDiff(image,2,1);
figure;
imagesc(result1);
colormap(gray);
result2 = GaussianDiff(image,4,2);
figure;
imagesc(result2);
colormap(gray);



