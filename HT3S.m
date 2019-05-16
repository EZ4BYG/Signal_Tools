% 根据希尔伯特变换得到3瞬属性: 瞬时振幅、瞬时相位、瞬时频率(还有问题，待修改)

clear ; clc;

x = xlsread('shuju.xlsx');
x = x(1001:1001+1023)';  % 有效数据长必须是2^n，所以我去1024，最后10几个点是0
N = length(x);
fs = 100;          % 采样频率 = 1/采样间隔
tt = (0:N-1)/fs;  % 时间刻度

figure(1);
subplot(2,1,1);
plot(tt,x);
axis([min(tt) max(tt) -inf inf]);
xlabel('时间'); ylabel('振幅'); title('原始信号');

% 这里直接用自带的变换函数了hilbert
h = hilbert(x);
imagh = imag(h);
subplot(2,1,2);
plot(tt,imagh);
axis([min(tt) max(tt) -inf inf]);
xlabel('时间'); ylabel('振幅'); title('希尔伯特变换结果(相位滞后)');

figure(2);
% 瞬时振幅/包络: 
dA = abs(h);
subplot(3,1,1);
plot(tt,dA,'r'); % 包络包着原信号
hold on;
plot(tt,x); % 原信号
axis([min(tt) max(tt) -inf inf]);
xlabel('时间'); ylabel('瞬时振幅'); title('3瞬-瞬时振幅');

% 瞬时相位:
dfai = atan(imagh./x);
subplot(3,1,2);
plot(tt,dfai);
axis([min(tt) max(tt) -inf inf]);
xlabel('时间'); ylabel('瞬时相位'); title('3瞬-瞬时相位');

% 瞬时频率: 离散数据只能用"差分/梯度"来近似代替
 df = gradient(dfai)./gradient(tt);  % 梯度代替
% df = diff(dfai)./diff(tt);  % 差分代替

subplot(3,1,3);
plot(tt(1:length(df)),df);
axis([min(tt) max(tt) -inf inf]);
xlabel('时间'); ylabel('瞬时频率'); title('3瞬-瞬时频率');
    

