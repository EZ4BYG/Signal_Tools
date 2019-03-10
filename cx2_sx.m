%% 题目2: 有信号x(t) = sin(2*pi*40*t) + sin(2*pi*15*t)，采样频率为100Hz，采样点数自拟。
%% 对该信号进行FFT，然后对其结果进行逆FFT。将结果与原始信号进行对比，是否一样？

clc; clear;
N = input('输入采样总点数(N=2^n)：');  % 总采样点数
fs = 100;   % 采样频率
n = 0:N-1;  % 样本点的序号(从0开始)
t = n/fs;   % 每个样本点对应的采样的时刻
x = sin(2*pi*40*t) + sin(2*pi*15*t); % 原始信号(仍是离散的,只不过用了函数而已)

% 傅里叶变换前辅助变量:
WN = exp(-i*2*pi/N);  % 常数
WN_nk = zeros(N)+WN;  % WN_kn矩阵(初始)
xk = x';     % 时域信号振幅(列矩阵)
E = zeros(N);   % 辅助的E(WN_kn的幂,单独拿出来算)

% 对原始信号进行傅里叶变换(手动傅里叶变换):
for row = 0:N-1
    for cow = 0:N-1
        E(row+1,cow+1) = row*cow;
        WN_nk(row+1,cow+1) = WN_nk(row+1,cow+1)^E(row+1,cow+1);
    end
end

Xk = WN_nk * xk;
mag = abs(Xk);
f = n*fs/N;

% 傅里叶逆变换前辅助变量:
WN_nk_n = zeros(N)+WN;  % WN_kn矩阵(初始)
E_n = zeros(N); 

for row = 0:N-1
    for cow = 0:N-1
        E_n(row+1,cow+1) = -row*cow;
        WN_nk_n(row+1,cow+1) = WN_nk_n(row+1,cow+1)^E_n(row+1,cow+1);
    end
end

xk_n = real((WN_nk_n * Xk)/N)';  % 恢复到时域信号

% 画图部分:
subplot(1,3,1), plot(t,x); % x轴用时间
xlabel('采样点时刻(s)'); ylabel('振幅'); title('原始时域信号'); grid on;

subplot(1,3,2), plot(f(1:N/2),mag(1:N/2));  % 直接用真频(直接里面换了)
xlabel('频率/Hz'); ylabel('振幅'); title('真-振幅频率图'); grid on;

subplot(1,3,3), plot(t,xk_n);   % ifft后的时域信号
xlabel('采样点时刻(s)'); ylabel('振幅'); title('ifft后时域信号'); grid on;