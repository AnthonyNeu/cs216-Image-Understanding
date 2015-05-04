clc;
clear;
close;

%% get the test image and clip out patch of image
image = 1 - im2double(imread('figure/dilbert1.jpg'));
image = double(image > 0.5);
figure;
imshow(image);
% hp = impixelinfo;
% set(hp,'Position');
patch = image(50:64,375:386);
% try to blur the image
% gauss = fspecial('gaussian',[3 3],1);
% patch_blur = conv2(patch,gauss,'same');
imwrite(patch,'figure/template.jpg','JPEG');


%% filp the template and correclate with the image
template = rot90(patch,2);
corrResult = conv2(image,template,'same');
figure;
imagesc(corrResult);
colormap(jet);
colorbar;
truesize;
title('correlation');

%% thresholding
% this point smaller than its 8 neighbors will be labeled as 0
Left = corrResult(2:end-1,2:end-1) > corrResult(1:end-2,2:end-1);
Right = corrResult(2:end-1,2:end-1) > corrResult(3:end,2:end-1);
% UpperLeft = corrResult(2:end-1,2:end-1) > corrResult(1:end-2,1:end-2);
% UpperMiddle = corrResult(2:end-1,2:end-1) > corrResult(2:end-1,1:end-2);
% UpperRight = corrResult(2:end-1,2:end-1) > corrResult(3:end,1:end-2);
% BottomLeft = corrResult(2:end-1,2:end-1) > corrResult(1:end-2,3:end);
% BottomMiddle = corrResult(2:end-1,2:end-1) > corrResult(2:end-1,3:end);
% BottomRight = corrResult(2:end-1,2:end-1) > corrResult(3:end,3:end);
Threshold = corrResult(2:end-1,2:end-1) > 45;
%maxima = Left & Right & Threshold & UpperLeft & UpperMiddle & UpperRight & BottomLeft & BottomMiddle & BottomRight;
maxima = Left & Right & Threshold;

DrawRectangle(maxima,image,template);

