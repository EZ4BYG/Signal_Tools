clear ; clc;

x = xlsread('shuju.xlsx');
x = x(1001:1001+1023);  % ��Ч���ݳ�������2^n��������ȥ1024�����10��������0

N = length(x);
fs = 100;         % ����Ƶ�� = 1/�������
tt = (0:N-1)'/fs;  % ʱ��̶�

% ԭʼ�ź�ʱ��ͼ��:
figure(1);
subplot(2,1,1);
plot(tt,x);
xlabel('ʱ��/s'); ylabel('���'); title('ʱ��ԭʼ�ź�'); grid on;
axis([0 max(tt) -inf inf])
subplot(2,1,2);
n = 1:N;
plot(n,x);
xlabel('������'); ylabel('���'); title('ʱ��ԭʼ�ź�'); grid on;
axis([0 max(n) -inf inf]);


% ʱƵ����: �Ҿ���ʹ��127���ڵ�Ӧ������õģ�
figure(2);
h = hanning(63);  % 63���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
subplot(2,2,1); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % ��ֵ��ͼ
xlabel('ʱ��/ms');  ylabel('Ƶ��/Hz'); title('63�ڵ㺺����ʱƵͼ');
axis([0 N 0 15]);
grid on;

h = hanning(127); % 127���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
subplot(2,2,2); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % ��ֵ��ͼ
xlabel('ʱ��/ms');  ylabel('Ƶ��/Hz'); title('127�ڵ㺺����ʱƵͼ');
axis([0 N 0 15]);
grid on;

h = hanning(255); % 255���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
subplot(2,2,3); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % ��ֵ��ͼ
xlabel('ʱ��/ms');  ylabel('Ƶ��/Hz'); title('255�ڵ㺺����ʱƵͼ');
axis([0 N 0 15]);
grid on;

h = hanning(511); % 511���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
subplot(2,2,4); 
contour( t, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % ��ֵ��ͼ
xlabel('ʱ��/ms');  ylabel('Ƶ��/Hz'); title('511�ڵ㺺����ʱƵͼ');
axis([0 N 0 15]);
grid on;

% ������͵�2άͼ����ʾ:
figure(3);
h = hanning(127); % 127���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
mesh( tt, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) ); 
view(0,90); 
axis([0 max(tt) 0 15]);
xlabel('ʱ��/ms');  ylabel('Ƶ��/Hz'); title('127�ڵ㺺����ʱƵͼ(mesh��ά)');
colormap('HSV');
colorbar;
grid on;

% ��3άͼ��չʾ:
figure(4);
h = hanning(127); % 127���ڵ�ĺ�����
[tfr,t,f] = tfrstft(x,1:N,N,h);  % ����һ���������� 
mesh( tt, f(1:N/2)*fs*2, abs(tfr(1:N/2,:)) );  % 3ά��ʾ: ʱ�䡢Ƶ�ʡ����
xlabel('ʱ��/ms');  ylabel('Ƶ��/Hz'); zlabel('���'); title('127�ڵ㺺����ʱƵͼ(mesh��ά)');
axis([0 max(tt) -inf inf -inf inf]);
colormap('HSV');
colorbar;
grid on;

