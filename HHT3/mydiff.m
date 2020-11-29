function ddata=mydiff(data,h)

L=length(data);
ddata=NaN(1,L);
for i=1:L;
    if i==1;
        ddata(1)=(-3*data(1)+4*data(2)-data(3))/(2*h);
    else
        if i==L;
            ddata(L)=(-3*data(L-2)+4*data(L-1)-data(L))/(2*h);
        else
            ddata(i)=(-data(i-1)+data(i+1))/(2*h);
        end
    end
end