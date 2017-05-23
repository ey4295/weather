function [x1,x2]=quadratic(a,b,c)
d=disc(a,b,c);
x1=(-b+d)/(2*a)
x2=(-b-d)/(2*a)
end      %end of quafratic
function dis=disc(a,b,c)
%function calculates the discriminant
if(b^2-4*a*c>=0)
    dis=sqrt(b^2-4*a*c);
else 
    dis=9999999999999999;
    fprintf("该一元二次方程无实根");
end
end
