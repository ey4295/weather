%本程序实现的功能：
%（1）将weather_data_reprogress文件夹下的数据进行处理
%提取四个特征，存放在weather_info文件夹下
file=dir('./weather_data_reprogress/');
numfile=length(file);
path3='./weather_information.dat';
for k=3:numfile
    %（1）读取文件
    %（2）对文件数据格式化
 filename=file(k).name;
 path=strcat(['./weather_data_reprogress/'],filename);
 path2=strcat(['./weather_info/'],filename);
  fid1=fopen(path);
  fid2=fopen(path2,'w'); 
  %(3)提取四个有用的特征
  %(4)将提取4个特征后的数据存储在./weather_info文件夹下，以原来的文件名加new命名
[a1,a2,a3,a4]=textread(path,'%*d%f%f%*s%d%d%*s','headerlines',3);
A=[a1,a2,a3,a4];
B=A(:)';
dlmwrite(path2,A);
%(5)每条轨迹的所有作为一个行向量，行向量中的每一个元素作为一个特征
%取出数据存储在./weather_info/weather_info.dat中
dlmwrite(path3, B,'-append');
fclose(fid1);
fclose(fid2);
end
