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

%% test code using training data
% for i = 1:10000
%     testImage = image1.data(i,:);
%     testLabel = NNClassifier(image1.data,image1.labels,testImage);
%     if testLabel ~= image1.labels(i)
%         display(i);
%     end
% end


%% test the code with small amout of test data
data = [image1.data;image2.data;image3.data;image4.data;image5.data];
labels = [image1.labels;image2.labels;image3.labels;image4.labels;image5.labels];
total = length(test.labels);
error = 0;
parfor i = 1 :total
    display(i);
    testImage = test.data(i,:);
    testLabel = NNClassifier(data,labels,testImage);
    if testLabel ~= test.labels(i)
        error = error + 1;
    end
end
display(error/total);

