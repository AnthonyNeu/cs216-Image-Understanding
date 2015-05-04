clc;
close all;
clear;

% read the original image and resize it to 100*100
B = imread('image/original.jpg');
A = imresize(B,[100 100]);

% change it to rayscale image
A = rgb2gray(A);
figure,imshow(A);
colorbar;
A = im2double(A);
imwrite(A,'image/gray.jpg','JPEG');


%(a)
sort_A = sort(A(:));
figure;
plot(sort_A);
xlabel('Number of entries in image');
ylabel('Intensities Value');
title('Problem 3a');

%(b)
figure;
hist(sort_A,32);
ylabel('Number of entries in each bin');
xlabel('Intensities Value');
title('Problem 3b');

%(c)
threshold = median(sort_A);
binary_A = zeros(size(A));
binary_A(find(A>threshold)) = 1;
figure,imshow(binary_A);
colorbar;
title('Problem 3c');

%(d)
[m, n] = size(A);
bottomRight = A(m/2:m,n/2:n);
figure;
imshow(bottomRight);
colorbar;
title('Problem 3d');

%(e)
new = A - mean(sort_A);
new(new<0) = 0;
figure;
imshow(new);
colorbar;
title('Problem 3e');

%(f)
mirror = A(1:1:m,n:-1:1);
figure;
imshow(mirror);
colorbar;
title('Problem 3f');

%(g)

%(h)
mirror = imageDice(A);
figure;
imshow(mirror);
colorbar;
title('Problem 3h');

%(i)
y = [1:6];
z = reshape(y,3,2);

%(j)
x = min(min(A));
[r,c] = find(A == x);

%(k)
v = [1 8 8 2 1 3 9 8];
[temp,totalUnique] = size(unique(v));