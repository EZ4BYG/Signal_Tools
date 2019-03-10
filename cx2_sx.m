%% ��Ŀ2: ���ź�x(t) = sin(2*pi*40*t) + sin(2*pi*15*t)������Ƶ��Ϊ100Hz�������������⡣
%% �Ը��źŽ���FFT��Ȼ�������������FFT���������ԭʼ�źŽ��жԱȣ��Ƿ�һ����

clc; clear;
N = input('��������ܵ���(N=2^n)��');  % �ܲ�������
fs = 100;   % ����Ƶ��
n = 0:N-1;  % ����������(��0��ʼ)
t = n/fs;   % ÿ���������Ӧ�Ĳ�����ʱ��
x = sin(2*pi*40*t) + sin(2*pi*15*t); % ԭʼ�ź�(������ɢ��,ֻ�������˺�������)

% ����Ҷ�任ǰ��������:
WN = exp(-i*2*pi/N);  % ����
WN_nk = zeros(N)+WN;  % WN_kn����(��ʼ)
xk = x';     % ʱ���ź����(�о���)
E = zeros(N);   % ������E(WN_kn����,�����ó�����)

% ��ԭʼ�źŽ��и���Ҷ�任(�ֶ�����Ҷ�任):
for row = 0:N-1
    for cow = 0:N-1
        E(row+1,cow+1) = row*cow;
        WN_nk(row+1,cow+1) = WN_nk(row+1,cow+1)^E(row+1,cow+1);
    end
end

Xk = WN_nk * xk;
mag = abs(Xk);
f = n*fs/N;

% ����Ҷ��任ǰ��������:
WN_nk_n = zeros(N)+WN;  % WN_kn����(��ʼ)
E_n = zeros(N); 

for row = 0:N-1
    for cow = 0:N-1
        E_n(row+1,cow+1) = -row*cow;
        WN_nk_n(row+1,cow+1) = WN_nk_n(row+1,cow+1)^E_n(row+1,cow+1);
    end
end

xk_n = real((WN_nk_n * Xk)/N)';  % �ָ���ʱ���ź�

% ��ͼ����:
subplot(1,3,1), plot(t,x); % x����ʱ��
xlabel('������ʱ��(s)'); ylabel('���'); title('ԭʼʱ���ź�'); grid on;

subplot(1,3,2), plot(f(1:N/2),mag(1:N/2));  % ֱ������Ƶ(ֱ�����滻��)
xlabel('Ƶ��/Hz'); ylabel('���'); title('��-���Ƶ��ͼ'); grid on;

subplot(1,3,3), plot(t,xk_n);   % ifft���ʱ���ź�
xlabel('������ʱ��(s)'); ylabel('���'); title('ifft��ʱ���ź�'); grid on;