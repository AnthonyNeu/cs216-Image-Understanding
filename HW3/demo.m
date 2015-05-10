im = imread('figure/demo.png');
im = double(im);
noisy = im + randn(size(im));
[H,W] = size(im);

N = H*W;

lambda = 1;
segclass = zeros(N,1);
pairwise = sparse(N,N);

% Define binary classification problem
labelcost = [0 1;1 0]*lambda;
unary = [abs(noisy(:)-0) abs(noisy(:)-1)]';

%add all horizontal links
for x = 1:W-1
  for y = 1:H
    node  = 1 + (y-1) + (x-1)*H;
    right = 1 + (y-1) + x*H;
    pairwise(node,right) = 1;
    pairwise(right,node) = 1;
  end
end

%add all vertical nbr links
for x = 1:W
  for y = 1:H-1
    node = 1 + (y-1) + (x-1)*H;
    down = 1 + y + (x-1)*H;
    pairwise(node,down) = 1;
    pairwise(down,node) = 1;
  end
end

[labels E Eafter] = GCMex(segclass, single(unary), pairwise, single(labelcost),0);

subplot(311);
imagesc(im);
title('Original image');
subplot(312);
imagesc(noisy);
title('Noisy image');
subplot(313);
imagesc(reshape(labels,[H W]));
title('Min-cut');
