function [theta1, theta2, theta3, theta4 ] = move( claw, x,y,z,grippers)
r=30.309 ; hh=53 ; l2=170.384 ; l3=136.307; l4=86; c=40;
z=z+c+l4; x = x-105; y = y-290; d=sqrt(x^2 + y^2)-r; h=z-hh;
g=sqrt(d^2 + h^2);
theta3=acosd((l3^2+l2^2-g^2)/(2*l3*l2)); % ELBOW
theta21=asind(l3*sind(theta3)/g);
theta22=asind(h/g);
theta2=theta21+theta22;
theta4=270-(theta2+theta3); %WRIST
theta2=theta2*(1+(52/28)); % SHOULDER
theta1 = atan2d(-y,x)-120;
joint_angles =  [theta1 theta2 theta3 theta4 grippers];
claw.setAllJointsPosition(joint_angles)
% current_angles = claw.getAllJointsPosition();
% disp(current_angles)
end


