clc; clear;

% �ֶ�������ź�:
fprintf('ԭʼ�ź�Ϊ:\n');
a = [2,1,2,1,6,2,8,9]
b = [3,4,2,4,3,5,1,8]
N = length(a);

% ������ɵ��ź�:
% N = input('�����������:')
% fprintf('ԭʼ�ź�Ϊ:\n');
% a = randi([-N*2,N*2],1,N)
% b = randi([-N*2,N*2],1,N)

WN = exp(-i*2*pi/N);    % ����
WN_nk_a = zeros(N)+WN;  % a��WN_kn
WN_nk_b = zeros(N)+WN;  % b��WN_kn
xk_a = a';     % aʱ���ź����(�о���)
xk_b = b';     % bʱ���ź����(�о���)
E_a = zeros(N);   % a�ĸ�����E(WN_kn����,�����ó�����)
E_b = zeros(N);   % a�ĸ�����E(WN_kn����,�����ó�����)

%%% a,b�źŸ���Ҷ���任����� %%%
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

%%% T�ź�(ѭ�����)����Ҷ��任����� %%%
WN_nk_t = zeros(N)+WN;  % t��WN_kn
E_t = zeros(N);   % t�ĸ�����E(WN_kn����,�����ó�����)

for row = 0:N-1
    for cow = 0:N-1
        E_t(row+1,cow+1) = -row*cow;
        WN_nk_t(row+1,cow+1) = WN_nk_t(row+1,cow+1)^E_t(row+1,cow+1);
    end
end

fprintf('a,b�źŵ�ѭ��������Ϊ:\n');
xk_t = real((WN_nk_t * Xk_t)/N)'

