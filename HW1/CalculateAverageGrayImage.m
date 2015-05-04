function [] = CalculateAverageGrayImage(grayImage,OutputName)
%Calculate the grayscale average image
% Input:
%      dirname: directory name
%      OutputName:output name

grayAverage = mean(grayImage,3);
imwrite(grayAverage,OutputName,'JPEG');

figure,imshow(grayAverage);
colorbar;
axis image;


end