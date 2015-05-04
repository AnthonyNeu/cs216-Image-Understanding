function [] = CalculateAverageImage(originalImage,OutputName)
%Calculate the average image
% Input:
%      dirname: directory name
%      OutputName:output name

colorAverage = mean(originalImage,4);
imwrite(colorAverage,OutputName,'JPEG');

figure,imshow(colorAverage);
colorbar;
axis image;

end