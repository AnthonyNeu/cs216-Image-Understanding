function [originalImage,grayImage] = readImage(dirname,fileformat)
% This function read image from a set of image and resize it to the same
% size
% Input:
%      dirname: directory name
%      firformat:format of image
%Output:
%      originalImage:matrix of all images in the directory
%      grayImage:matrix of all images' grayscale transformation

dirString = [dirname,'/*.',fileformat];
list = dir(dirString);
numofImage = length(list);

%get the first image and decide the size of image
firstImage = imread([dirname,'/',list(1).name]);
firstGrayImage = rgb2gray(firstImage);
[m,n,d] = size(firstImage);
originalImage = zeros(m,n,3,numofImage);
grayImage = zeros(m,n,numofImage);
originalImage(:,:,:,1) = im2double(firstImage);
grayImage(:,:,1) = im2double(firstGrayImage);

for i = 2 : numofImage
    Image = imread([dirname,'/',list(i).name]);
    Image = imresize(Image,[m n]);
    GrayImage = rgb2gray(Image);
    originalImage(:,:,:,i) = im2double(Image);
    grayImage(:,:,i) = im2double(GrayImage);
end
end