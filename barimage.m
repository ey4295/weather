x=[1:10];
y=[75,58,90,87,50,85,92,75,60,95];
bar(x,y),xlabel('Student'),ylabel('Score'),title('First Sem:')
print -deps graph.eps   %以矢量的形式存储图形，图片名称为graph.eps