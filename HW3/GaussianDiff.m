function [result] = GaussianDiff(target,sigma1,sigma2)
% this function is used to generate a gaussian derivative filter
%  then conduct the convolution

gauss1 = fspecial('gaussian',[3 * sigma1 3 * sigma1],sigma1);
gauss2 = fspecial('gaussian',[3 * sigma2 3 * sigma2],sigma2);

result = conv2(target,gauss1,'same') - conv2(target,gauss2,'same');
end