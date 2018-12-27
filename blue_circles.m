clc;close all; clearvars;
im = iread('im13.jpg');
gamma=0.8;
% im = iread('3_shapes.png');
im = imresize(im, [300 NaN]);
imr = double(im(:,:,1))./255.0;
img = double(im(:,:,2))./255.0;
imb = double(im(:,:,3))./255.0;
imr=imr.^gamma;
img=img.^gamma;
imb=imb.^gamma;
imR = (imr./(img+imb+imr));
imG = (img./(img+imb+imr));
imB = (imb./(img+imb+imr));
imR = imR < 0.3;
imG = imG < 0.3;
imB = imB < 0.3;
imBlue = (imG.*imR);
% imBlue = iopen(imBlue,ones(4,4));
% imBlue = iclose(imBlue,ones(10,10));
% imBlue = imBlue>0.8;
imGreen = (imB.*imR);
% imGreen = iopen(imGreen,ones(4,4));
% imGreen = iclose(imGreen,ones(10,10));
% imGreen = imGreen>0.8;
imRed = (imB.*imG);
% imRed = iopen(imRed,ones(4,4));
% imRed = iclose(imRed,ones(10,10));
% imRed = imRed>0.8;
% % % % figure
% % % % idisp(im);
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
figure
idisp(imBlue);
figure
idisp(imRed);
figure
idisp(imGreen);

% % % % % figure 
% % imGreen = iopen(imGreen,ones(4,4));
% % imGreen = iclose(imGreen,ones(10,10));
% % idisp(imGreen);
% % b = iblobs(imGreen,'area',[ 1000 1000000],'boundary')
bg=iblobs(imGreen,'boundary');
bg(bg.area == max(bg.area))=[];
bg(bg.area < 1000)=[];
% % bg(bg.aspect < 0.8)=[];
% % bg(bg.circularity < 0.3)=[]
% % % % % % % idisp(imGreen);
% % % % % % % bg.plot();
% % % % % % % bg.plot_box();
% 
% % % % % % figure 
% % imRed = iopen(imRed,ones(4,4));
% % imRed = iclose(imRed,ones(10,10));
% idisp(imRed);
% % b = iblobs(imGreen,'area',[ 1000 1000000],'boundary')
br=iblobs(imRed,'boundary');
br(br.area == max(br.area))=[];
br(br.area < 1000)=[];
% % br(br.aspect < 0.8)=[];
% % br(br.circularity < 0.3)=[]
% % % % % % idisp(imRed);
% % % % % % br.plot();
% % % % % % br.plot_box();
% 
% % % % % figure 
% % imBlue = iopen(imBlue,ones(3,3));
% % imBlue = iclose(imBlue,ones(100,100));
% % imBlue = iopen(imBlue,ones(4,4));
% % imBlue = iclose(imBlue,ones(10,10));
% idisp(imBlue);
% % b = iblobs(imGreen,'area',[ 1000 1000000],'boundary')
bb=iblobs(imBlue,'boundary');
bb(bb.area == max(bb.area))=[];
bb(bb.area < 1000)=[];
% % bb(bb.aspect < 0.8)=[];
% % bb(bb.circularity < 0.3)=[]
% % % % % % % % idisp(imBlue);
% % % % % % % % bb.plot();
% % % % % % % % bb.plot_box();

%color code, red=1; green=2;blue=3
%shape code, circle=1; square=2, triangle=3
%size code, big=2; small=1
%each object will be defined by an array [clolor, shape, size]
% for example a large blue circle will be [3,1,2]

objects_part1=[];
ball=[br bg bb];
i=0;
while length(ball)> 3
    br((br.aspect.*br.area) == min(ball.aspect.*ball.area))=[];
    bb((bb.aspect.*bb.area) == min(ball.aspect.*ball.area))=[];
    bg((bg.aspect.*bg.area) == min(ball.aspect.*ball.area))=[];
    ball((ball.aspect.*ball.area) == min(ball.aspect.*ball.area))=[];
    i=i+1;
    if i>100
        ball=[];
        disp('Error,while loop stuck')
    end
end
% make sure there is only 3 shape
if length(ball)==3
    length_reference=0.5*(max(ball.umax-ball.umin)+min(ball.umax-ball.umin)); % or sum(ball.umax-ball.umin)/3
    if max(ball.umax-ball.umin)/min(ball.umax-ball.umin)<1.17
        if max(ball.umax-ball.umin)>(max(ball.uc)-min(ball.uc))/exp(1)
            length_reference = 0;
        else
            length_reference=10e15;
        end
        disp('all shapes have the same size');
    end
    if isempty(bb)==0
        for i =1:length(bb)
            if bb(i).circularity>0.95
                if (bb(i).umax-bb(i).umin)>length_reference
                    objects_part1(end+1,:)=[3 1 2];
                    disp('big blue circle')
                else objects_part1(end+1,:)=[3 1 1];
                    disp('small blue circle')
                end
            else if bb(i).circularity>0.75
                    if (bb(i).umax-bb(i).umin)>length_reference
                        objects_part1(end+1,:)=[3 2 2];
                        disp('big blue square')
                    else objects_part1(end+1,:)=[3 2 1];
                        disp('samll blue square')
                    end
                else if (bb(i).umax-bb(i).umin)>length_reference
                        objects_part1(end+1,:)=[3 3 2];
                        disp('big blue triangle')
                    else objects_part1(end+1,:)=[3 3 1];
                        disp('small blue triangle')
                    end
                end
            end
        end
    end
    if isempty(bg)==0
        for i =1:length(bg)
            if bg(i).circularity>0.95
                if (bg(i).umax-bg(i).umin)>length_reference
                    objects_part1(end+1,:)=[2 1 2];
                    disp('big green circle')
                else objects_part1(end+1,:)=[2 1 1];
                    disp('small green circle')
                end
            else if bg(i).circularity>0.75
                    if (bg(i).umax-bg(i).umin)>length_reference
                        objects_part1(end+1,:)=[2 2 2];
                        disp('big green square')
                    else objects_part1(end+1,:)=[2 2 1];
                        disp('small green square')
                    end
                else if (bg(i).umax-bg(i).umin)>length_reference
                        objects_part1(end+1,:)=[2 3 2];
                        disp('big green triangle')
                    else
                        objects_part1(end+1,:)=[2 3 1];
                        disp('small green triangle')
                    end
                end
            end
        end
    end
    if isempty(br)==0
        for i =1:length(br)
            if br(i).circularity>0.95
                if (br(i).umax-br(i).umin)>length_reference
                    objects_part1(end+1,:)=[1 1 2];
                    disp('big red circle')
                else objects_part1(end+1,:)=[1 1 1];
                    disp('small red circle')
                end
            else if br(i).circularity>0.75
                    if (br(i).umax-br(i).umin)>length_reference
                        objects_part1(end+1,:)=[1 2 2];
                        disp('big red square')
                    else objects_part1(end+1,:)=[1 2 1];
                        disp('small red square')
                    end
                else if (br(i).umax-br(i).umin)>length_reference
                        objects_part1(end+1,:)=[1 3 2];
                        disp('big red triangle')
                    else objects_part1(end+1,:)=[1 3 1];
                        disp('small red triangle')
                    end
                end
            end
        end
    end
end
%% 2
im = iread('im1.jpeg');
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
imBlue = (imG.*imR);
imGreen = (imB.*imR);
imRed = (imB.*imG);
% figure
% idisp(im);
% figure
% idisp(imBlue);
% figure
% idisp(imRed);
% figure
% idisp(imGreen);

figure
bb=iblobs(imBlue,'boundary');
bb(bb.area == max(bb.area))=[];
while length(bb)~= 9
    bb((bb.circularity./bb.area) == max(bb.circularity./bb.area))=[];
end
idisp(imBlue)
bb.plot
bb.plot_box('g')
%% 3
figure
br=iblobs(imRed,'boundary');
br(br.area == max(br.area))=[];
bg=iblobs(imGreen,'boundary');
bg(bg.area == max(bg.area))=[];
br(br.uc > max(bb.uc))=[];
br(br.uc < min(bb.uc))=[];
bg(bg.uc > max(bb.uc))=[];
bg(bg.uc < min(bb.uc))=[];
idisp(imBlue+imRed+imGreen)
ball=[br bg bb];
length_reference=0.4*(max(ball.area)+min(ball.area));
bt=[br(br.circularity>0.4 & br.circularity<0.75) bg(bg.circularity>0.4 & bg.circularity<0.75) bb(bb.circularity>0.4 & bb.circularity<0.75)];
ball.plot
bg.plot_box('g')
bt.plot_box('r--')
%% 4
object=objects_part1;
rc =br(br.circularity>0.95);
brc=rc(rc.area>length_reference);
src=rc(rc.area<length_reference);
rs =br(br.circularity>0.75 & br.circularity<0.95);
brs=rs(rs.area>length_reference);
srs=rs(rs.area<length_reference);
rt =br(br.circularity>0.4 & br.circularity<0.75);
brt=rt(rt.area>length_reference);
srt=rt(rt.area<length_reference);
gc =bg(bg.circularity>0.95);
bgc=gc(gc.area>length_reference);
sgc=gc(gc.area<length_reference);
gs =bg(bg.circularity>0.75 & bg.circularity<0.95);
bgs=gs(gs.area>length_reference);
sgs=gs(gs.area<length_reference);
gt =bg(bg.circularity>0.4 & bg.circularity<0.75);
bgt=gt(gt.area>length_reference);
sgt=gt(gt.area<length_reference);
bc =bb(bb.circularity>0.95);
bbc=bc(bc.area>length_reference);
sbc=bc(bc.area<length_reference);
bs =bb(bb.circularity>0.75 & bb.circularity<0.95);
bbs=bs(bs.area>length_reference);
sbs=bs(bs.area<length_reference);
bt =bb(bb.circularity>0.4 & bb.circularity<0.75);
bbt=bt(bt.area>length_reference);
sbt=bt(bt.area<length_reference);
similar_blob=bb(1);
for i=1:3
    if object(i,1)==1
        %red
        if object(i,2)==1
            %circle
            if object(i,3)==1
                %small
                similar_blob(end+1)=src;
            end
            if object(i,3)==2
                %big
                similar_blob(end+1)=brc;
            end
        end
        if object(i,2)==2
            %square
            if object(i,3)==1
                %small
                similar_blob(end+1)=srs;
            end
            if object(i,3)==2
                %big
                similar_blob(end+1)=brs;
            end
        end
        if object(i,2)==3
            %triangle
            if object(i,3)==1
                %small
                similar_blob(end+1)=srt;
            end
            if object(i,3)==2
                %big
                similar_blob(end+1)=brt;
            end
        end
    end
    if object(i,1)==2
        %green
        if object(i,2)==1
            %circle
            if object(i,3)==1
                %small
                similar_blob(end+1)=sgc;
            end
            if object(i,3)==2
                %big
                similar_blob(end+1)=bgc;
            end
        end
        if object(i,2)==2
            %square
            if object(i,3)==1
                %small
                similar_blob(end+1)=sgs;
            end
            if object(i,3)==2
                %big
                similar_blob(end+1)=bgs;
            end
        end
        if object(i,2)==3
            %triangle
            if object(i,3)==1
                %small
                similar_blob(end+1)=sgt;
            end
            if object(i,3)==2
                %big
                similar_blob(end+1)=bgt;
            end
        end
        if object(i,1)==3
            %blue
            if object(i,2)==1
                %circle
                if object(i,3)==1
                    %small
                    similar_blob(end+1)=sbc;
                end
                if object(i,3)==2
                    %big
                    similar_blob(end+1)=bbc;
                end
            end
            if object(i,2)==2
                %square
                if object(i,3)==1
                    %small
                    similar_blob(end+1)=sbs;
                end
                if object(i,3)==2
                    %big
                    similar_blob(end+1)=bbs;
                end
            end
            if object(i,2)==3
                %triangle
                if object(i,3)==1
                    %small
                    similar_blob(end+1)=sbt;
                end
                if object(i,3)==2
                    %big
                    similar_blob(end+1)=bbt;
                end
            end
        end
    end
end
figure 
idisp(im)
similar_blob(2:end).plot
similar_blob(2:end).plot_box
%% 5
Q = [380,380;200,380;20,380;380,200;200,200;20,200;380,20;200,20;20,20]';
Pb = bb.p;
H=homography(Pb,Q);
q=homtrans(H,similar_blob(2:end).p)

% bigest circle is always at the bottom center(200,20) and it is bb(bb.area== max(bb.area))
% top left is bb(bb.uc .* bb.vc == min(bb.uc .* bb.vc))
% bottom right is bb(bb.uc .* bb.vc == max(bb.uc .* bb.vc))
% top right is bb(bb.uc ./ bb.vc == max(bb.uc ./ bb.vc))
%bottom right is bb(bb.uc ./ bb.vc == min(bb.uc ./ bb.vc))
















