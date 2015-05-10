clc;
close;
clear;

image = im2double(imread('figure/simpsons.jpg'));
[m,n,d] = size(image);
imagePixel = reshape(image,[m*n 3]);

%k-means
k = 20;
[index,center]= kmeans(imagePixel,k);
newImage = zeros(m*n,3);
for i = 1:m*n
    newImage(i,:) = center(index(i),:);
end
newImageOutput = reshape(newImage,[m n d]);
imagetitle = strcat('figure/simpsons_k=',num2str(k),'.jpg');
imwrite(newImageOutput,imagetitle,'JPEG');

%scale the R value to be 100 * R
imagePixel1 = reshape(image,[m*n 3]);
imagePixel1(:,1) = imagePixel1(:,1) .* 100;
[index,center]= kmeans(imagePixel1,k);
newImage1 = zeros(m*n,3);
for i = 1:m*n
    newImage1(i,:) = center(index(i),:);
end
newImage1(:,1) = newImage1(:,1) ./ 100;
newImageOutput1 = reshape(newImage1,[m n d]);
imagetitle = strcat('figure/simpsons_red_k=',num2str(k),'.jpg');
imwrite(newImageOutput1,imagetitle,'JPEG');

