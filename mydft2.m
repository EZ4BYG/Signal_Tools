clc; clear;

data = imread('zxc.jpg');  % 数据——最好比卷积核的尺寸大
data = im2double(data); 
data = rgb2gray(data);     % rgb转为灰度图像
% subplot(1,3,1);
% imshow(data);
title('原始图像')

zidai = fft2(data);
%subplot(1,3,2);
figure(3)
imshow(real(zidai));  % 一般只要实部
title('自带的fft2生成的"频域"图像');

size_data = size(data);
M = size_data(1);  % 图(原始数据矩阵)的长
N = size_data(2);  % 图(原始数据矩阵)的宽

% 下面是傅里叶正变换必备的一些矩阵:
Wm = exp(-j*2*pi/M);
Wn = exp(-j*2*pi/N); % 不同G中用不同的W
Em = zeros(M);
En = zeros(N);     % E是辅助计算矩阵
Gm = zeros(M)+Wm;
Gn = zeros(N)+Wn;  % G是计算时要用的矩阵
F = zeros(M,N);    % F是转换到频域的结果

% 对Gm的计算: 循环长度为M
fprintf('二维离散傅里叶变换开始:\n');
for row = 0:M-1
    for col = 0:M-1
        Em(row+1,col+1) = row * col;
        Gm(row+1,col+1) = Gm(row+1,col+1)^Em(row+1,col+1);
    end
end
% 对Gn的计算: 循环长度为N
for row = 0:N-1
    for col = 0:N-1
        En(row+1,col+1) = row * col;
        Gn(row+1,col+1) = Gn(row+1,col+1)^En(row+1,col+1);
    end
end

F = real(Gm*data*Gn);  % F = Gm*f*Gn是计算公式，一般只要实部
% subplot(1,3,3);
% imshow(F);
title('手写的myfft2生成的"频域"图像');

error = sum(sum((real(F)-real(zidai)).^2));
if error < 10^(-10)
    fprintf('自带与手写结果一致!\n');
else
    fprintf('不一致!\n');
end



        
