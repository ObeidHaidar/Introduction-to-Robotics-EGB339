clc;close all; clearvars;
%% 1
im = iread('needle.png');
imb = im(:,:,3);
imB = imb>200;
imB=1-imB;
imB = iopen(imB,ones(6,6));
figure
idisp(1-imB);
disp('1-  Check Figure 1');
%% 2
figure
br=iblobs(imB);
br(br.area == max(br.area))=[];
br(br.class == 0)=[];
br(br.aspect < 0.7)=[];
br.plot();
br.plot_box();
idisp(im)
idisp(1-imB);
hold on
br.plot()
hold off
disp('2-  Check Figure 2');
%% 3
fprintf('3-  The number of needles is %d.',length(br));