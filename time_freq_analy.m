clear all; clc;

N = 1024;  % 总采样点
fs = 1000;          % 采样频率
t = (0:N-1)'/fs;   % 时间刻度
% 构成信号: 注意x和t都是列向量
f1 = 400 ; f2 = 200 ; f3 = 100 ; f4 = 50 ;
x = sin(2*pi*f1*t).*(t<=0.3) + sin(2*pi*f2*t).*(t>0.3&t<=0.6) + ...
    sin(2*pi*f3*t).*(t>0.6&t<=0.8) + sin(2*pi*f4*t).*(t>0.8);

figure(1);
plot(t,x);
axis([0 max(t) -inf inf]); 
xlabel('时间/s');
ylabel('振幅');
title('原始时域信号');

% 短时傅里叶变换操作:
figure(2);

% 因为tfr把频率轴限制在-0.5~0.5之间，因此恢复"真实频率"的时候要x2
h = hanning(63);  % 63个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
subplot(2,2,1); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 等值线图
xlabel('时间/s');  ylabel('频率/Hz'); title('63节点汉宁窗时频图');
grid on;

h = hanning(127); % 127个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
subplot(2,2,2); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 等值线图
xlabel('时间/s');  ylabel('频率/Hz'); title('127节点汉宁窗时频图');
grid on;

h = hanning(255); % 255个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
subplot(2,2,3); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 等值线图
xlabel('时间/s');  ylabel('频率/Hz'); title('255节点汉宁窗时频图');
grid on;

h = hanning(511); % 511个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
subplot(2,2,4); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 等值线图
xlabel('时间/s');  ylabel('频率/Hz'); title('511节点汉宁窗时频图');
grid on;