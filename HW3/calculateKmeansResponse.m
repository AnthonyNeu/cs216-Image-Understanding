function [response] = calculateKmeansResponse(image,k)
%% build a histogram of quantized colors with k-means 
[m,n,d] = size(image);
imagePixel = reshape(image, [m*n d]);
[index,center]= kmeans(imagePixel,k);
newImage = zeros(m*n,3);
for i = 1:m*n
    newImage(i,:) = center(index(i),:);
end
response = reshape(newImage,[m n d]);
