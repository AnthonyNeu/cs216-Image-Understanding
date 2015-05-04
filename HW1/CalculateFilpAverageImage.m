function [] = CalculateFilpAverageImage(originalImage,OutputName)
%Calculate the average image
% Input:
%      dirname: directory name
%      OutputName:output name

[m,n,p,q] = size(originalImage);

for i = 1:q
    originalImage(:,:,:,i) = imageDice(originalImage(:,:,:,i));
end

colorAverage = mean(originalImage,4);
imwrite(colorAverage,OutputName,'JPEG');

figure,imshow(colorAverage);
colorbar;
axis image;

end