clc;close all; clear all;
im = iread('needles_practice.png','grey');
figure
idisp(im);whit
imm=im>163;
figure
idisp(imm);
whit = imm(260:328,520:588)==1;
%1904
k=sum(imm);
j=sum(k);
round((j/1904))

