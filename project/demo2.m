clc;
clear;
close;

%% Intrinsic Image Decomposition
disp('Intrinsic Images Example');
lambda = [0];
lmse = zeros(length(lambda),1);
testname = 'turtle';
for i = 1:length(lambda)
    I1 = im2double(imread(['figure/',testname,'/diffuse.png'])); 
    R = im2double(imread(['figure/',testname,'/reflectance.png'])); 
    S = im2double(imread(['figure/',testname,'/shading.png'])); 
    [Rhat Shat] = Intrinsic_Relsmo(I1, lambda(i));

    figure(i),
    subplot 131, imshow(I1), title('input');
    subplot 132, imshow(Rhat); title('reflectace');
    subplot 133, imshow(Shat); title('shading');
    
%     imwrite(Rhat,'teabag1_r.jpg','JPEG');
%     imwrite(Shat,'teabag1_s.jpg','JPEG');

    
    %% evaluate the decomposition based on the LMSE
    lmse(i) = lmse2(R,S,Rhat,Shat,20);
end