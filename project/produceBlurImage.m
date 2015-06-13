function[blurImage,image2Blur] =  produceBlurImage(image1,image2)

[H,W,D] = size(image1);
image2 = imresize(image2,[H,W]);

% filter image1 with Gaussian
sigma = 5;
gauss = fspecial('gauss',[3 * sigma,3 * sigma],sigma);
image2Blur = imfilter(image2,gauss);

blurImage = 0.5 * (image1 + image2Blur);
end