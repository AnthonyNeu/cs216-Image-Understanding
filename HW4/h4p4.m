clc;
close;
clear;

testImageName = 'figure/peopleTest.jpg';
%% use k-mixture model,read k model from train examples
numMix = 2;
numPos = 5;
Itrain0 = im2double(imread('figure/mix1/mix0.jpg'));
[H,W] = size(Itrain0);
template = cell(numMix,1);
template{1} = zeros(H/8,W/8,9);
for i = 1: numPos
    imname = strcat('figure/mix1/mix',num2str(i-1),'.jpg');
    Itrain = im2double(imread(imname));
    template{1} = template{1} + hog(Itrain);
%     figure;
%     V2 = hogdraw(template(:,:,:,i));
%     imshow(V2);
end
Itrain0 = im2double(imread('figure/mix2/mix0.jpg'));
[H,W] = size(Itrain0);
template{2} = zeros(H/8,W/8,9);
for i = 1: numPos
    imname = strcat('figure/mix2/mix',num2str(i-1),'.jpg');
    Itrain = im2double(imread(imname));
    template{2} = template{2} + hog(Itrain);
%     figure;
%     V2 = hogdraw(template(:,:,:,i));
%     imshow(V2);
end
template{1} = template{1}/numPos;
template{2} = template{2}/numPos;

%% test the tempalte
%
% load a test image
%
Itest= im2double(rgb2gray(imread(testImageName)));


% find top 5 detections in Itest
ndet = 5;
[x,y,score] = mix_detect(Itest,template,ndet);

%display top ndet detections
figure(3); clf; imshow(Itest);
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',[x(i)-W/2 y(i)-H/2 W H],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end