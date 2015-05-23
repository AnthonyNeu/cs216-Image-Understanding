function [mag,ori] = mygradient(I)
%
% compute image gradient magnitude and orientation at each pixel
%

dy = conv2(I,[-1 1]','same');
dx = conv2(I,[-1 1],'same');
complex = dx + dy * 1i;

mag = abs(complex);
ori = angle(complex);
