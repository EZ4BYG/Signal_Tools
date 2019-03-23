clc; clear;

data = imread('zxc.jpg');  % 数据——最好比卷积核的尺寸大
data = im2double(data); 
data = rgb2gray(data);     % rgb转为灰度图像
%subplot(1,3,1);
figure(1);
imshow(data);
title('原始图像')

zidai = fft2(data);
zidai = fftshift(zidai);   % matlab自带的中心化函数
% subplot(1,3,2);
figure(2);
imshow(log(abs(zidai) + 1),[]);  % 一般只要实部
title('自带的fft2生成的"中心化频域"图像');

size_data = size(data);
M = size_data(1);  % 图(原始数据矩阵)的长
N = size_data(2);  % 图(原始数据矩阵)的宽

% 巴特沃斯低/高通滤波器:
grade = 4;     % 4阶巴特沃斯滤波器
D0 = 100;  % 截止频率
center_M = fix(M/2);
center_N = fix(N/2);  % center_M与center_N是频率谱矩形的中心
filter_lowpass = zeros(M,N);   % 低通
filter_highpass = zeros(M,N);  % 高通
% 低/高通滤波器(矩阵)生成:
for m = 1:M
    for n = 1:N
        D = sqrt( (m-center_M)^2 + (n-center_N)^2 );  % D是距频率矩形中心的距离
        filter_lowpass(m,n) = 1/( 1 + (D/D0)^(2*grade) );
        % filter_highpass(m,n) = 1/( 1 + (D0/D)^(2*grade) );  % 注意高低通的区别
    end
end

lowpass_zidai = filter_lowpass.*zidai;  % 低通滤波器处理后的新的频谱数据
lowpass_data = ifft2(lowpass_zidai);
% subplot(1,3,3);
figure(3);
imshow(abs(lowpass_data));
title('低通滤波后的图像');
        


