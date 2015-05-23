function ohist = hog(I)
%
% compute orientation histograms over 8x8 blocks of pixels
% orientations are binned into 9 possible bins
%
% I : grayscale image of dimension HxW
% ohist : orinetation histograms for each block. ohist is of dimension (H/8)x(W/8)x9
%

[h,w] = size(I); %size of the input
h2 = ceil(h/8); %the size of the output
w2 = ceil(w/8);
nori = 9;       %number of orientation bins

[mag,ori] = mygradient(I);
thresh = 0.1*max(mag(:));  %threshold for edges
thresholdIdx = (mag>thresh); %index for the pixel with larger magnitude than threshold

% generate each bin's angle
binMin = -pi/2:pi/9:pi/2 - pi/9;
binMax = -pi/2+pi/9:pi/9:pi/2;

% separate out pixels into orientation channels
ohist = zeros(h2,w2,nori);
for i = 1:nori
  % create a binary image containing 1's for the pixels that are edges at this orientation
  B = thresholdIdx & (ori>=binMin(i)) & (ori<=binMax(i)); 

  % sum up the values over 8x8 pixel blocks.
  chblock = im2col(B,[8 8],'distinct');  %useful function for grabbing blocks
                                         %sum over each block and store result in ohist
  ohist(:,:,i) = reshape(sum(chblock),[h2,w2]);                     
end

% normalize the histogram so that sum over orientation bins is 1 for each block
%   NOTE: Don't divide by 0! If there are no edges in a block (ie. this counts sums to 0 for the block) then just leave all the values 0. 

normFactor = sum(ohist,3);
normFactor = normFactor + (normFactor == 0);
for i = 1:nori
   ohist(:,:,i) =  ohist(:,:,i)./normFactor;
end


