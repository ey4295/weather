%本文件ancheng完成了两个功能：
%（1）用SMOTE算法将轨迹的长度设置为最长轨迹数目个数
%（2）用MAX-MIN将数据归一化处理


file=dir('./weather_info/');
numfile=length(file);
path2='./weather_info/new2004IVAN.dat';
[b1,b2,b3,b4]=textread(path2,'%f%f%d%d','delimiter',',');
B=[b1,b2,b3,b4];
label2=ones(size(B,1),1);
E=[];
for k=3:numfile
    
    filename=file(k).name;
    path1=strcat(['./weather_info/'],filename);
    path3=strcat(['./weather_final/'],filename);
    [a1,a2,a3,a4]=textread(path1,'%f%f%d%d','delimiter',',');
    A=[a1,a2,a3,a4];
    label1=[];
    for n=1:size(A,1)
        label1=[label1;-1];
    end
    original_features=[A;B];
    original_mark=[label1;label2];
    [final_features,final_mark]=SMOTE(original_features, original_mark);
    C=final_features(size(original_features,1)+1:size(final_features,1),:);
    D=[A;C];  %将补充的数据与原始数据存放在一个数组中
    E=[E;D];  %所有轨迹数据集合
    %归一化数据，公式为X（i）=(X(i)-min({X(i)}))./(max({X(i)})-min({X(i)}))
    for i=1:size(D,1)
        D(i,1)=((D(i,1)-7.2))./(70.7-7.2);
        D(i,2)=(D(i,2)-(-107.7))./(13.5-(-107.7));
        D(i,3)=(D(i,3)-10)./(155-10);
        D(i,4)=(D(i,4)-0)./(1024-0);
    end
    dlmwrite(path3,D); %将归一化和统一长度后的数据存储在weather_final中，用于之后的SVM训练中
end
%求出每个特征的最大值和最小值，用于归一化处理数据中
[max_e]=max(E);
[min_e]=min(E);


