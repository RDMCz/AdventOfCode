clear;clc
fileID=fopen('day1ostre.txt','r');
formatSpec="%u";
A=fscanf(fileID,formatSpec);
fclose(fileID);

% part1
prev=A(1);
result=0;

for i=2:numel(A)
    if A(i)>prev
        result=result+1;
    end
    prev=A(i);
end

disp("Part 1: "+result)

% part2
prev=sum(A(1:3));
result=0;

for i=2:numel(A)-2
    if sum(A(i:i+2))>prev
        result=result+1;
    end
    prev=sum(A(i:i+2));
end

disp("Part 2: "+result)