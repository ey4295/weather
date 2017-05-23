filename='weeklydata.txt';
delimiterIn=' ';
headlinesIn=1;
A=importdata(filename,delimiterIn,headlinesIn);
% View data
for k=[1:7]
    disp(A.colheaders{1,k})
   disp(A.data(:,k))
   disp(' ')
end
B=importdata('-pastespecial')