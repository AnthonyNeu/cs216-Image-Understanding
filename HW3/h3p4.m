clc;
close;
clear;

image = im2double(rgb2gray(imread('figure/zebra_small.jpg')));

%% compute 8 filtering result
[m,n] = size(image);
sigma = [1,2,4];
response = zeros(m,n,8);
for k = 1 : 3
     [response(:,:,2*k-1),response(:,:,2*k)] = GaussianDeriFilter(image,sigma(k));
end
response(:,:,7) = GaussianDiff(image,2,1);
response(:,:,8) = GaussianDiff(image,4,2);

%% k-means
imageData = reshape(response,[m*n 8]);
[index,center] = kmeans(imageData,20);
imagePixelIndex = reshape(index,[m n]);
figure;
imagesc(imagePixelIndex);
colormap jet;
colorbar;
