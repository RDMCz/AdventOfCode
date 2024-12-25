clear;clc
file = 'day13ostre.txt';
A = textscan(fopen(file,'r'), '%s','delimiter',',', 'CollectOutput', 1);
A = string(A{:});
Dots = str2double(A)+1;
Rules = A(isnan(Dots));
Dots(isnan(Dots(:,1)),:) = [];
Dots = reshape(Dots.',2,[]).';

% part2
X=Dots(:,1);
Y=Dots(:,2);

Paper=zeros(895,311);
for i=1:numel(X)
    Paper(Y(i),X(i))=1;
end

for i=1:numel(Rules)
    rule=strsplit(Rules(i),' ');
    rule=strsplit(rule(3),'=');
    axis=rule(1);
    value=str2double(rule(2))+1;    
    if axis=="x"        
        PaperL=Paper(:,1:value-1);
        PaperR=Paper(:,value+1:end);
        Paper=PaperL+fliplr(PaperR);
    end    
    if axis=="y"        
        PaperU=Paper(1:value-1,:);
        PaperD=Paper(value+1:end,:);
        Paper=PaperU+flipud(PaperD);
    end
    if i==1
        % part1
        for j=1:numel(Paper)
            if Paper(j)>0
                Paper(j)=1;
            end
        end
        result=sum(Paper, 'all');
        disp("Part 1: "+result)
    end
end

for i=1:numel(Paper)
    if Paper(i)>0
        Paper(i)=1;
    end
end

disp("Part 2:")
imagesc(Paper)