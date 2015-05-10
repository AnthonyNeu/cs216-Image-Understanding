function [vertResult,horiResult] = GaussianDeriFilter(target,sigma)
% this function is used to generate a gaussian derivative filter
%  then conduct the convolution

gauss = fspecial('gaussian',[3 * sigma 3 * sigma],sigma);
gaussFilter = gauss(ceil(3 * sigma/2),:);

conv = conv2(target,gaussFilter,'same');

vertResult = conv2(conv,[-1 1]','same');
horiResult = conv2(conv,[-1 1],'same');
end