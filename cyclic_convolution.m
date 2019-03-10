clc; clear;

% 手动输入的信号:
fprintf('原始信号为:\n');
a = [2,1,2,1,6,2,8,9]
b = [3,4,2,4,3,5,1,8]
N = length(a);

% 随机生成的信号:
% N = input('输入采样点数:')
% fprintf('原始信号为:\n');
% a = randi([-N*2,N*2],1,N)
% b = randi([-N*2,N*2],1,N)

WN = exp(-i*2*pi/N);    % 常数
WN_nk_a = zeros(N)+WN;  % a的WN_kn
WN_nk_b = zeros(N)+WN;  % b的WN_kn
xk_a = a';     % a时域信号振幅(列矩阵)
xk_b = b';     % b时域信号振幅(列矩阵)
E_a = zeros(N);   % a的辅助的E(WN_kn的幂,单独拿出来算)
E_b = zeros(N);   % a的辅助的E(WN_kn的幂,单独拿出来算)

%%% a,b信号傅里叶正变换即结果 %%%
for row = 0:N-1
    for cow = 0:N-1
        E_a(row+1,cow+1) = row*cow;
        E_b(row+1,cow+1) = row*cow;
        WN_nk_a(row+1,cow+1) = WN_nk_a(row+1,cow+1)^E_a(row+1,cow+1);
        WN_nk_b(row+1,cow+1) = WN_nk_b(row+1,cow+1)^E_b(row+1,cow+1);
    end
end

Xk_a = WN_nk_a * xk_a;
Xk_b = WN_nk_b * xk_b;

Xk_t = Xk_a.*Xk_b;

%%% T信号(循环卷积)傅里叶逆变换即结果 %%%
WN_nk_t = zeros(N)+WN;  % t的WN_kn
E_t = zeros(N);   % t的辅助的E(WN_kn的幂,单独拿出来算)

for row = 0:N-1
    for cow = 0:N-1
        E_t(row+1,cow+1) = -row*cow;
        WN_nk_t(row+1,cow+1) = WN_nk_t(row+1,cow+1)^E_t(row+1,cow+1);
    end
end

fprintf('a,b信号的循环卷积结果为:\n');
xk_t = real((WN_nk_t * Xk_t)/N)'

