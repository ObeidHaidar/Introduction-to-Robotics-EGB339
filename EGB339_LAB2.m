clc;close all; clear all;
im = iread('vision_prac.jpg');
imr = im(:,:,1);
img = im(:,:,2);
imb = im(:,:,3);
imR = 1-(imr./(img+imb+imr));
imG = 1-(img./(img+imb+imr));
imB = 1-(imb./(img+imb+imr));
imB = imR - imB;
imBlue =(imb./(img-imb+imr));
imBlue = imBlue./((1-imG)+(1-imR)); 
imGreen = imR-imBlue;
imRed = imG-imBlue;
figure
idisp(im);
figure 
idisp(imR);
figure
idisp(imG);
figure
idisp(imB);
figure
idisp(imBlue);
figure
idisp(imRed);
figure 
idisp(imGreen);
b = iblobs(imGreen,'area',[ 1000 1000000],'boundary')