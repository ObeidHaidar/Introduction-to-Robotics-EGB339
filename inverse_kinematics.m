clc;clearvars;close all;
r=30.309;
hh=53;
l2=170.384;
l3=136.307;
l4=86;
c=40;
x= 100     ;%change
y= 100     ;%change 
z=50+c/2+l4;


d=sqrt(x^2 + y^2)-r;
h=z-hh;
g=sqrt(d^2 + h^2);
theta3=acos((l3^2+l2^2-g^2)/(2*l3*l2));
theta21=asin(l3*sin(theta3)/g);
theta22=asin(h/g);
theta2=theta21+theta22;
dtheta2=theta2*180/pi;
dtheta3=theta3*180/pi;
dtheta4=270-(dtheta2+dtheta3);
dgtheta2=dtheta2*10/3.5;