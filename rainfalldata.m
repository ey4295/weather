filename='rainfallfile.txt';
rows=7;
cols=5;
%open  the file  


%(1)用fopen函数打开的文件并获得文件标识符。
%(2)描述文件中的数据格式说明符，如'％s'为一个字符串，
%    '％d'为一个整数，或“％f'表示一个浮点数。

%(3)要跳过文字字符的文件，包括他们的格式描述。
%   要跳过一个数据字段，在符使用一个星号（“*”）。

fid=fopen(filename);
M=fscanf(fid,'%*s %*s %*s %*s %*s %*s M=%d',1)
%read each set of measurements
for n=1:M
    mydata(n).time=fscanf(fid,'%s',1);
    mydata(n).month=fscanf(fid,'%s',1);
    % fscanf fills the array in column order,
    % so transpose the results
    mydata(n).raindata=...
        fscanf(fid,'%f',[rows,cols]);
    
end
for n = 1:M
    disp(mydata(n).time), disp(mydata(n).month)
    disp(mydata(n).raindata)
end
%close the file 
fclose(fid);