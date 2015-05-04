clc;
close;
clear;

%% read image and convert to gray image
image1 = im2double(rgb2gray(imread('figure/zebra1.jpg')));
% figure;
% imagesc(image1);
% colormap(gray);
% colorbar;
% title('input image');

%% try use different variance Gaussian function to smooth the image
sigma = 1;
gauss = fspecial('gaussian',[3 3],sigma);
smoothImage = conv2(image1,gauss,'same');
% figure;
% imagesc(smoothImage);
% colormap(gray);
% colorbar;
% title('smooth image with sigma = 1 Gaussian filter');

%% calculate the horizontal gradient
filter1 = [-1 1];
horizonGradientImage = conv2(smoothImage,filter1,'same');
figure;
imagesc(horizonGradientImage);
colormap(gray);
colorbar;
title('horizontal derivative');
%% calculate the vertical gradient
filter2 = [-1 1]';
verticalGradientImage = conv2(smoothImage,filter2,'same');
figure;
imagesc(verticalGradientImage);
colormap(gray);
colorbar;
title('vertical derivative');

%% compute the gradient magnitude and orientation
gradientMagnitude = abs(horizonGradientImage + verticalGradientImage .* 1i);
orientation = angle(horizonGradientImage + verticalGradientImage .* 1i);
figure;
imagesc(gradientMagnitude);
colormap(gray);
colorbar;
title('gradient magnitude');
figure;
imagesc(orientation);
colormap(gray);
colorbar;
title('orientation');
