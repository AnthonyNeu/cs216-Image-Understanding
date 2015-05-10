function [response] = calculate8FilterResponse(image,sigma)
%% calculate the response of image filtered by 8 filterbanks
% the 8 filters are 6 gaussian derivative filters with 3 different sigma
% and two additional center surround filters by 
% taking the different of two isotropic Gaussian functions at two different
% scales.


%% gaussian derivative filter
[m,n] = size(image);
response = zeros(m,n,8);
for k = 1 : length(sigma)
     [response(:,:,2 * k - 1),response(:,:,2 * k)] = GaussianDeriFilter(image,sigma(k));
end

%% center around filter
response(:,:,7) = GaussianDiff(image,2,1);
response(:,:,8) = GaussianDiff(image,4,2);

%% plot the filterbank result
for i = 1:8
   figure;
   imagesc(response(:,:,i));
   colormap gray;
end