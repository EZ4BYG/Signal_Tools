clear; clc;

x = xlsread('shuju.xlsx');
x = x(1001:1001+1023)';  % 有效数据长必须是2^n，所以我取1024，最后10几个点是0
N = length(x);
fs = 100;          % 采样频率 = 1/采样间隔
t = (0:N-1)/fs;   % 时间刻度

 [modes its] = ceemdan(x,0.01,500,5000);  % 经验模态分解的改进方法
% [modes,ort,nbits] = emd(x);  % 原始方法

%对IMF分量求取瞬时频率与振幅：A：是每个IMF的振幅向量,f:每个IMF对应的瞬时频率，t：时间序列号
[A,f,t] = hhspectrum(modes);   
%将每个IMF信号合成求取Hilbert谱，E：对应的振幅值，Cenf：每个网格对应的中心频率  这里横轴为时间，纵轴为频率    
[E,t,Cenf] = toimage(A,f);     

figure(2);
t = t/fs;  % 转换成采样点时间
Cenf = Cenf*1000; % 乘1000恢复成实际频率值(原始是归一化的值)
gca = mesh(t,Cenf,E);   
xlabel('采样点时间(s)'); ylabel('振幅'); title('ceemdan分解的希尔伯特-黄变换时频谱');
axis([0 max(t) 0 100]);
view(0,90); 
colormap('HSV');
colorbar;
