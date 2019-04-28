clear ; clc;

x = xlsread('shuju.xlsx');
x = x(1001:1001+1023);  % 有效数据长必须是2^n，所以我去1024，最后10几个点是0

N = length(x);
fs = 100;         % 采样频率 = 1/采样间隔
tt = (0:N-1)'/fs;  % 时间刻度

% 原始信号时域图像:
figure(1);
subplot(2,1,1);
plot(tt,x);
xlabel('时间/s'); ylabel('振幅'); title('时域原始信号'); grid on;
axis([0 max(tt) -inf inf])
subplot(2,1,2);
n = 1:N;
plot(n,x);
xlabel('采样点'); ylabel('振幅'); title('时域原始信号'); grid on;
axis([0 max(n) -inf inf]);


% 时频分析: 我觉得使用127窗口的应该是最好的！
figure(2);
h = hanning(63);  % 63个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
subplot(2,2,1); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 等值线图
xlabel('时间/ms');  ylabel('频率/Hz'); title('63节点汉宁窗时频图');
axis([0 N 0 15]);
grid on;

h = hanning(127); % 127个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
subplot(2,2,2); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 等值线图
xlabel('时间/ms');  ylabel('频率/Hz'); title('127节点汉宁窗时频图');
axis([0 N 0 15]);
grid on;

h = hanning(255); % 255个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
subplot(2,2,3); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 等值线图
xlabel('时间/ms');  ylabel('频率/Hz'); title('255节点汉宁窗时频图');
axis([0 N 0 15]);
grid on;

h = hanning(511); % 511个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
subplot(2,2,4); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 等值线图
xlabel('时间/ms');  ylabel('频率/Hz'); title('511节点汉宁窗时频图');
axis([0 N 0 15]);
grid on;

% 用填充型的2维图像显示:
figure(3);
h = hanning(127); % 127个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
mesh( tt, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) ); 
view(0,90); 
axis([0 max(tt) 0 15]);
xlabel('时间/ms');  ylabel('频率/Hz'); title('127节点汉宁窗时频图(mesh二维)');
colormap('HSV');
colorbar;
grid on;

% 用3维图像展示:
figure(4);
h = hanning(127); % 127个节点的汉宁窗
[tfr,t,f] = tfrstft(x,1:N,N,h);  % 参数一个都不能少 
mesh( tt, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 3维显示: 时间、频率、振幅
xlabel('时间/ms');  ylabel('频率/Hz'); zlabel('振幅'); title('127节点汉宁窗时频图(mesh三维)');
axis([0 max(tt) -inf inf -inf inf]);
colormap('HSV');
colorbar;
grid on;

