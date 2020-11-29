function [ifs,amp]=imf2ifa(imf,h);
% Input: 
%     imf : just IMF
%     h   : time difference (dt) between two data points
% Output
%     ifs : instantaneous frequency for each imf
%     amp : instantaneous amplitude


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
ifs=ones(L,W);
for k=1:W;
    yi=imf(:,k);
    [nmyi,a]=imfnormalize(yi);
    amp(:,k)=a;
    z=hilbert(nmyi);
    f=abs(mydiff(unwrap(angle(z)),1))/(2*pi*h);
    ifs(:,k)=f';
end