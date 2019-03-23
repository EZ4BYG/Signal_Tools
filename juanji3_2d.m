clc; clear;

% x = [1 1 1;1 -7 1;1 1 1];      % "强边缘锐化"卷积核
x = [-1 -1 0;-1 0 1;0 1 1];    % "浮雕"卷积核
% x = [-1 -1 -1 -1 0;-1 -1 -1 0 1;-1 -1 0 1 1;-1 0 1 1 1;0 1 1 1 1];  % "夸张浮雕"卷积核
% x = [-1 -1 -1;-1 8 -1;-1 -1 -1];   % 全方向边缘提取
% x = [0 0 -1 0 0;0 0 -1 0 0;0 0 4 0 0;0 0 -1 0 0;0 0 -1 0 0];  % "垂向边缘检测"卷积核
% x = [3 0 0 0 0;0 -1 0 0 0;0 0 -1 0 0;0 0 0 -1 0;0 0 0 0 -1];  % "边缘黑化"卷积核
% x = [0 0 1 0 0;0 0 1 0 0;1 1 -10 1 1;0 0 1 0 0;0 0 1 0 0];    % "边缘非常黑化"卷积核
% x = [1 1 1;1 1 1;1 1 1];  % 不变

data = imread('zxc.jpg');  % 数据——最好比卷积核的尺寸大
figure(1);
imshow(data)
data = double(data);
% zidai = conv3(data,x,'same');  没有自带的3维卷积

x = rot90(rot90(x));  % 新的卷积核

% 核的尺寸
size_x = size(x);
row_x = size_x(1);  % 核的行数
col_x = size_x(2);  % 核的列数
% 数据的尺寸
layer = data(:,:,1);      % 每一层的尺寸都是一样的
size_data = size(layer);
row_data = size_data(1);  % 数据的行数
col_data = size_data(2);  % 数据的列数

% 核的中心元素:
centerx_row = round(row_x/2);
centerx_col = round(col_x/2);
centerx = x(centerx_row,centerx_col);

% 对原始数据扩边: 0值框架大家都一样
data_tmp1 = zeros(row_data+row_x-1,col_data+row_x-1); 
data_tmp2 = zeros(row_data+row_x-1,col_data+row_x-1);
data_tmp3 = zeros(row_data+row_x-1,col_data+row_x-1);  % 每层新尺寸:不变,大家都一样

% 赋值要变: 每一层赋不同层对应的值
data_tmp1(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1) = data(:,:,1);
data_tmp2(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1) = data(:,:,2);
data_tmp3(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1) = data(:,:,3); 

% 扩边后每层新数据: 各不一样
data_k1 = data_tmp1;
data_k2 = data_tmp2;
data_k3 = data_tmp3;  

% 扩边后新数据矩阵尺寸: 每层是一样的,用一层的就行
size_data_k = size(data_k1);
row_data_k = size_data_k(1);
col_data_k = size_data_k(2);

% 记录每层卷积后的结果: 结果不同,分开记录
result1 = zeros(row_data_k,col_data_k);
result2 = zeros(row_data_k,col_data_k);
result3 = zeros(row_data_k,col_data_k);

% 开始卷积计算: m n 是新数据矩阵的正常索引
% 一般卷积步长都是1
for m = centerx_row:centerx_row+row_data-1
    for n = centerx_row:centerx_row+col_data-1
        % ttn是临时与卷积核大小相同的数据中的部分矩阵: 每层数值不一样,要分开记录
        tt1 = data_k1(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_row-1):n+(centerx_row-1));
        tt2 = data_k2(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_row-1):n+(centerx_row-1));
        tt3 = data_k3(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_row-1):n+(centerx_row-1));
        % juan是中间每一次卷积计算求和的中间量: 每层结果不一样,要分开记录
        juan1 = sum(x.*tt1);
        juan2 = sum(x.*tt2);
        juan3 = sum(x.*tt3);
        % 每一层结果的记录: 分别记录到不同的矩阵中
        result1(m,n) = sum(juan1(:));
        result2(m,n) = sum(juan2(:));
        result3(m,n) = sum(juan3(:));
    end
end

% 去掉之前扩边的0: 各去各的
result1 = result1(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);
result2 = result2(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);
result3 = result3(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);

% 3个图层合并回原图
result = cat(3,result1,result2,result3);

figure(2);
imshow(result);
