file=dir('./weather_info/');
numfile=length(file);   
row=0;
for k=3:numfile
    %��1����ȡ�ļ�
 filename=file(k).name;
 path=strcat(['./weather_info/'],filename);
 fid=fopen(path); % ���ļ�
    while ~feof(fid) % �Ƿ��ȡ���ļ���β
        [~]=fgetl(fid); % ����fgetl
        row=row+1; % �����ۼ�
    end
    fclose(fid); % ��ʱ�ر��ļ��Ǹ���ϰ��
end
row
avelength=round(row./(numfile-3))