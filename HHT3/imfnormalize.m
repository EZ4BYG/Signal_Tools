function [nmdata,a]=imfnormalize(data)
 
[L,W]=size(data);
X=[1:L]';

% figure
% plot(abs(data))
% size(data)
[tx,mx]=locoma(abs(data));
tx=tx';
mx=mx';

% figure
% subplot(2,1,1)
% hold on
% plot(data)
% plot(data,'.')

if( ~isempty(tx) )
  tx=[1;tx;L];
  mx=[mx(1);mx;mx(end)];
  a=spline(tx,mx,X);
  nmdata=data./a;  
else
  [y,i] = max(abs(data));
  nmdata=data/y;  
  a = data;
  size(nmdata)
end
% subplot(2,1,2)
% plot(nmdata)

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