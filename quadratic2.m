function [x1,x2] = quadratic2(a,b,c)
function disc  % nested function Ç¶Èëº¯Êý
d = sqrt(b^2 - 4*a*c);
end % end of function 
disc;
fprintf("variable is +%d",d);
x1 = (-b + d) / (2*a);
x2 = (-b - d) / (2*a);
end % end of function quadratic2