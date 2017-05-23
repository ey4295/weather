file=dir('./weather_final/');
path='./weather_information.dat';
numfile=length(file);
TH=[];
PH=[];
%����Ԥ����õ����ݣ�һ���켣��Ϊһ��������
%��3-150���ļ������ݽ���ѧϰ
for k=3:150
    filename=file(k).name;
    path1=strcat(['./weather_final/'],filename);
    [a1,a2,a3,a4]=textread(path1,'%f%f%f%f','delimiter',',');
    TG=[a1,a2,a3,a4];
    TF=TG(:)';
    TH=[TH;TF];
    
end
dlmwrite(path,TH);
%��SVM����ѧϰ���õ�һ��model
%training_label_vector=ones(size(TH,1),1);
%model =svmtrain(training_label_vector, TH, '-s 2');
%������������ݣ�һ���켣��Ϊһ��������������Ԥ��
for i=151:numfile
    filename=file(i).name;
    path3=strcat(['./weather_final/'],filename);
    [b1,b2,b3,b4]=textread(path3,'%f%f%f%f','delimiter',',');
    PG=[b1,b2,b3,b4];
    PF=PG(:)';
    PH=[PH;PF];
end
dlmwrite(path,PH,'-append');
%��151-233�ļ����ݽ���Ԥ��
%testing_label_vector=ones(size(PH,1),1);
%[predicted_label,accuracy,decision_values]= svmpredict(testing_label_vector,PH, model);
Pkernel=[TH;PH]';
% kernel function processes data 
%[eigvector, eigvalue,Y] = KPCA(Pkernel,100);
data_out=kernelpca_tutorial(Pkernel,100);

%kernel���������������ݣ�����SVMѧϰ
training_instances=data_out';
training_label_vector=ones(150,1);
model =svmtrain(training_label_vector,training_instances(1:150,:) , '-s 2 ');

%��model����Ԥ��
testing_label_vector=ones(81,1);
[predicted_label,accuracy,decision_values]= svmpredict(testing_label_vector,training_instances(151:231,:), model);
















