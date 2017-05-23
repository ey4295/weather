filename='rainfallfile.txt';
rows=7;
cols=5;
%open  the file  


%(1)��fopen�����򿪵��ļ�������ļ���ʶ����
%(2)�����ļ��е����ݸ�ʽ˵��������'��s'Ϊһ���ַ�����
%    '��d'Ϊһ���������򡰣�f'��ʾһ����������

%(3)Ҫ���������ַ����ļ����������ǵĸ�ʽ������
%   Ҫ����һ�������ֶΣ��ڷ�ʹ��һ���Ǻţ���*������

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