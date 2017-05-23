%x=[0:0.01:10];
%y=sin(x);
%g=cos(x);
%plot(x,y,x,g,'.-'),legend('Sin(x)','Cos(x)')
x = [-10 : 0.01: 10];
y = 3*x.^4 + 2 * x.^3 + 7 * x.^2 + 2 * x + 9;
g = 5 * x.^3 + 9 * x + 2;
plot(x, y, 'r', x, g, 'g')
