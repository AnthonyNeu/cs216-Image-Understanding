function result = lmse(S,Shat)
% compute LMSE of two images S and Shat


assert(size(S,1) == size(Shat,1) && size(S,2) == size(Shat,2));

k = 20;
[H,W,D]= size(S);
mse = 0;
for i = 1:k/2:H-k
    for j = 1:k/2:W-k
        for d = 1:D
            mse = mse + mean(sum((S(i:i+k,j:j+k,d) - Shat(i:i+k,j:j+k,d)).^2));
        end
    end
end

result = mse;

end

