clear; clc;

% 原始数据尺寸:
bc = 1;  % 单点周围扩大的边长(每次修改这里)
x = [8 11 13 1 1;5 26 17 2 2;39 12 11 1 3]  % 原始矩阵(随意尺寸和数值)
size_x = size(x);
rowx = size_x(1);
colx = size_x(2);

% 扩展后尺寸:
kz = zeros(rowx+(rowx-1)*bc+bc*2,colx+(colx-1)*bc+bc*2); 
% 注意上式扩边的写法，为了保证通用性(任意扩边长度均可实现)
size_kz = size(kz);
rowkz = size_kz(1);
colkz = size_kz(2);

% 将原数值按对应位置插回去:
countn = 1;
countm = 1; % 行与列的计数器(方便理解)
mtmp = bc*countm;
ntmp = bc*countn; % 这两个临时变量是记录x原数据的坐标 
for m = bc+1:bc+1:rowkz
    for n = bc+1:bc+1:colkz
        kz(m,n) = x(m-mtmp,n-ntmp);  % 对应位置插进去
        countn = countn + 1;
        ntmp = bc*countn;
    end
    countm = countm + 1;
    mtmp = bc*countm;
    % 列序号记得恢复(因为列的新一轮开始了)
    countn = 1;
    ntmp = bc*countn;
end

kz