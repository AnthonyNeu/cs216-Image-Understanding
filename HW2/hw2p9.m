clc;
close;
clear;

%% get the test image and clip out patch of image
image = 1 - im2double(imread('figure/dilbert1.jpg'));
image = double(image > 0.5);
patch = image(50:64,375:386);


%% filp the template and correclate with the image
template = rot90(patch,2);
IT = conv2(image,template,'same');
Tsquared = sum(sum(template.^2));
Isquared = conv2(image.^2,ones(size(template)),'same');
squareddiff = Isquared - 2*IT + Tsquared;
corrResult = squareddiff;

%% thresholding
% this point smaller than its 8 neighbors will be labeled as 0
Left = corrResult(2:end-1,2:end-1) < corrResult(1:end-2,2:end-1);
Right = corrResult(2:end-1,2:end-1) < corrResult(3:end,2:end-1);
UpperLeft = corrResult(2:end-1,2:end-1) < corrResult(1:end-2,1:end-2);
UpperMiddle = corrResult(2:end-1,2:end-1) < corrResult(2:end-1,1:end-2);
UpperRight = corrResult(2:end-1,2:end-1) < corrResult(3:end,1:end-2);
BottomLeft = corrResult(2:end-1,2:end-1) < corrResult(1:end-2,3:end);
BottomMiddle = corrResult(2:end-1,2:end-1) < corrResult(2:end-1,3:end);
BottomRight = corrResult(2:end-1,2:end-1) < corrResult(3:end,3:end);
Threshold = corrResult(2:end-1,2:end-1) < 35;
minimum = Left & Right & Threshold & UpperLeft & UpperMiddle & UpperRight & BottomLeft & BottomMiddle & BottomRight;


DrawRectangle(minimum,image,template);



