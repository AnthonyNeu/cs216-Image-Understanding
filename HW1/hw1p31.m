clc;
clear;
close;

image = load('image/cifar-10-batches-mat/test_batch.mat');
label = load('image/cifar-10-batches-mat/batches.meta.mat');

% get the # of label airplane
for i = 1:length(label.label_names)
    if strcmp(label.label_names{i} , 'bird')
        airplane_label = i;
    end
end

% get the first airplane image
for i = 1: length(image.labels)
   if image.labels(i) == airplane_label-1
       airplane_image = image.data(i,:);
       %break;
   end
end

% resize it to 32 * 32
Image = zeros(32,32,3);
Image(:,:,1) = reshape(airplane_image(1:1024),32,32)';
Image(:,:,2) = reshape(airplane_image(1025:2048),32,32)';
Image(:,:,3) = reshape(airplane_image(2049:3072),32,32)';

figure;
imshow(uint8(Image));
axis image;


