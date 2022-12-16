clear;clc
data=readtable('day2ostre.txt');
comms=data{:,1};
values=data{:,2};

% part1
hor=0;
dep=0;

for i=1:numel(comms)
    comm=char(comms(i));
    value=values(i);
    if strcmp('forward',comm)
        hor=hor+value;
    else
        if strcmp('up',comm)
            value=-value;
        end
        dep=dep+value;
    end
end
result=hor*dep;

disp("Part 1: "+result)

% part2
hor=0;
dep=0;
aim=0;

for i=1:numel(comms)
    comm=char(comms(i));
    value=values(i);
    if strcmp('forward',comm)
        hor=hor+value;
        dep=dep+aim*value;
    else
        if strcmp('up',comm)
            value=-value;
        end
        aim=aim+value;
    end
end
result=hor*dep;

disp("Part 2: "+result)