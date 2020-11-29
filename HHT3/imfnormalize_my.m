function [nmdata,a]=imfnormalize(data);
 
[L,W]=size(data);
X=[1:L]';

[tx,mx]=locoma(abs(data));
tx=tx';
mx=mx';

tx=[1;tx;L];
mx=[mx(1);mx;mx(end)];
a=spline(tx,mx,X);
nmdata=data./a;
c=0;
while any(nmdata > 1);
    c=c+1;
    if c > 5;break;end
    [tx,mx]=locoma(abs(nmdata));
    tx=tx';
    mx=mx';
    
    tx=[1;tx;L];
    mx=[mx(1);mx;mx(end)];
    ta=spline(tx,mx,X);
    nmdata=nmdata./ta;
    a=a.*ta;
end 

 

% 
% 
% subplot(211);
% hold all
% plot(data);
% plot(a);
% subplot(212);
% plot(nmdata);