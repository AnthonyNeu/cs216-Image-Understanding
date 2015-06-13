clc;
clear;
close;

% test the lambda to decompse a image produce by I = I1 + I2 * Gauss Filter
disp('Reflection Removal Example');
% image1 = im2double(imread('figure/peppers.bmp'));
% image2 = im2double(imread('figure/baboon.jpg')); 
image1 = im2double(imread('figure/b1.jpg'));
image2 = im2double(imread('figure/r1.jpg'));
[h,w,d] = size(image1);
image2resize = zeros(h,w,d);
for i = 1:d
    image2resize(:,:,i) = imresize(image2(:,:,i),[h,w]);
end
[I,I2Blur] = produceBlurImage(image1,image2resize);
[H W D] = size(I);
lambda = [2,10,100,1000];
ssimB = zeros(length(lambda),1);
ssimR = zeros(length(lambda),1);
for i = 1:1
    [LB LR] = septRelSmo(I, lambda(i), zeros(H,W,D), I);
    figure, imshow(I);
    figure, imshow(LB*2);
    figure, imshow(LR*2);
    ssimB(i) = ssim(I,image1);
    ssimR(i) = ssim(LB*2,image1);
end