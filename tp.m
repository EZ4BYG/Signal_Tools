clear; clc;

% tp变换就是每个点出切线的"斜率+截距"
% 要求: 原信号的各个"函数表达式"要已知！
% 必备: 直线点斜式方程 --> y－y1 = k(x－x1) --> y = kx + (y1 - kx1)

% 直线信号1: y1 = 2x + 3
% 直线信号2: y2 = 4x + 1
% 双曲线信号3: x^2/a^2 - y^2/b^2 = 1 --> y = sqrt(b^2*(x^2/a^2 - 1))
a = 2 ; b = 6;  % 双曲线参数

% 时间域
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

xlabel('地表捡波器x(m)'); ylabel('接收时间t(s)'); title('时间域'); grid on; 
legend('y=2x+3', 'y=4x+1', 'y=x^2+10', 'y=sqrt(b^2*(x^2/a^2-1))','location','northeast');
axis([0 10 0 45]);
set(gca,'xaxislocation','top');  % 把x轴换到上方
set(gca,'ydir','reverse');       % 把y轴刻度倒置


% tp变换: 
syms x;

yy1 = 2*x + 3;
yy2 = 4*x + 1;
yy3 = x^2 + 10;
yy4 = sqrt(b^2*(x^2/a^2 - 1));
    
% 原信号为直线函数: 斜率 + 截距
k1 = diff(yy1, x, 1); b1 = 3;
k2 = diff(yy2, x, 1); b2 = 1;  
% 原信号为曲线函数: 斜率
k3 = diff(yy3, x, 1); 
k4 = diff(yy4, x, 1);

% 前3个信号的tp域转换:
x = 0:0.1:10;
yy1_val = double(subs(yy1));  % 信号1中每个点的纵坐标
t1 = double(subs(k1));      % 信号1中每个点切线处的斜率/τ
yy2_val = double(subs(yy2));  % 信号2中每个点的纵坐标
t2 = double(subs(k2));      % 信号2中每个点切线处的斜率/τ
yy3_val = double(subs(yy3));  % 信号3中每个点的纵坐标
t3 = double(subs(k3));      % 信号3中每个点切线处的斜率/τ
% 切线点斜式方程: y = kx + (y1 - kx1) --> b = y1 - kx1
p1 = yy1_val - t1.*x;  % 信号1中每个点切线处的截距/p
p2 = yy2_val - t2.*x;  % 信号2中每个点切线处的截距/p
p3 = yy3_val - t3.*x;  % 信号3中每个点切线处的截距/p

% 第4个信号的tp域转换: 
x = b:0.1:10;
yy4_val = double(subs(yy4));
t4 = double(subs(k4));
p4 = yy4_val - t4.*x;

figure(2);
h1 = plot(t1,p1,'b*'); hold on;
h2 = plot(t2,p2,'m*'); hold on;
h3 = scatter(t3,p3,'yo','fill'); hold on;
h4 = scatter(t4,p4,'ro','fill');

xlabel('切线斜率t'); ylabel('切线截距p'); title('tp域'); grid on; 
axis([0 10 -30 10]);
legend([h1(1),h2(1),h3(1),h4(1)],'y=2x+3','y=4x+1', 'y=x^2+10','y=sqrt(b^2*(x^2/a^2-1))','location','southeast');
set(gca,'xaxislocation','top');  % 把x轴换到上方




