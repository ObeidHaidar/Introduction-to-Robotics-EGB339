clc;close all;clear all;
im = [189,188,194,178,165,154;134,15,20,18,176,145;177,21,160,22,188,165;201,25,3,17,157,158;222,162,169,184,30,194;231,245,199,178,188,201];
mask1 = (im<=31);
mask2 = (im<=63).*(im>31);
mask3 = (im<=95).*(im>63);
mask4 = (im<=127).*(im>95);
mask5 = (im<=159).*(im>127);
mask6 = (im<=191).*(im>159);
mask7 = (im<=223).*(im>191);
mask8 = (im<=255).*(im>223);
bin1=sum(sum(mask1));
bin2=sum(sum(mask2));
bin3=sum(sum(mask3));
bin4=sum(sum(mask4));
bin5=sum(sum(mask5));
bin6=sum(sum(mask6));
bin7=sum(sum(mask7));
bin8=sum(sum(mask8));
thresh = im<96
(im(5,:)./255).^2