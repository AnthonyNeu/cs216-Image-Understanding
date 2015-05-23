function [ x,y,score,levelFinal ] = multiscale_detect( I,template,ndet,resizeFactor )
% return top ndet detections found by applying image pyramid from the original input to the given image.

currentImage = I;
[templateHeight,templateWidth,D] = size(template);
done = (size(currentImage,1) < templateHeight * 8) && (size(currentImage,2) < templateWidth * 8);
xval = [];yval = [];scoreval = [];levelval = [];
level = 0;
while ~done
    [xtemp,ytemp,scoretemp] = detect(currentImage,template,ndet);
    xtemp = floor(xtemp./(resizeFactor ^ level));
    ytemp = floor(ytemp./(resizeFactor ^ level));
    xval = [xval;xtemp];
    yval = [yval;ytemp];
    scoreval = [scoreval;scoretemp];
    levelval = [levelval;zeros(size(xtemp))+level];
    
    % not done, do next level
    done = (size(currentImage,1) < templateHeight * 8) && (size(currentImage,2) < templateWidth * 8);
    currentImage = imresize(currentImage,resizeFactor);
    level = level + 1; 
end

[val ind] = sort(scoreval,'descend');
x = xval(ind(1:ndet));
y = yval(ind(1:ndet));
levelFinal = levelval(ind(1:ndet));
score = scoreval(ind(1:ndet));

end

