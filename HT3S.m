% ����ϣ�����ر任�õ�3˲����: ˲ʱ�����˲ʱ��λ��˲ʱƵ��(�������⣬���޸�)

clear ; clc;

x = xlsread('shuju.xlsx');
x = x(1001:1001+1023)';  % ��Ч���ݳ�������2^n��������ȥ1024�����10��������0
N = length(x);
fs = 100;          % ����Ƶ�� = 1/�������
tt = (0:N-1)/fs;  % ʱ��̶�

figure(1);
subplot(2,1,1);
plot(tt,x);
axis([min(tt) max(tt) -inf inf]);
xlabel('ʱ��'); ylabel('���'); title('ԭʼ�ź�');

% ����ֱ�����Դ��ı任������hilbert
h = hilbert(x);
imagh = imag(h);
subplot(2,1,2);
plot(tt,imagh);
axis([min(tt) max(tt) -inf inf]);
xlabel('ʱ��'); ylabel('���'); title('ϣ�����ر任���(��λ�ͺ�)');

figure(2);
% ˲ʱ���/����: 
dA = abs(h);
subplot(3,1,1);
plot(tt,dA,'r'); % �������ԭ�ź�
hold on;
plot(tt,x); % ԭ�ź�
axis([min(tt) max(tt) -inf inf]);
xlabel('ʱ��'); ylabel('˲ʱ���'); title('3˲-˲ʱ���');

% ˲ʱ��λ:
dfai = atan(imagh./x);
subplot(3,1,2);
plot(tt,dfai);
axis([min(tt) max(tt) -inf inf]);
xlabel('ʱ��'); ylabel('˲ʱ��λ'); title('3˲-˲ʱ��λ');

% ˲ʱƵ��: ��ɢ����ֻ����"���/�ݶ�"�����ƴ���
 df = gradient(dfai)./gradient(tt);  % �ݶȴ���
% df = diff(dfai)./diff(tt);  % ��ִ���

subplot(3,1,3);
plot(tt(1:length(df)),df);
axis([min(tt) max(tt) -inf inf]);
xlabel('ʱ��'); ylabel('˲ʱƵ��'); title('3˲-˲ʱƵ��');
    

