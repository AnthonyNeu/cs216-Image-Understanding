function [ x,y,score ] = mix_detect( I,template,ndet )
%
% return top ndet detections found by applying multiple templates to the given image.
%   x,y should contain the coordinates of the detections in the image
%   score should contain the scores of the detections
%


% compute the feature map for the image
f = hog(I);

nori = size(f,3);

number_template = size(template,4);

% cross-correlate template with feature map to get a total response
R = zeros(size(f,1),size(f,2),number_template);
for j = 1:number_template
    nowTemplate = template{j};
    for i = 1:nori
      R(:,:,j) = R(:,:,j) + conv2(f(:,:,i),rot90(nowTemplate(:,:,i),2),'same')/(norm(f(:,:,i)) * norm(nowTemplate(:,:,i)));
    end
end

% now return locations of the top ndet detections

% sort response from high to low
[val,ind] = sort(R(:),'descend');
[H,W,D] = size(R);

% work down the list of responses, removing overlapping detections as we go
i = 1;
detcount = 0;
x = zeros(ndet,1);
y = zeros(ndet,1);
score = zeros(ndet,1);

% use MSE for overlapping detection ,restrict a detection location to be at
% least 3 blocks from the existing one
minDist = 8 ^2 * 5 ^ 2;

while ((detcount < ndet) && (i < length(ind)))
  % convert ind(i) back to (i,j) values to get coordinates of the block
  zblock = floor((ind(i) - 1)/(H*W)) + 1;
  temp = ind(i) - (zblock - 1) * H * W;
  yblock = mod(temp-1,H)+1;
  xblock = floor((temp-1)/H)+1;

  assert(val(i)==R(yblock,xblock,zblock)); %make sure we did the indexing correctly

  % now convert yblock,xblock to pixel coordinates 
  ypixel = 8 * yblock;
  xpixel = 8 * xblock;

  % check if this detection overlaps any detections which we've already added to the list
  overlap = 0;
  if detcount > 0
      overlapDetector = (x(1:detcount) - xpixel) .^2 + (y(1:detcount) - ypixel) .^2;
      overlap = sum(overlapDetector < minDist)>0;
  end

  % if not, then add this detection location and score to the list we return
  if (~overlap)
    detcount = detcount+1;
    x(detcount) = xpixel;
    y(detcount) = ypixel;
    score(detcount) = R(yblock,xblock,zblock);
  end
  i = i + 1
end

if detcount < ndet
    x = x(1:detcount);
    y = y(1:detcount);
    score = score(1:detcount);
end

end

