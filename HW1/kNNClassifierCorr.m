function label = kNNClassifierCorr(k,data,labels,target)
%Predict the label of target image by the training set data.

[m,n] = size(data);
ddata = double(data);
dtarget = double(repmat(target,m,1));

%calculate correlation
ddata1 = ddata - repmat(mean(ddata,2),1,n);
dtarget1 = dtarget - repmat(mean(dtarget,2),1,n);
diff = ddata1 .* dtarget1;
distance = sum(diff,2)./(sqrt(sum((ddata1.^2),2))).*(sqrt(sum((dtarget1.^2),2)));

% find k nearest neighbor
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