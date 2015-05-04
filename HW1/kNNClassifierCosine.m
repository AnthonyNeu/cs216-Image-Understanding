function label = kNNClassifierCosine(k,data,labels,target)
%Predict the label of target image by the training set data.

[m,n] = size(data);
ddata = double(data);
dtarget = double(repmat(target,m,1));
diff = ddata .* dtarget2;
distance = sum(diff,2)./(sqrt(sum((ddata.^2),2))).*(sqrt(sum((dtarget.^2),2)));
minDistance = min(distance);
kNN = zeros(1,k);

for i = 1: k
   [maxDistance,maxIndex] = max(distance);
   kNN(i) = labels(maxIndex);
   distance(maxIndex) = minDistance;
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