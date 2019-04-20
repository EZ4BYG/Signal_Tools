clear all; clc;

N = 1024;  % �ܲ�����
fs = 1000;          % ����Ƶ��
t = (0:N-1)'/fs;   % ʱ��̶�
% �����ź�: ע��x��t����������
f1 = 400 ; f2 = 200 ; f3 = 100 ; f4 = 50 ;
x = sin(2*pi*f1*t).*(t<=0.3) + sin(2*pi*f2*t).*(t>0.3&t<=0.6) + ...
    sin(2*pi*f3*t).*(t>0.6&t<=0.8) + sin(2*pi*f4*t).*(t>0.8);

figure(1);
plot(t,x);
axis([0 max(t) -inf inf]); 
xlabel('ʱ��/s');
ylabel('���');
title('ԭʼʱ���ź�');

% ��ʱ����Ҷ�任����:
figure(2);

% ��Ϊtfr��Ƶ����������-0.5~0.5֮�䣬��˻ָ�"��ʵƵ��"��ʱ��Ҫx2
h = hanning(63);  % 63���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
subplot(2,2,1); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % ��ֵ��ͼ
xlabel('ʱ��/s');  ylabel('Ƶ��/Hz'); title('63�ڵ㺺����ʱƵͼ');
grid on;

h = hanning(127); % 127���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
subplot(2,2,2); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % ��ֵ��ͼ
xlabel('ʱ��/s');  ylabel('Ƶ��/Hz'); title('127�ڵ㺺����ʱƵͼ');
grid on;

h = hanning(255); % 255���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
subplot(2,2,3); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % ��ֵ��ͼ
xlabel('ʱ��/s');  ylabel('Ƶ��/Hz'); title('255�ڵ㺺����ʱƵͼ');
grid on;

h = hanning(511); % 511���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
subplot(2,2,4); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % ��ֵ��ͼ
xlabel('ʱ��/s');  ylabel('Ƶ��/Hz'); title('511�ڵ㺺����ʱƵͼ');
grid on;