[x,y]=meshgrid(-5:0.1:5,-3:0.1:3);  %independent variables
g=x.^2+y.^2;                          %independent variables
[C,h]=contour(x,y,g); % call the contour function
set(h,'ShowText',on','TextStep',get(h,'LevelStep')*2)
%showTextgeide等高线显示标签
print -deps graph1.eps
