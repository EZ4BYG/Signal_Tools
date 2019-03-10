%% 题目2: 有信号x(t) = sin(2*pi*40*t) + sin(2*pi*15*t)，采样频率为100Hz，采样点数自拟。
%% 对该信号进行FFT，然后对其结果进行逆FFT。将结果与原始信号进行对比，是否一样？

clc; clear;
N = input('输入采样总点数(N=2^n)：');  % 总采样点数
fs = 100;   % 采样频率
n = 0:N-1;  % 样本点的序号(从0开始)
t = n/fs;   % 每个样本点对应的采样的时刻
x = sin(2*pi*40*t) + sin(2*pi*15*t); % 原始信号(仍是离散的,只不过用了函数而已)
subplot(1,3,1), plot(t,x);
xlabel('采样点时刻(s)'); ylabel('振幅'); title('原始时域信号'); grid on;  % 注意这里x轴我换成了时间

% 傅里叶正变换:
y = fft(x,N);
mag = abs(y);
f = n*fs/N;    % 奈奎斯特采样频率
subplot(1,3,2), plot(f(1:N/2),mag(1:N/2));  % 直接这里换了
xlabel('频率/Hz'); ylabel('振幅'); title('真-振幅频率图'); grid on;

% 傅里叶逆变换:
xifft = ifft(y,N);
magx = real(xifft);   % 逆变换回去就只用取"实部"即可!
tt = [0:length(xifft)-1]/fs;   % 和上面t=n/fs是完全一样的 都是[0~127]/100
subplot(1,3,3), plot(tt,magx);
xlabel('采样点时刻(s)'); ylabel('振幅'); title('ifft原始时域信号'); grid on;