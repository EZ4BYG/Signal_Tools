function [ips,ifs,amp]=imf2ipfa(imf,h);

% h=0.001;
% t=0:h:10;
% f=23.5;
% y1=sin(2*pi*f*t);
% y2=cos(2*pi*5*t);
% y=[y1;y2];
% imf=y;

% load('D:\MATLAB701\work\地熱資料分析\ifia\ooodimf01.mat')
% imf=DIMF{1};
% [I,J]=find(imf == 0);
% imf(unique(I),:)=[];
% imf=imf(1:end-1,:);

[I,J]=size(imf);
if I > J;
    L=I;
    W=J;
    imf=imf;
else
    W=I;
    L=J;
    imf=imf';
end

amp=ones(L,W);
ips=ones(L,W);
ifs=ones(L,W);
for k=1:W;
    yi=imf(:,k);
    t_amp=ones(L,1);
    for j=1:3;
        [yi,a]=splinenormalize(yi);
    %    [yi,a]=imfnormalize(yi);
        t_amp=t_amp.*a;
    end
    amp(:,k)=t_amp;
    %    t_a=t_a.*a;
    %end
    %amp(:,k)=t_a;
    %amp(:,k)=a;
    
    dyi=mydiff(yi,1);
    imag_y=(1-yi.^2).^(1/2);
    imag_y(dyi>0)=-imag_y(dyi>0);
    z=yi+i*imag_y;
    
   %  z=hilbtm(yi);
    p=unwrap(angle(z));
    f=abs(mydiff(p,1))/(2*pi*h);
    
%     ifs(:,k)=f';%frequency
    ips(:,k)=p';
    ifs(:,k)=f';
end