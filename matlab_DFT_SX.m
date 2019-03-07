clc; clear;
% 从外部读取文件:
f_file = 'ceshi.txt';
fprintf('文件读取成功!原始数据为:\n');
data_org = load(f_file)';
[m,n] = size(data_org);
data = reshape(data_org, 1, m*n) % 把数据读到一行

N = length(data);     % W矩阵是N*N

WN = exp(-i*2*pi/N);  % 常数
WN_nk = zeros(N)+WN;  % WN_kn矩阵(初始)
xk = data';     % 时域信号振幅(列矩阵)
E = zeros(N);   % 辅助的E(WN_kn的幂,单独拿出来算)

%%% 傅里叶正变换即结果 %%%
for row = 0:N-1
    for cow = 0:N-1
        E(row+1,cow+1) = row*cow;
        WN_nk(row+1,cow+1) = WN_nk(row+1,cow+1)^E(row+1,cow+1);
    end
end

Xk = WN_nk * xk;

fprintf('傅里叶正变换:\n')
for num = 1:N
    if mod(num,4) == 0 && num ~= 0
        fprintf('X(%d): %f %fi\n', num-1, real(Xk(num)), imag(Xk(num)));
    else
        fprintf('X(%d): %f %fi\t', num-1, real(Xk(num)), imag(Xk(num)));
    end
end
fprintf('\n');

%%% 傅里叶逆变换即结果 %%%
WN_nk_n = zeros(N)+WN;  % WN_kn矩阵(初始)
E_n = zeros(N);   % 辅助的E(WN_kn的幂,单独拿出来算)

for row = 0:N-1
    for cow = 0:N-1
        E_n(row+1,cow+1) = -row*cow;
        WN_nk_n(row+1,cow+1) = WN_nk_n(row+1,cow+1)^E_n(row+1,cow+1);
    end
end

fprintf('傅里叶逆变换:\n')
xk_n = real((WN_nk_n * Xk)/N)'


        