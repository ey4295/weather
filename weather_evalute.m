file=dir('./weather_info/');
numfile=length(file);   
row=0;
for k=3:numfile
    %（1）读取文件
 filename=file(k).name;
 path=strcat(['./weather_info/'],filename);
 fid=fopen(path); % 打开文件
    while ~feof(fid) % 是否读取到文件结尾
        [~]=fgetl(fid); % 或者fgetl
        row=row+1; % 行数累加
    end
    fclose(fid); % 及时关闭文件是个好习惯
end
row
avelength=round(row./(numfile-3))