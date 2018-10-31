function out=myfun(X)
global data1;
global data2;
corrected=fromsrgbtolinear(X*fromlineartosrgb(data1));
out=sum((abs(corrected'-data2')).^2,2);
if (any(corrected(:)>1)||any(corrected(:)<0))
    disp('truncature problem');
end;
end
