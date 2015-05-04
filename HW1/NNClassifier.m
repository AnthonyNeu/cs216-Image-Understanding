function label = NNClassifier(data,labels,target)
%Predict the label of target image by the training set data.

[m,n] = size(data);
diff = double(data) - double(repmat(target,m,1));
%distance = sum(diff.^2,2);
distance = sqrt(sum(diff.^2,2));
min_label = find(distance == min(distance));
label = labels(min_label(floor(rand(1) * length(min(distance))) + 1));

end