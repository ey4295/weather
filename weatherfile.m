%本程序实现的两个功能：
%（1）将文件数据格式化，以便以后可以读入数组中进行处理
%（2）架构每个轨迹在MATLAB中绘画出来，以直观的显示
file=dir('./weather_data');
numfile=length(file);
for k=3:numfile
    %（1）读取文件
    %（2）对文件数据格式化
    filename=file(k).name;
    path1=strcat(['./weather_data/'],filename);
    fid1=fopen(path1);
    path2=strcat(['./weather_data_reprogress/',['new'],filename]);
    fid2=fopen(path2,'w');
    while ~feof(fid1)
        %（3）完成数据的格式化，将格式化后的数据存储在./weather_data_reprogress文件夹下
        tline=fgetl(fid1);
        tline=strrep(tline,'TROPICAL STORM','TROPICALSTORM');
        tline=strrep(tline,'TROPICAL DEPRESSION','TROPICALDEPRESSION');
        tline=strrep(tline,'EXTRATROPICAL DEPRESSION','EXTRATROPICALDEPRESSION');
        tline=strrep(tline,'SUBTROPICAL STORM','SUBTROPICALSTORM');
        tline=strrep(tline,'TROPICAL WAVE','TROPICALWAVE');
        tline=regexprep(tline,'-(?!\d)','0');
        fprintf(fid2,'%s\n',tline);
    end
    %(1)画图使用数据的前两个特征，即经度和纬度，存储在a1,a2中
    [a1,a2]=textread(path2,'%*d%f%f%*s%*d%*s%*s','headerlines',3);
    %(2)画出各个轨迹图
    x=a2;
    y=a1;
    if k<numfile
        plot(x,y);
        hold on;
    else
        plot(x,y);
        xlabel('Lontitude-经度'),ylabel('Lantitude-纬度');
    end
    fclose(fid1);
    fclose(fid2);
    
end



