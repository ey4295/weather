%create a matrix y,with two rows 
x=0:10:100;
y=[x;   log(x)];
%open a file for writing,��fopen�򿪵��ļ�ֻ�ж�Ȩ�ޣ����Ҫ׷��Ȩ��
fid=fopen('logtable.txt','w');
%Table Header 
fprintf(fid,'Log        Function \n');
%print values in colum order
%two values appear on each row of the file
fprintf(fid,'%f   %f \n',y);
fclose(fid);
%display the file created
type logtable.txt
