fs = 100;  % 采样频率(采1.28s)
N = 256;   % 时域总数据点数: fft方法,一般N都是2^n
n = 0:N-1;   % 序号
t = n/fs;    % 时间序列每个点的时间

x = 0.5*sin(2*pi*15*t)+2*sin(2*pi*40*t); % 信号
figure(1);
plot(n,x);
xlabel('采样点序号'); ylabel('振幅值'); title('原始时域信号: 采样点数N=128'); grid on;

% 计算部分:
print('计算部分');
y = fft(x,N);     % fft
mag = abs(y);     % 求得Fourier变换后的振幅(复数的模)
f = n*fs/N;       % 采样定理: 频率序列(有的频率)

% 画图部分:
% 绘出"随频率(真频率)变化的振幅"——x轴频率,y轴振幅
% subplot(2,2,1);
figure(2);
plot(f,mag);   
xlabel('频率/Hz'); ylabel('振幅'); title('频域信号——真频域振幅对应'); grid on;

% 绘出Nyquist频率之前随频率变化的振幅
% subplot(2,2,2);
figure(3);
f_int = f(1:N/2);     % 取前N/2个
mag_int = mag(1:N/2); 
plot(f_int,mag_int);  
xlabel('频率/Hz'); ylabel('振幅'); title('奈奎斯特频率之前——原频率振幅对应'); grid on;
