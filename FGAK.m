-%函数功能：
%用于变长轨迹的核空间映射
%输入参数：V1，V2,sigma,T
% 第m条和第n条轨迹数据向量V1，V2
% sigma为核宽度
% T为约束参数
%输出参数：data_outset输出的变换后的核矩阵
function  data_outset=FGAK(V1,V2,sigma,T)
nX=length(V1);
nY=length(V2);
tmax=Max(nX, nY);  %get the longer length betweenV1 and V2
stt=Min(tmax+1, T); %get the smaller one
LOG0=-10000;
logM=[];
for a=1:(nY+1)*2
    logM=[logM;LOG0];
end
if T>0
    %initialize array triangularCoeff with value LOG0
    triangularCoeff=[];
    for b=1:tmax +1
        triangularCoeff=[triangularCoeff;LOG0];
    end
    for i=1:stt
        triangularCoeff=[triangularCoeff,log(1-i/T)];
    end
else
    %initialize array triangularCoeff with value 0
    triangularCoeff=zeros(tmax+1,1);
end
sig=-1/(2*sigma*sigma);
cur=1;
prev=0;
for h=1:nX
    curpos=cur*(nY+1);
    logM(curpos,1)=LOG0;
    for j=1:nY
        curpos=cur*( nY+1)+ j;
        if triangularCoeff(abs(i-j),1)> LOG0
            pos1=prev*(nY+1) + j;
            pos2=cur*(nY+1) + j-1;
            pos3=prev*(nY+1) + j-1;
            sum=0;
            for k=1 :size(V1,2)     %the number of trajectory’s features,即，轨迹M的第二维
                sum=sum+(V1(1,(h-1+k*nX))-V2(1,(j-1+k*nY)))*(V1(1,(h-1+k*nX))-V2(1,(j-1+k*nY)));
                gram=triangularCoeff(1,abs(i-j))+ sum*sig;
                gram=gram-log(2-exp(gram));
                temp=log(exp(-abs(logM(1,pos1)-logM(1,pos2))+1));
                temp=temp+ Max(logM(1,pos1), logM(1,pos2));
                logM(1,curpos)=log(exp(-abs(temp-logM(1,pos3)))) + gram;
                logM(1,curpos)=logM(1,curpos)+Max(temp,logM(1,pos3));
            end
        else
            logM(1,curpos)=LOG0;
        end
    end
    cur=1-cur;
    prev=1-prev;
end
K(m, n)=logM(1,curpos);
data_outset=K(m, n);
end