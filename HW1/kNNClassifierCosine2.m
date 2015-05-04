function label = kNNClassifierCosine2(k,data,labels,target)
%Predict the label of target image by the training set data.

[m,n] = size(data);
ddata = double(data);
dtarget = double(repmat(target,m,1));

%calculate cosine
diff = ddata .* dtarget;
distance = sum(diff,2)./(sqrt(sum((ddata.^2),2))).*(sqrt(sum((dtarget.^2),2)));
distance_backup = distance;
minDistance = min(distance);

% find k nearest neighbor
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
if length(maxCount) > 1
    % we have a tie
    score = zeros(length(maxCount),1);
    tieLabel = uniqueLabel(maxCount);
    for i = 1:length(maxCount)
       score(i) =  sum(distance_backup(find(kNN == tieLabel(i))));
    end
    maxScore = find(score == max(score));
    label = tieLabel(floor(rand(1) * length(maxScore)) + 1);
else
    label = uniqueLabel(maxCount);
end

end