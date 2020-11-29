%Find the maginitude and locations of the maximun and minmun in the data
function [x_u,y_u]=locoma(data);
% input  data = data matrix [1*n]
%
% output f_au = ���j�Ȫ���
%        f_ad = ���p�Ȫ���
%        t_au = ���j�Ȧb��x�}����m
%        t_ad = ���p�Ȧb��x�}����m
y=data;
l_y=length(y);

y_u=zeros(round(l_y/2),1);
x_u=zeros(round(l_y/2),1);

countu=0;

for i=2:l_y-1;
    if y(i-1) < y(i) & y(i) > y(i+1);
        countu=countu+1;
        y_u(countu,1)=y(i);
        x_u(countu,1)=i;
    else if y(i-1) < y(i) & y(i) == y(i+1);
            countu=countu+1;
            y_u(countu,1)=y(i);
            x_u(countu,1)=i;
        end
    end
end

y_u=y_u(1:countu)';
x_u=x_u(1:countu)';

l_u=length(y_u);

%eval([' disp('' u = ' num2str(l_u) '''); ']);
