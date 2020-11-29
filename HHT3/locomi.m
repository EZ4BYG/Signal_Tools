%Find the maginitude and locations of the maximun and minmun in the data
function [x_d,y_d]=locomi(data);
% input  data = data matrix [1*n]
%
% output f_au = ���j�Ȫ���
%        f_ad = ���p�Ȫ���
%        t_au = ���j�Ȧb��x�}����m
%        t_ad = ���p�Ȧb��x�}����m
y=data;
l_y=length(y);

y_d=zeros(round(l_y/2),1);
x_d=zeros(round(l_y/2),1);

countd=0;

for i=2:l_y-1;
    if y(i-1) > y(i) & y(i) < y(i+1);
        countd=countd+1;
        y_d(countd,1)=y(i);
        x_d(countd,1)=i;
    else if y(i-1) > y(i) & y(i) == y(i+1);
            countd=countd+1;
            y_d(countd,1)=y(i);
            x_d(countd,1)=i;
        end
    end
end

y_d=y_d(1:countd)';
x_d=x_d(1:countd)';

l_d=length(y_d);

%eval([' disp('' d = ' num2str(l_d) '''); ']);