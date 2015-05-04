clc;
close;
clear;

r1 = load('hw1p33_allimage');
r2 = load('hw1p34_k=3.mat');
r3 = load('hw1p34_k=5.mat');

result = (r1.testLabel ~= r1.test.labels) + (r2.testLabel(1:10000) ~= r2.test.labels) + (r3.testLabel(1:10000) ~= r3.test.labels);

image = r1.test.data(7,:);
% resize it to 32 * 32
Image = zeros(32,32,3);
Image(:,:,1) = reshape(image(1:1024),32,32)';
Image(:,:,2) = reshape(image(1025:2048),32,32)';
Image(:,:,3) = reshape(image(2049:3072),32,32)';

figure;
imshow(uint8(Image));
axis image;