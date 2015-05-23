
function [x,y,score] = detect(I,template,ndet)
%
% return top ndet detections found by applying template to the given image.
%   x,y should contain the coordinates of the detections in the image
%   score should contain the scores of the detections
%


% compute the feature map for the image
f = hog(I);

nori = size(f,3);

% cross-correlate template with feature map to get a total response
R = zeros(size(f,1),size(f,2));
for i = 1:nori
  R = R + conv2(f(:,:,i), rot90(template(:,:,i),2), 'same');
end

% now return locations of the top ndet detections

% sort response from high to low
[val,ind] = sort(R(:),'descend');

tm = size(template,1);
tn = size(template,2);
x = zeros(ndet,1);
y = zeros(ndet,1);
score = zeros(ndet,1);

% work down the list of responses, removing overlapping detections as we go
i = 1;
detcount = 0;
while ((detcount < ndet) && (i < length(ind)))
  % convert ind(i) back to (i,j) values to get coordinates of the block
  yblock = mod(ind(i),size(f,1));
  xblock = ceil(ind(i)/size(f,1));
  if yblock == 0
      yblock = size(f,1);
  end

  assert(val(i)==R(yblock,xblock)); %make sure we did the indexing correctly

  % now convert yblock,xblock to pixel coordinates 
  ypixel = yblock*8;
  xpixel = xblock*8;

  % check if this detection overlaps any detections which we've already added to the list
  overlap = 0;
  if min(abs(y-ypixel))<(tm*4) && min(abs(x-xpixel))<(tn*4)
      overlap = 1;
  end
  
  % if not, then add this detection location and score to the list we return
  if (~overlap)
    detcount = detcount+1;
    x(detcount) = xpixel;
    y(detcount) = ypixel;
    score(detcount) = R(yblock,xblock);
  end
  i = i + 1;
end


