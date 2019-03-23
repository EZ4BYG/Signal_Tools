clc; clear;

data = imread('rb.jpg');   % 数据——最好比卷积核的尺寸大
data = im2double(data);    % 原图像进来是uint8，矩阵运算时double 故要转一下

% rgb转为灰度图像
data = rgb2gray(data);     % 最后的输入的数据
subplot(2,2,1)
imshow(data);
title('原始灰度值图像');

% 高斯噪声: 均值为m，方差为var的高斯噪声加到图像中  var越大越模糊
 noise_data = imnoise(data, 'gaussian', 0.02); 
% 椒盐噪声: 0.1是全图10%的程度受污染
% noise_data = imnoise(data, 'salt & pepper', 0.3);

% noise_data = im2double(noise_data);  % 这里记得要先转为double类型
subplot(2,2,2);
imshow(noise_data);
title('加入"高斯/椒盐"噪声后图像')

% 开始卷积滤波:
x = zeros(5,5)+1;     % 卷积核——必须是方阵且为奇数行/列
x = rot90(rot90(x));  % 新的卷积核

% 核的尺寸
size_x = size(x);
row_x = size_x(1);  % 核的行数
col_x = size_x(2);  % 核的列数
% 数据的尺寸
size_data = size(data);
row_data = size_data(1);  % 数据的行数
col_data = size_data(2);  % 数据的列数

% 核的中心元素:
centerx_row = round(row_x/2);
centerx_col = round(col_x/2);
centerx = x(centerx_row,centerx_col);

% 对原始数据扩边:
data_tmp = zeros(row_data+row_x-1,col_data+row_x-1);
data_tmp(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1) = noise_data;
data_k = data_tmp;
% 扩边后新数据矩阵尺寸:
size_data_k = size(data_k);
row_data_k = size_data_k(1);
col_data_k = size_data_k(2);

% m = centerx_row:row_data+row_x-2
% 开始卷积计算: m n 是新数据矩阵的正常索引
result_mean = zeros(row_data_k,col_data_k);
result_mid = zeros(row_data_k,col_data_k);
% m n一般卷积步长都是1
for m = centerx_row:centerx_row+row_data-1
    for n = centerx_row:centerx_row+col_data-1
        % tt是临时与卷积核大小相同的数据中的部分矩阵:
        tt = data_k(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_row-1):n+(centerx_row-1));
        juan1 = mean(x.*tt);
        result_mean(m,n) = mean(juan1(:));
        juan2 = median(x.*tt);
        result_mid(m,n) = median(juan2(:));
    end
end

% 求掉之前扩边的0:
result_mean = result_mean(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);
result_mid = result_mid(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);

% 做图:
subplot(2,2,3);
imshow(result_mean);
title('均值滤波后图像');
subplot(2,2,4);
imshow(result_mid);
title('中值滤波后图像');

% 结论: 高斯噪声用均值滤波好，椒盐噪声用中值滤波好。