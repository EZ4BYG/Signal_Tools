%% ��Ŀ3: �Բ������dtΪ0.02s����Ӧ�ڲ���Ƶ��Ϊ50Hz�����ź�:
%% x(t) = 0.5*sin(2*pi*3*n*dt) + cos(2*pi*10*n*dt)�����������⣬����FFT; 
%% ��Ƶ��Ϊ8 ~ 15Hz�Ĳ���ȥ���ٰ��˲����Ƶ�����ź�IFFTת�ص�ʱ���򣬹۲�����
%% ����4��ͼ��ԭʼʱ���źš�ԭʼ��Ƶ���źš��˲�����Ƶ���źš��˲���ʱ���źš�

clc; clear;
N = input('��������ܵ���(N=2^n)��');  % �ܲ�������
dt = 0.02;  % ��Ӧ��ǰ�����fs = 1/dt = 50Hz
n = 0:N-1;  % ����������(��0��ʼ)
t = n*dt;   % ÿ���������Ӧ�Ĳ�����ʱ��
x = 0.5*sin(2*pi*3*t) + cos(2*pi*10*t); 
subplot(2,2,1), plot(t,x);
xlabel('������ʱ��'); ylabel('���'); title('ԭʼʱ���ź�'); grid on;  % ע������x���һ�����ʱ��

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
f = n/(N*dt);

subplot(2,2,3), plot(f(1:N/2),mag(1:N/2));  % ����Ҫ��Ƶ��ͼ
xlabel('Ƶ��/Hz'); ylabel('���'); title('ԭʼ��Ƶ���ź�'); grid on;

% �˲�: ��Ҫ��ȥ��Ƶ�ε����Ū��0����
f1 = 8; f2 = 15;
yy = zeros(1,length(Xk));  % �����Wkһ����������,���±��Ӧ
for m = 0:N-1              % ����ʱ���Ǵ�0ʱ��ʼ��; �����±��Ǵ�1��ʼ��
    if m/(dt*N) > f1 & m/(dt*N) < f2
        yy(m+1) = 0;       % Ҫ�˵�λ0
    else
        yy(m+1) = Xk(m+1);  % ���˵ı���ԭֵ
    end
end
maglb = abs(yy);

subplot(2,2,4), plot(f(1:N/2),maglb(1:N/2));  % ������΢ע��һ�¼���
xlabel('Ƶ��/Hz'); ylabel('���'); title('�˲�����Ƶ���ź�'); grid on;

% ���˲����Ƶ���ź�ifft��ʱ��
WN_nk_n = zeros(N)+WN;  % WN_kn����(��ʼ)
E_n = zeros(N); 

for row = 0:N-1
    for cow = 0:N-1
        E_n(row+1,cow+1) = -row*cow;
        WN_nk_n(row+1,cow+1) = WN_nk_n(row+1,cow+1)^E_n(row+1,cow+1);
    end
end

xk_n = real((WN_nk_n * yy')/N)';

subplot(2,2,2), plot(t,xk_n);
xlabel('������ʱ��'); ylabel('���'); title('�˲���ʱ���ź�'); grid on;