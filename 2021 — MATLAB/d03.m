clear;clc
fileID=fopen('day3ostre.txt','r');
A=fscanf(fileID,"%lu");
fclose(fileID);

% part1
rows=numel(A);
for i=1:rows
    DEC(i)=bin2dec(string(A(i)));
end

BIN=de2bi(DEC);
threshold=numel(A)/2;
SUM=sum(BIN);
cols=numel(SUM);

for i=1:cols
    if SUM(i)>threshold
        SIG(i)=1;
        INV(i)=0;
    else
        SIG(i)=0;
        INV(i)=1;
    end
end

sig=bi2de(SIG);
inv=bi2de(INV);
result=sig*inv;

disp("Part 1: "+result)

% part2
Bgen=[BIN BIN(:,1)*0];
Bscru=[BIN BIN(:,1)*0];

for i=cols:-1:1
    threshold=(numel(A)+sum(Bgen(:,cols+1)))/2;
    thresholdscru=(numel(A)+sum(Bscru(:,cols+1)))/2;
    tempsum=0;
    tempsumscru=0;
    for j=1:rows
        if Bgen(j,cols+1)~=-1
            tempsum=tempsum+Bgen(j,i);
        end
        if Bscru(j,cols+1)~=-1
            tempsumscru=tempsumscru+Bscru(j,i);
        end
    end
    if tempsum>=threshold
        keep=1;
    else
        keep=0;
    end    
    if tempsumscru>=thresholdscru
        keepscru=0;
    else
        keepscru=1;
    end
    for j=1:rows
        if Bgen(j,i)~=keep
            Bgen(j,cols+1)=-1;
        end
        if Bscru(j,i)~=keepscru
            Bscru(j,cols+1)=-1;
        end
    end
    if rows+sum(Bgen(:,cols+1))==1
        for j=1:rows
            if Bgen(j,cols+1)~=-1
                generator=Bgen(j,1:cols);
            end
        end
    end
    if rows+sum(Bscru(:,cols+1))==1
        for j=1:rows
            if Bscru(j,cols+1)~=-1
                scrubber=Bscru(j,1:cols);
            end
        end
    end
end

result=bi2de(generator)*bi2de(scrubber);
disp("Part 2: "+result)