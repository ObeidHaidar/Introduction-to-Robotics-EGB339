clc;close all; clear all;
im = iread('needles_practice.png');
% imr = im(:,:,1);
% img = im(:,:,2);
imb = im(:,:,3);
% imR = 1-(imr./(img+imb+imr));
% imG = 1-(img./(img+imb+imr));
% imB = 1-(imb./(img+imb+imr));
% imBlue = imR-imB; 
% imGreen = imR-imG;
% imRed = imG-imR;
% figure
% idisp(im);
% figure 
% idisp(imr);
% figure
% idisp(img);
% figure
% idisp(imb);
% figure 
% idisp(imR);
% figure
% idisp(imG);
% figure
% idisp(imB);
% figure
% idisp(imBlue);
% figure
% idisp(imRed);
% figure
% idisp(imGreen);
imB = imb>200;
figure
imB=1-imB;
imB = iopen(imB,ones(6,6));
% imB = iclose(imB,ones(3,3));
idisp(imB);
% b = iblobs(imGreen,'area',[ 1000 1000000],'boundary')
br=iblobs(imB);
br(br.area == max(br.area))=[];
br(br.class == 0)=[];
br(br.aspect < 0.7)=[];
br.plot();
br.plot_box();
figure
idisp(im)
hold on
br.plot()
hold off
X = sprintf('the number of needles is %d.',length(br));
disp(X)