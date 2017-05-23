%create a matrix y,with two rows 
x=0:10:100;
y=[x;   log(x)];
%open a file for writing,用fopen打开的文件只有读权限，因此要追加权限
fid=fopen('logtable.txt','w');
%Table Header 
fprintf(fid,'Log        Function \n');
%print values in colum order
%two values appear on each row of the file
fprintf(fid,'%f   %f \n',y);
fclose(fid);
%display the file created
type logtable.txt
