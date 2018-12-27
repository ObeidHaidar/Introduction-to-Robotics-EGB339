% % Part 1, 1
clc;close all; clear all;
im = iread('im4.jpeg');
im = imresize(im, [300 NaN]);
imr = double(im(:,:,1))./255.0;
img = double(im(:,:,2))./255.0;
imb = double(im(:,:,3))./255.0;
imR = (imr./(img+imb+imr));
imG = (img./(img+imb+imr));
imB = (imb./(img+imb+imr));
imR = imR < 0.3;
imG = imG < 0.3;
imB = imB < 0.3;
imBlue = imR.*imG;
% imBlue = iopen(imBlue,ones(3,3));
% imBlue = iclose(imBlue,ones(5,5));
imGreen = imR.*imB;
% imGreen = iopen(imGreen,ones(3,3));
% imGreen = iclose(imGreen,ones(5,5));
imRed = imG.*imB;
% imRed = iopen(imRed,ones(3,3));
% imRed = iclose(imRed,ones(5,5));


figure
idisp(im);
figure
idisp(imBlue);
figure
idisp(imRed);
figure
idisp(imGreen);

bg=iblobs(imGreen,'boundary')
bg.plot();
bg.plot_box();

br=iblobs(imRed,'boundary')
br.plot();
br.plot_box();

bb=iblobs(imBlue,'boundary')
bb.plot();
bb.plot_box();

% % Part 1, 2

% % Part 1, 3

% % Part 1, 4

% % Part 1, 5




