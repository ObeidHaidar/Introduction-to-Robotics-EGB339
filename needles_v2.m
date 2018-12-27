clc;close all;clearvars;
%% 1
im = iread('needle.png');
im_yuv = rgb2xyz(im);
figure
idisp(im_yuv(:,:,3)>0.6)
disp('1-  Check Figure 1');
%% 2
[centers, radii, metric] = imfindcircles(im,[20 60]);
figure
idisp(im);
viscircles(centers, radii, 'EdgeColor', 'r');
hold on
plot(centers(:,1),centers(:,2),'r*')
hold off
disp('2-  Check Figure 2');
%% 3
fprintf('3-  The number of needles is %d.',length(metric));