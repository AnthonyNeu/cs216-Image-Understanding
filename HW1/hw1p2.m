clc;
close;
clear;

setname = 'set2';
dirname = ['image/',setname];
fileformat = 'jpg';

[original,gray] = readImage(dirname,fileformat);
CalculateAverageGrayImage(gray,['image/GrayAverage',setname,'.jpg']);
CalculateAverageImage(original,['image/ColorAverage',setname,'.jpg']);
CalculateFilpAverageImage(original,['image/ColorFlipAverage',setname,'.jpg']);