clc;
close;
clear;

image1 = load('image/cifar-10-batches-mat/data_batch_1.mat');
image2 = load('image/cifar-10-batches-mat/data_batch_2.mat');
image3 = load('image/cifar-10-batches-mat/data_batch_3.mat');
image4 = load('image/cifar-10-batches-mat/data_batch_4.mat');
image5 = load('image/cifar-10-batches-mat/data_batch_5.mat');
label = load('image/cifar-10-batches-mat/batches.meta.mat');
test = load('image/cifar-10-batches-mat/test_batch.mat');
%% test the code with small amout of test data
confusionMatrix = zeros(10,10);
% data = image1.data;
% labels = image1.labels;
data = [image1.data;image2.data;image3.data;image4.data;image5.data];
labels = [image1.labels;image2.labels;image3.labels;image4.labels;image5.labels];
total = length(test.labels);
testLabel = zeros(total,1);
for i = 1 :total
    display(i);
    testImage = test.data(i,:);
    testLabel(i) = NNClassifier(data,labels,testImage);
end

%% set the confusion matrix
for i = 1 :total
    confusionMatrix(test.labels(i)+1,testLabel(i)+1)= confusionMatrix(test.labels(i)+1,testLabel(i)+1) + 1;
end

%% set the error rate
error = 0;
for i = 1 :10
   error = error + confusionMatrix(i,i);
end
display(1 -error/total);

figure;
imagesc(confusionMatrix);
colorbar;

