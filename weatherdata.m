%������ʵ�ֵĹ��ܣ�
%��1����weather_data_reprogress�ļ����µ����ݽ��д���
%��ȡ�ĸ������������weather_info�ļ�����
file=dir('./weather_data_reprogress/');
numfile=length(file);
path3='./weather_information.dat';
for k=3:numfile
    %��1����ȡ�ļ�
    %��2�����ļ����ݸ�ʽ��
 filename=file(k).name;
 path=strcat(['./weather_data_reprogress/'],filename);
 path2=strcat(['./weather_info/'],filename);
  fid1=fopen(path);
  fid2=fopen(path2,'w'); 
  %(3)��ȡ�ĸ����õ�����
  %(4)����ȡ4������������ݴ洢��./weather_info�ļ����£���ԭ�����ļ�����new����
[a1,a2,a3,a4]=textread(path,'%*d%f%f%*s%d%d%*s','headerlines',3);
A=[a1,a2,a3,a4];
B=A(:)';
dlmwrite(path2,A);
%(5)ÿ���켣��������Ϊһ�����������������е�ÿһ��Ԫ����Ϊһ������
%ȡ�����ݴ洢��./weather_info/weather_info.dat��
dlmwrite(path3, B,'-append');
fclose(fid1);
fclose(fid2);
end
