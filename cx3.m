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

% 傅里叶正变换:
y = fft(x,N);
mag = abs(y);
f = n/(dt*N);      % f = n*fs/N = n/(dt*N) 奈奎斯特采样频率
subplot(2,2,3), plot(f(1:N/2),mag(1:N/2));  % 还是要真频率图
xlabel('频率/Hz'); ylabel('振幅'); title('原始真频率信号'); grid on;

% 频率域滤波
f1 = 8; f2 = 15;
yy = zeros(1,length(y));  % 创造和y一样长的数组,且下标对应
for m = 0:N-1             % 采样时刻是从0时开始的; 数组下标是从1开始的
    if m/(dt*N) > f1 & m/(dt*N) < f2
        yy(m+1) = 0;       % 要滤的位0
    else
        yy(m+1) = y(m+1);  % 不滤的保持原值
    end
end
maglb = abs(yy);
subplot(2,2,4), plot(f(1:N/2),maglb(1:N/2));  % 这里稍微注意一下即可
xlabel('频率/Hz'); ylabel('振幅'); title('滤波后真频域信号'); grid on;

% 傅里叶逆变换: 把滤波后的频率域信号IFFT回时域信号
xifft = ifft(yy,N);
magx = real(xifft);   % 逆变换回去就只用取"实部"即可!
tt = [0:length(xifft)-1]*dt;   % 注意这里把1/fs换成了dt
subplot(2,2,2), plot(tt,magx);
xlabel('采样点时刻'); ylabel('振幅'); title('滤波后时域信号'); grid on;




