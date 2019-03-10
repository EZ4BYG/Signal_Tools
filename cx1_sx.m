%% 题目1：一个信号由15Hz、振幅为0.5的正弦信号和40Hz、振幅为2的正弦信号组成。
%% 数据采样频率Fs=100Hz（对应于采样间隔为0.01s）。
%% 试分别绘制N=128（采了128个点）的FFT"振幅频率图"和N=1024的振幅频率图。

clc; clear;

N = input('输入采样总点数(N=2^n)：');  % 总采样点数
fs = 100;   % 采样频率
n = 0:N-1;  % 样本点的序号(从0开始)
t = n/fs;   % 每个样本点对应的采样的时刻
x = 0.5*sin(2*pi*15*t) + 2*sin(2*pi*40*t); % 原始信号(仍是离散的,只不过用了函数而已)

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

Xk = WN_nk * xk;   % 已转换到频域
mag = abs(Xk);    
f = n*fs/N;        % 频率序列,根据"奈奎斯特采样定理"得到 -- 奈奎斯特频率

% 画图部分:
subplot(1,3,1), plot(n,x); % 这里x轴也可以是时间t序列(本例用的是序号)
xlabel('采样点序号'); ylabel('振幅'); title('原始时域信号'); grid on;

subplot(1,3,2), plot(f,mag);     % 奈奎斯特振幅频率图(有对称性)
xlabel('频率/Hz'); ylabel('振幅'); title('奈奎斯特-振幅频率图(对称)'); grid on;

f1 = f(1:N/2);
mag1 = mag(1:N/2);  % 真图是奈奎斯特的一半
subplot(1,3,3), plot(f1,mag1);   % 真振幅频率图
xlabel('频率/Hz'); ylabel('振幅'); title('真-振幅频率图'); grid on;


