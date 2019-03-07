fs = 100;  % ����Ƶ��(��1.28s)
N = 256;   % ʱ�������ݵ���: fft����,һ��N����2^n
n = 0:N-1;   % ���
t = n/fs;    % ʱ������ÿ�����ʱ��

x = 0.5*sin(2*pi*15*t)+2*sin(2*pi*40*t); % �ź�
figure(1);
plot(n,x);
xlabel('���������'); ylabel('���ֵ'); title('ԭʼʱ���ź�: ��������N=128'); grid on;

% ���㲿��:
print('���㲿��');
y = fft(x,N);     % fft
mag = abs(y);     % ���Fourier�任������(������ģ)
f = n*fs/N;       % ��������: Ƶ������(�е�Ƶ��)

% ��ͼ����:
% ���"��Ƶ��(��Ƶ��)�仯�����"����x��Ƶ��,y�����
% subplot(2,2,1);
figure(2);
plot(f,mag);   
xlabel('Ƶ��/Hz'); ylabel('���'); title('Ƶ���źš�����Ƶ�������Ӧ'); grid on;

% ���NyquistƵ��֮ǰ��Ƶ�ʱ仯�����
% subplot(2,2,2);
figure(3);
f_int = f(1:N/2);     % ȡǰN/2��
mag_int = mag(1:N/2); 
plot(f_int,mag_int);  
xlabel('Ƶ��/Hz'); ylabel('���'); title('�ο�˹��Ƶ��֮ǰ����ԭƵ�������Ӧ'); grid on;
