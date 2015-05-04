clc;
close;
clear;

%% magnitude of impluse function
% impulse = zeros(100,1);
% impulse(50) = 1;
% res = fft(impulse);
% figure;
% plot(abs(res));
% xlabel('index');
% ylabel('magnitude of the spectrum');
% title('magnitude of the spectrum of impluse function');

%% magnitude of box function with length = 5 or 10
% box = zeros(100,1);
% box(45:54) = ones(10,1);
% res = fftshift(fft(box));
% figure;
% plot(abs(res));
% xlabel('index');
% ylabel('magnitude of the spectrum');
% title('magnitude of the spectrum of box function');

%% magnitude of Gaussian function
% sigma = 2;
% X = [-50:1:50];
% gauss = 1/(sqrt(2*pi)*sigma) * exp(- X.^2/(2*sigma^2));
% res = fftshift(fft(gauss));
% figure;
% plot(abs(res));
% xlabel('index');
% ylabel('magnitude of the spectrum');
% title('magnitude of the spectrum of Gaussian function');

%% Modify the two images and get the input image
image1 = im2double(rgb2gray(imread('figure/zebra1.jpg')));
image2 = im2double(rgb2gray(imread('figure/simpsons.jpg')));
[m,n,d] = size(image2);
image1 = imresize(image1,[m n]);
imwrite(image1,'figure/zebra1_input.jpg','JPEG');
imwrite(image2,'figure/simpsons_input.jpg','JPEG');

%% Calculate 2D-FFT of image1 and image2
image1FFT = fft2(image1);
image1Magnitude = abs(image1FFT);
image1Phase = angle(image1FFT);

image2FFT = fft2(image2);
image2Magnitude = abs(image2FFT);
image2Phase = angle(image2FFT);

%% combine magnitude from image1 and phase from image2
newImage1FFT = image1Magnitude .* exp(image2Phase .*1i);
newImage1 = ifft2(newImage1FFT);
imwrite(newImage1,'figure/zebra1_simpsons1.jpg','JPEG');

%% combine magnitude from image2 and phase from image1
newImage2FFT = image2Magnitude .* exp(image1Phase .*1i);
newImage2 = ifft2(newImage2FFT);
imwrite(newImage2,'figure/zebra1_simpsons2.jpg','JPEG');

%% conduct DFT to sigmoid function
X = [-50:1:50];
sigmoid = 1./(1 + exp(-X));
res = fftshift(fft(sigmoid));
figure;
plot(abs(res));
xlabel('index');
ylabel('magnitude of the spectrum');
title('magnitude of the spectrum of Sigmoid function');
figure;
plot(sigmoid);
xlabel('index');
title('Sigmoid function');


