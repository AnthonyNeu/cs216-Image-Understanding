clc;
close;
clear;

I1 = im2double(rgb2gray(imread('figure/paper1/diffuse.png'))); 
R = im2double(rgb2gray(imread('figure/paper1/reflectance.png'))); 
S = im2double(imread('figure/paper1/shading.png')); 

figure;
result = conv2(I1,[-1 1],'same');
hist(sort(result(:)),128);
ylabel('Number of entries in each bin');
xlabel('derivatives Value');

figure;
result = conv2(R,[-1 1],'same');
hist(sort(result(:)),128);
ylabel('Number of entries in each bin');
xlabel('Intensities Value');

figure;
result = conv2(S,[-1 1],'same');
hist(sort(result(:)),128);
ylabel('Number of entries in each bin');
xlabel('Intensities Value');

