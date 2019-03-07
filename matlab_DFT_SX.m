clc; clear;
% ���ⲿ��ȡ�ļ�:
f_file = 'ceshi.txt';
fprintf('�ļ���ȡ�ɹ�!ԭʼ����Ϊ:\n');
data_org = load(f_file)';
[m,n] = size(data_org);
data = reshape(data_org, 1, m*n) % �����ݶ���һ��

N = length(data);     % W������N*N

WN = exp(-i*2*pi/N);  % ����
WN_nk = zeros(N)+WN;  % WN_kn����(��ʼ)
xk = data';     % ʱ���ź����(�о���)
E = zeros(N);   % ������E(WN_kn����,�����ó�����)

%%% ����Ҷ���任����� %%%
for row = 0:N-1
    for cow = 0:N-1
        E(row+1,cow+1) = row*cow;
        WN_nk(row+1,cow+1) = WN_nk(row+1,cow+1)^E(row+1,cow+1);
    end
end

Xk = WN_nk * xk;

fprintf('����Ҷ���任:\n')
for num = 1:N
    if mod(num,4) == 0 && num ~= 0
        fprintf('X(%d): %f %fi\n', num-1, real(Xk(num)), imag(Xk(num)));
    else
        fprintf('X(%d): %f %fi\t', num-1, real(Xk(num)), imag(Xk(num)));
    end
end
fprintf('\n');

%%% ����Ҷ��任����� %%%
WN_nk_n = zeros(N)+WN;  % WN_kn����(��ʼ)
E_n = zeros(N);   % ������E(WN_kn����,�����ó�����)

for row = 0:N-1
    for cow = 0:N-1
        E_n(row+1,cow+1) = -row*cow;
        WN_nk_n(row+1,cow+1) = WN_nk_n(row+1,cow+1)^E_n(row+1,cow+1);
    end
end

fprintf('����Ҷ��任:\n')
xk_n = real((WN_nk_n * Xk)/N)'


        