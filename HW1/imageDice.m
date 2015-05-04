function [A] = imageDice(original)
%equally likely return original image or the mirror-flipped image

flag = diceRoll();

if flag <=3
    A = original;
else
    [m,n,d] = size(original);
    A = original(1:1:m,n:-1:1,:);
end
