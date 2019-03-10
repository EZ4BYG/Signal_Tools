%% 题目3: 对采样间隔dt为0.02s（对应于采样频率为50Hz）的信号:
%% x(t) = 0.5*sin(2*pi*3*n*dt) + cos(2*pi*10*n*dt)，采样点自拟，进行FFT; 
%% 将频率为8 ~ 15Hz的波滤去！再把滤波后的频率域信号IFFT转回到时间域，观察区别。
%% 绘制4幅图：原始时域信号、原始真频域信号、滤波后真频域信号、滤波后时域信号。

clc; clear;
N = input('输入采样总点数(N=2^n)：');  % 总采样点数
dt = 0.02;  % 对应于前面就是fs = 1/dt = 50Hz
n = 0:N-1;  % 样本点的序号(从0开始)
t = n*dt;   % 每个样本点对应的采样的时刻
x = 0.5*sin(2*pi*3*t) + cos(2*pi*10*t); 
subplot(2,2,1), plot(t,x);
xlabel('采样点时刻'); ylabel('振幅'); title('原始时域信号'); grid on;  % 注意这里x轴我换成了时间

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
f = n/(N*dt);

subplot(2,2,3), plot(f(1:N/2),mag(1:N/2));  % 还是要真频率图
xlabel('频率/Hz'); ylabel('振幅'); title('原始真频率信号'); grid on;

% 滤波: 把要滤去的频段的振幅弄成0即可
f1 = 8; f2 = 15;
yy = zeros(1,length(Xk));  % 创造和Wk一样长的数组,且下标对应
for m = 0:N-1              % 采样时刻是从0时开始的; 数组下标是从1开始的
    if m/(dt*N) > f1 & m/(dt*N) < f2
        yy(m+1) = 0;       % 要滤的位0
    else
        yy(m+1) = Xk(m+1);  % 不滤的保持原值
    end
end
maglb = abs(yy);

subplot(2,2,4), plot(f(1:N/2),maglb(1:N/2));  % 这里稍微注意一下即可
xlabel('频率/Hz'); ylabel('振幅'); title('滤波后真频域信号'); grid on;

% 把滤波后的频域信号ifft回时域
WN_nk_n = zeros(N)+WN;  % WN_kn矩阵(初始)
E_n = zeros(N); 

for row = 0:N-1
    for cow = 0:N-1
        E_n(row+1,cow+1) = -row*cow;
        WN_nk_n(row+1,cow+1) = WN_nk_n(row+1,cow+1)^E_n(row+1,cow+1);
    end
end

xk_n = real((WN_nk_n * yy')/N)';

subplot(2,2,2), plot(t,xk_n);
xlabel('采样点时刻'); ylabel('振幅'); title('滤波后时域信号'); grid on;