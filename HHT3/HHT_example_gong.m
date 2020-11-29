clear all
% ===== make testdata =====
% ti=0;
% tf=10;
% dt=.01;
% t=ti:dt:tf; % second
% 
% a1=1;
% f1=5;
% y1=a1*cos(2*pi*f1*t)*rand(length(t));
% a2=5;
% f2=1;
% y2=a2*sin(2*pi*f2*t);
% 
% testdata=y1+y2+10;

filename = 'cmy(finish).wav';
[data,Fs]=audioread(filename);

% wavplay(y,Fs)
testdata=data';
dt=1/Fs;
t=0:dt:length(testdata)/Fs-dt;

% ===== decomposition in time domain =====
st=100; % sifting time; 100-300
[IMF]=EMD(testdata,st);
% save('IMF.mat','IMF')
% load IMF.mat
  
 
 
%  for i=1:10;
%      plot(IMF(i,:));
%      title(['IMF' num2str(i)])
%      pause
%      close all
%  end
 
 
 
% set(gca,'xtick',[0:100:1000],'xticklabel',0:10);
% set(gca,'ytick',get(gca,'ytick'),'yticklabel',{'DC term','IMF5','IMF4','IMF3','IMF2','IMF1','test data'});
% xlabel('Time (second)');
%  pause
% ===== computation of instantaneous frequency and amplitude =====
[ipifs,ifs,amp]=imf2ipfa(IMF(1:end-1,:),dt); % the DC term should not be include

% ===== Hilbert spectrum =====
% x=round([t;t;t;t;t]'*100+1); % xlabel, time
[L,W]=size(ifs);

x=NaN(L,W);
for i=1:W;
    x(:,i)=t';
end
y=ifs;

x=x(:);
y=y(:);
z=amp(:);


% === x-axis (time) ===
dx=0.01;% time resolution 0.1 second
xi=0;
xf=t(end);

T=[xi:dx:0.5];

% === y-axis (frequency) ===
dy=10;% frequency resolution 100 Hz
yi=0;
yf=1500;
F=yi:dy:yf;

z(y>yf)=[];
x(y>yf)=[];
y(y>yf)=[]; % romove the data with frequency > 5000Hz

x=round(x/dx)+1;
y=round(y/dy)+1; % ylabel, frequency

x(z<0)=[]; % remove the bad data (negative amplitude)
y(z<0)=[];
z(z<0)=[];

% pause

% z(y>90)=[];
% x(y>90)=[];
% y(y>90)=[]; % romove the data with frequency > 9Hz

m=zeros(length(F),length(T));
c=m;
for i=1:length(z);
    m(y(i),x(i))=m(y(i),x(i))+z(i);
    c(y(i),x(i))=c(y(i),x(i))+1;
end

hsp=m./c;

close all
figure('position',[300 100 600 600])
axes('position',[.15 .64 .7 .3])
plot(t,testdata,'-k');
title('(a) Data');
set(gca,'fontsize',16)
grid on
axis tight

axes('position',[.15 .12 .7 .4])
pcolor(T,F,hsp);
shading flat
%[C,H]=contourf(T,F,hsp);
%set(H,'levellist',[0:.0001:.3])
caxis([0 .02])
cb=colorbar('position',[.88 .12 .03 .4]);
set(get(cb,'title'),'string','Amplitude')
xlabel('Time (second)');
ylabel('Frequency (Hz)');
ylim([0 1500])
title('(b) Hilbert spectrum');
set(gca,'fontsize',16)
set(gcf,'paperpositionmode','auto')
print -dpng -r300 Fig01

