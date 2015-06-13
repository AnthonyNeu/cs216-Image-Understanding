clear;
close;
I=imread('figure/paper1/reflectance.png');
 
s=size(I,1)*size(I,2);
scale_down=0.95; % we want to plot only 5% color
RANDperm = randperm(s); % randomly choosing those 5% colors
R=double(reshape(I(:,:,1),1,s));
G=double(reshape(I(:,:,2),1,s));
B=double(reshape(I(:,:,3),1,s));
 
R(RANDperm(1:(s*scale_down))) = NaN; 
G(RANDperm(1:(s*scale_down))) = NaN; 
B(RANDperm(1:(s*scale_down))) = NaN; 
R(isnan(R))=[];% deleting the NaN entries
G(isnan(G))=[];% deleting the NaN entries
B(isnan(B))=[];% deleting the NaN entries
 
% This linearly assigns color from colormap into data but does not have RGB significance
figure;imshow(I);
figure;scatter3(R,G,B,30,[R' G' B']./255,'filled','Marker','o','MarkerEdgeColor','k','MarkerFaceColor','k');
xlabel('RED');ylabel('GREEN');zlabel('BLUE');
title('RGB values corresponding to real values');