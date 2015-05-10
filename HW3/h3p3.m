clc;
close;
clear;
image = im2double(rgb2gray(imread('figure/zebra_small.jpg')));

%% try to find 3 patches
% figure;
% imshow(image);
% hp = impixelinfo;
% set(hp,'Position');

%% the neck of zebra
length = 20;
patch1 = image(90-length:90+length,160 - length:160+length);
% figure;
% imshow(patch1);


%% tree leaves above the zebra's back
length = 20;
patch2 = image(50-length:50+length,160 - length:160+length);
% figure;
% imshow(patch2);

%% the grass in front of the zebra
length = 20;
patch3 = image(190-length:190+length,40 - length:40+length);
% figure;
% imshow(patch3);

%% compute absolute response of 8 filters in problem 2
sigma = [1,2,4];
[m,n] = size(patch1);
response = zeros(m,n,8);
patches = zeros(m,n,3);
patches(:,:,1) = patch1;
patches(:,:,2) = patch2;
patches(:,:,3) = patch3;

for i = 1:3
    for k = 1 : 3
         [response(:,:,2*k-1),response(:,:,2*k)] = GaussianDeriFilter(patches(:,:,i),sigma(k));
%          figure;
%          imagesc(response(:,:,k));
%          colormap gray;
%          figure;
%          imagesc(response(:,:,k+1));
%          colormap gray;
    end
    response(:,:,7) = GaussianDiff(patches(:,:,i),2,1);
%     figure;
%     imagesc(response(:,:,7));
%     colormap(gray);
    response(:,:,8) = GaussianDiff(patches(:,:,i),4,2);
%     figure;
%     imagesc(response(:,:,8));
%     colormap(gray);
%     
    %% Compute the mean absolute responses of the filterbank channels
    meanResponse = zeros(8,1);
    for j=1:8
        meanResponse(j) = mean(mean(abs(response(:,:,j))));
    end

    figure;
    bar(meanResponse);
    set(gca,'XTickLabel',{'vert,sigma = 1', 'hori,sigma = 1',...
            'vert,sigma = 2', 'hori,sigma = 2', 'vert,sigma = 4',...
            'vert,sigma = 4', 'G2 - G1', 'G4-G2'});
    ylabel('Response');
    if i == 1
        as = axis();
    end
    if i > 1
        axis(as);
    end
end

