clear; clc;

% tp�任����ÿ��������ߵ�"б��+�ؾ�"
% Ҫ��: ԭ�źŵĸ���"�������ʽ"Ҫ��֪��
% �ر�: ֱ�ߵ�бʽ���� --> y��y1 = k(x��x1) --> y = kx + (y1 - kx1)

% ֱ���ź�1: y1 = 2x + 3
% ֱ���ź�2: y2 = 4x + 1
% ˫�����ź�3: x^2/a^2 - y^2/b^2 = 1 --> y = sqrt(b^2*(x^2/a^2 - 1))
a = 2 ; b = 6;  % ˫���߲���

% ʱ����
figure(1);

x1 = 0:0.1:10;
y1 = 2*x1 + 3;
y2 = 4*x1 + 1;
y3 = x1.^2 + 10;
plot(x1,y1,'b'); hold on;
plot(x1,y2,'m'); hold on;
plot(x1,y3,'y'); hold on;

x2 = a:0.1:10;
y4 = sqrt(b^2*(x2.^2/a^2 - 1));
plot(x2,y4,'r'); 

xlabel('�ر����x(m)'); ylabel('����ʱ��t(s)'); title('ʱ����'); grid on; 
legend('y=2x+3', 'y=4x+1', 'y=x^2+10', 'y=sqrt(b^2*(x^2/a^2-1))','location','northeast');
axis([0 10 0 45]);
set(gca,'xaxislocation','top');  % ��x�ỻ���Ϸ�
set(gca,'ydir','reverse');       % ��y��̶ȵ���


% tp�任: 
syms x;

yy1 = 2*x + 3;
yy2 = 4*x + 1;
yy3 = x^2 + 10;
yy4 = sqrt(b^2*(x^2/a^2 - 1));
    
% ԭ�ź�Ϊֱ�ߺ���: б�� + �ؾ�
k1 = diff(yy1, x, 1); b1 = 3;
k2 = diff(yy2, x, 1); b2 = 1;  
% ԭ�ź�Ϊ���ߺ���: б��
k3 = diff(yy3, x, 1); 
k4 = diff(yy4, x, 1);

% ǰ3���źŵ�tp��ת��:
x = 0:0.1:10;
yy1_val = double(subs(yy1));  % �ź�1��ÿ�����������
t1 = double(subs(k1));      % �ź�1��ÿ�������ߴ���б��/��
yy2_val = double(subs(yy2));  % �ź�2��ÿ�����������
t2 = double(subs(k2));      % �ź�2��ÿ�������ߴ���б��/��
yy3_val = double(subs(yy3));  % �ź�3��ÿ�����������
t3 = double(subs(k3));      % �ź�3��ÿ�������ߴ���б��/��
% ���ߵ�бʽ����: y = kx + (y1 - kx1) --> b = y1 - kx1
p1 = yy1_val - t1.*x;  % �ź�1��ÿ�������ߴ��Ľؾ�/p
p2 = yy2_val - t2.*x;  % �ź�2��ÿ�������ߴ��Ľؾ�/p
p3 = yy3_val - t3.*x;  % �ź�3��ÿ�������ߴ��Ľؾ�/p

% ��4���źŵ�tp��ת��: 
x = b:0.1:10;
yy4_val = double(subs(yy4));
t4 = double(subs(k4));
p4 = yy4_val - t4.*x;

figure(2);
h1 = plot(t1,p1,'b*'); hold on;
h2 = plot(t2,p2,'m*'); hold on;
h3 = scatter(t3,p3,'yo','fill'); hold on;
h4 = scatter(t4,p4,'ro','fill');

xlabel('����б��t'); ylabel('���߽ؾ�p'); title('tp��'); grid on; 
axis([0 10 -30 10]);
legend([h1(1),h2(1),h3(1),h4(1)],'y=2x+3','y=4x+1', 'y=x^2+10','y=sqrt(b^2*(x^2/a^2-1))','location','southeast');
set(gca,'xaxislocation','top');  % ��x�ỻ���Ϸ�




