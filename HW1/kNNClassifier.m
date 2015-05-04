function label = kNNClassifier(k,data,labels,target)
%Predict the label of target image by the training set data.

[m,n] = size(data);
diff = double(data) - double(repmat(target,m,1));
distance = sum(diff.^2,2);
maxDistance = max(distance);
kNN = zeros(1,k);

for i = 1: k
   [minDistance,minIndex] = min(distance);
   kNN(i) = labels(minIndex);
   distance(minIndex) = maxDistance;
end

%calculate unique labels
uniqueLabel = unique(kNN);
labelCount = zeros(length(uniqueLabel),1);
for i = 1:length(uniqueLabel)
   labelCount(i) = length(find(kNN == uniqueLabel(i))); 
end

%get the most frequent label
maxCount = find(labelCount == max(labelCount));
label = uniqueLabel(floor(rand(1) * length(maxCount)) + 1);

end