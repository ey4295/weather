file=dir('./weather_final/');
path='./weather_information.dat';
numfile=length(file);
TH=[];
PH=[];
%遍历预处理好的数据，一条轨迹作为一个行向量
%用3-150个文件的数据进行学习
for k=3:150
    filename=file(k).name;
    path1=strcat(['./weather_final/'],filename);
    [a1,a2,a3,a4]=textread(path1,'%f%f%f%f','delimiter',',');
    TG=[a1,a2,a3,a4];
    TF=TG(:)';
    TH=[TH;TF];
    
end
dlmwrite(path,TH);
%用SVM进行学习，得到一个model
%training_label_vector=ones(size(TH,1),1);
%model =svmtrain(training_label_vector, TH, '-s 2');
%遍历其余的数据，一条轨迹作为一个行向量，进行预测
for i=151:numfile
    filename=file(i).name;
    path3=strcat(['./weather_final/'],filename);
    [b1,b2,b3,b4]=textread(path3,'%f%f%f%f','delimiter',',');
    PG=[b1,b2,b3,b4];
    PF=PG(:)';
    PH=[PH;PF];
end
dlmwrite(path,PH,'-append');
%用151-233文件数据进行预测
%testing_label_vector=ones(size(PH,1),1);
%[predicted_label,accuracy,decision_values]= svmpredict(testing_label_vector,PH, model);
Pkernel=[TH;PH]';
% kernel function processes data 
%[eigvector, eigvalue,Y] = KPCA(Pkernel,100);
data_out=kernelpca_tutorial(Pkernel,100);

%kernel函数处理过后的数据，进行SVM学习
training_instances=data_out';
training_label_vector=ones(150,1);
model =svmtrain(training_label_vector,training_instances(1:150,:) , '-s 2 ');

%用model进行预测
testing_label_vector=ones(81,1);
[predicted_label,accuracy,decision_values]= svmpredict(testing_label_vector,training_instances(151:231,:), model);
















