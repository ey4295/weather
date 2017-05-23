%函数功能：
%输入参数：L,sigma,T
% L为输入轨迹集合
% sigma为核宽度
% T为约束参数

%%对轨迹数据进行%MAX-MIN标准化

file=dir('./weather_info/');
numfile=length(file);
traj=[];
for k=3:numfile
    filename=file(k).name;
    path1=strcat(['./weather_info/'],filename);
    [a1,a2,a3,a4]=textread(path1,'%f%f%d%d','delimiter',',');
    D=[a1,a2,a3,a4];
    for i=1:size(D,1)
        D(i,1)=((D(i,1)-7.2))./(70.7-7.2);
        D(i,2)=(D(i,2)-(-107.7))./(13.5-(-107.7));
        D(i,3)=(D(i,3)-10)./(155-10);
        D(i,4)=(D(i,4)-0)./(1024-0);
    end
    E=D(:)';
    traj=[traj;E];
    
end
function out_set=FGAK(L,sigma,T)
for m=1:size(L,1);
    for n=1:size(L,1)
        K(m,n)=FGAK(L(m,:),L(n,:));
    end
end




end
