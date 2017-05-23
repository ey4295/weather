fid1=fopen('hurricanedata.txt');
%fid2=fopen('reprodata.txt','w');

while ~feof(fid1)
    tline=fgetl(fid1);
    tline=strrep(tline,'TROPICAL STORM','TROPICALSTORM');
     tline=strrep(tline,'TROPICAL DEPRESSION','TROPICALDEPRESSION');
    fprintf(fid1,'%s\n',tline);
end
fclose(fid1);
%fclose(fid2);
[a1,a2]=textread('reprodata.txt','%*d%f%f%*s%*d%*d%*s','headerlines',3);
 x=a2;
 y=a1;
 plot(x,y);
 hold on;
 plot(x,y+2);

