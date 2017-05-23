%x = [0 : 0.01: 10];
%y = exp(-x).* sin(2*x + 3);
%plot(x, y), axis([0 10 -1 1])
x = [0:0.01:5];
y = exp(-1.5*x).*sin(10*x);
subplot(1,2,1)
plot(x,y), xlabel('x'),ylabel('exp(¨C1.5x)*sin(10x)'),axis([0 5 -1 1])
y = exp(-2*x).*sin(10*x);
subplot(1,2,2)
plot(x,y),xlabel('x'),ylabel('exp(¨C2x)*sin(10x)'),axis([0 5 -1 1])