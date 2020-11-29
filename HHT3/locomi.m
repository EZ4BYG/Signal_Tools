%Find the maginitude and locations of the maximun and minmun in the data
function [x_d,y_d]=locomi(data);
% input  data = data matrix [1*n]
%
% output f_au = 極大值的值
%        f_ad = 極小值的值
%        t_au = 極大值在原矩陣的位置
%        t_ad = 極小值在原矩陣的位置
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