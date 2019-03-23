% 鉴于正向fft2手写与自带结果一致；
% ifft2的输入就直接用自带的fft2的结果。
clc; clear;

data = imread('zxc.jpg');  % 数据——最好比卷积核的尺寸大
data = im2double(data); 
data = rgb2gray(data);     % rgb转为灰度图像
subplot(1,3,1);
imshow(data);
title('原始图像')

F = fft2(data);
subplot(1,3,2);
imshow(real(F));  % 一般画图只要实部, 作为输入时实虚都要！！
title('自带的fft2生成的"频域"图像');

% s = ifft2(F);
% subplot(1,3,3);
% imshow(s);
% return;

size_data = size(F);
M = size_data(1);  % 图(原始数据矩阵)的长
N = size_data(2);  % 图(原始数据矩阵)的宽

% 下面是傅里叶逆变换必备的一些矩阵:
Wm = exp(-j*2*pi/M);
Wn = exp(-j*2*pi/N);  % 不同G中用不同的W
Em = zeros(M);
En = zeros(N);        % E是辅助计算矩阵
Gm = zeros(M)+Wm;
Gn = zeros(N)+Wn;  % G是计算时要用的矩阵
f = zeros(M,N);    % F是转换到频域的结果

% 对Gm的计算: 循环长度为M
fprintf('二维离散反傅里叶变换开始:\n');
for row = 0:M-1
    for col = 0:M-1
        Em(row+1,col+1) = -row * col;
        Gm(row+1,col+1) = Gm(row+1,col+1)^Em(row+1,col+1);
    end
end
Gm = Gm/M;
% 对Gn的计算: 循环长度为N
for row = 0:N-1
    for col = 0:N-1
        En(row+1,col+1) = -row * col;
        Gn(row+1,col+1) = Gn(row+1,col+1)^En(row+1,col+1);
    end
end
Gn = Gn/N;   % 注意：这个/N和上面的/M都是算完G之后才除以的！因为上面计算的时候是幂项变化！

f = real(Gm*F*Gn);  % f = Gm*F*Gn是计算公式，一般只要实部
subplot(1,3,3);
imshow(f);
title('手写的myidft2生成的"原始"图像');

error = sum(sum((real(f)-real(data)).^2));
if error < 10^(-10)
    fprintf('反变换后与原图一致!\n');
else
    fprintf('不一致!\n');
end