%���ļ�ancheng������������ܣ�
%��1����SMOTE�㷨���켣�ĳ�������Ϊ��켣��Ŀ����
%��2����MAX-MIN�����ݹ�һ������


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
    D=[A;C];  %�������������ԭʼ���ݴ����һ��������
    E=[E;D];  %���й켣���ݼ���
    %��һ�����ݣ���ʽΪX��i��=(X(i)-min({X(i)}))./(max({X(i)})-min({X(i)}))
    for i=1:size(D,1)
        D(i,1)=((D(i,1)-7.2))./(70.7-7.2);
        D(i,2)=(D(i,2)-(-107.7))./(13.5-(-107.7));
        D(i,3)=(D(i,3)-10)./(155-10);
        D(i,4)=(D(i,4)-0)./(1024-0);
    end
    dlmwrite(path3,D); %����һ����ͳһ���Ⱥ�����ݴ洢��weather_final�У�����֮���SVMѵ����
end
%���ÿ�����������ֵ����Сֵ�����ڹ�һ������������
[max_e]=max(E);
[min_e]=min(E);


