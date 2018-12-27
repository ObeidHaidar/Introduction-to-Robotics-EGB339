%color code, red=1; green=2;blue=3
%shape code, circle=1; square=2, triangle=3
%size code, big=2; small=1
%each object will be defined by an array [clolor, shape, size]
% for example a large blue circle will be [3,1,2]

objects_part1=[];
ball=[br bg bb];

% make sure there is only 3 shape
if length(ball)==3
    area_reference=0.5*(max(ball.area)+min(ball.area));
    if area_reference/min(ball.area)<1.7
        if max(ball.umax-ball.umin)>(max(ball.uc)-min(ball.uc))/exp(1)
            area_reference = 0;
        else area_reference=10e15
        end
    end
    if isempty(bb)==0
        for i =1:length(bb)
            if bb(i).circularity>0.95
                if bb(i).area>area_reference
                    objects_part1(end+1,:)=[3 1 2];
                    'big blue circle'
                else objects_part1(end+1,:)=[3 1 1];
                    'small blue circle'
                end
            else if bb(i).circularity>0.75
                    if bb(i).area>area_reference
                        objects_part1(end+1,:)=[3 2 2];
                        'big blue square'
                    else objects_part1(end+1,:)=[3 2 1];
                        'samll blue square'
                    end
                else if bb(i).area>area_reference
                        objects_part1(end+1,:)=[3 3 2];
                        'big blue triangle'
                     else objects_part1(end+1,:)=[3 3 1];
                         'small blue triangle'
                    end
                end
            end
        end
    end
    if isempty(bg)==0
        for i =1:length(bg)
            if bg(i).circularity>0.95
                if bg(i).area>area_reference
                    objects_part1(end+1,:)=[2 1 2];
                    'big green circle'
                else objects_part1(end+1,:)=[2 1 1];
                    'small green circle'
                end
            else if bg(i).circularity>0.75
                    if bg(i).area>area_reference
                        objects_part1(end+1,:)=[2 2 2];
                        'big green square'
                    else objects_part1(end+1,:)=[2 2 1];
                        'small green square'
                    end
                else if bg(i).area>area_reference
                        objects_part1(end+1,:)=[2 3 2];
                        'big green triangle'
                     else objects_part1(end+1,:)=[2 3 1];
                         'small green triangle'
                    end
                end
            end
        end
    end
    if isempty(br)==0
        for i =1:length(br)
            if br(i).circularity>0.95
                if br(i).area>area_reference
                    objects_part1(end+1,:)=[1 1 2];
                    'big red circle'
                else objects_part1(end+1,:)=[1 1 1];
                    'small red circle'
                end
            else if br(i).circularity>0.75
                    if br(i).area>area_reference
                        objects_part1(end+1,:)=[1 2 2];
                        'big red square'
                    else objects_part1(end+1,:)=[1 2 1];
                        'small red square'
                    end
                else if br(i).area>area_reference
                        objects_part1(end+1,:)=[1 3 2];
                        'big red triangle'
                     else objects_part1(end+1,:)=[1 3 1];
                         'small red triangle'
                    end
                end
            end
        end
    end    
end