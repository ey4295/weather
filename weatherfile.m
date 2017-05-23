%������ʵ�ֵ��������ܣ�
%��1�����ļ����ݸ�ʽ�����Ա��Ժ���Զ��������н��д���
%��2���ܹ�ÿ���켣��MATLAB�л滭��������ֱ�۵���ʾ
file=dir('./weather_data');
numfile=length(file);
for k=3:numfile
    %��1����ȡ�ļ�
    %��2�����ļ����ݸ�ʽ��
    filename=file(k).name;
    path1=strcat(['./weather_data/'],filename);
    fid1=fopen(path1);
    path2=strcat(['./weather_data_reprogress/',['new'],filename]);
    fid2=fopen(path2,'w');
    while ~feof(fid1)
        %��3��������ݵĸ�ʽ��������ʽ��������ݴ洢��./weather_data_reprogress�ļ�����
        tline=fgetl(fid1);
        tline=strrep(tline,'TROPICAL STORM','TROPICALSTORM');
        tline=strrep(tline,'TROPICAL DEPRESSION','TROPICALDEPRESSION');
        tline=strrep(tline,'EXTRATROPICAL DEPRESSION','EXTRATROPICALDEPRESSION');
        tline=strrep(tline,'SUBTROPICAL STORM','SUBTROPICALSTORM');
        tline=strrep(tline,'TROPICAL WAVE','TROPICALWAVE');
        tline=regexprep(tline,'-(?!\d)','0');
        fprintf(fid2,'%s\n',tline);
    end
    %(1)��ͼʹ�����ݵ�ǰ���������������Ⱥ�γ�ȣ��洢��a1,a2��
    [a1,a2]=textread(path2,'%*d%f%f%*s%*d%*s%*s','headerlines',3);
    %(2)���������켣ͼ
    x=a2;
    y=a1;
    if k<numfile
        plot(x,y);
        hold on;
    else
        plot(x,y);
        xlabel('Lontitude-����'),ylabel('Lantitude-γ��');
    end
    fclose(fid1);
    fclose(fid2);
    
end



