function [result] = lmseNormalized(S,R,Shat,Rhat)
% compute LMSE base on the shading image and reflectance image.
% input is the original reflectance image, original shading image and
% separation result for these two layers.
% LMSE is based on paper: Ground truth dataset and baseline evaluations for intrinsic image algorithms

% base on the original paper, we choose 20 * 20 windows
result = 1/2 * lmse(S,Shat)/lmse(S,zeros(size(S))) + 1/2 * lmse(R,Rhat)/lmse(R,zeros(size(R)));


end


