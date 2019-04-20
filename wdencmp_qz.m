% 去噪函数2: wdencmp  (和wden是一样的)  
% wdencmp中的参数很多时ddencmp给的！例如: thr、sorh、keepapp

clear; clc;

% 加载信号
load leleccum;
% 采样点
s = leleccum(300:2000);

% 原始信号图像:
figure(1);
plot(s);
xlabel('采样点'); ylabel('振幅');
grid on;
title('原始信号');

% 对原始信号做小波的3级分解, 并做系数提取:
[c,l] = wavedec(s,3,'db4');
a3 = appcoef(c,l,'db4',3);  % 低频近似部分; 3代表层数
d3 = detcoef(c,l,3);
d2 = detcoef(c,l,2);
d1 = detcoef(c,l,1);

figure(2);
% 强制去噪处理: 高频"系数"全搞成0, 然后再重构
dd3 = zeros(1,length(d3));
dd2 = zeros(1,length(d2));
dd1 = zeros(1,length(d1));
c1 = [a3 dd3 dd2 dd1];
s1 = waverec(c1,l,'db4');  % 重构
subplot(2,2,1);
plot(s1);
xlabel('采样点'); ylabel('振幅');
grid on;
title('强制去噪处理');

% 默认阈值去噪处理: 用ddencmp给出信号的默认阈值, 然后用wdencmp做去噪
[thr,sorh,keepapp] = ddencmp('den','wv',s);
s2 = wdencmp('gbl', s, 'db4', 3, thr, sorh, keepapp);
subplot(2,2,2);
plot(s2);
xlabel('采样点'); ylabel('振幅');
grid on;
title('默认阈值去噪处理: wdencmp函数');

% 默认阈值去噪处理2: 用wden函数(其实和wdencmp是一样的, 只不过wden更全自动一些)
s3 = wden(s,'minimaxi','s','mln',3,'db4');
subplot(2,2,3);
plot(s3);
xlabel('采样点'); ylabel('振幅');
grid on;
title('默认阈值去噪处理: wden函数');

% 人为给定阈值去噪处理: 阈值纯人为给, 用wthresh函数: 一般是对每一个高频成分(系数)都做阈值处理
softd1 = wthresh(d1, 's', 10);  % 10是纯人给的阈值
softd2 = wthresh(d2, 's', 10);  
softd3 = wthresh(d3, 's', 25);
c2 = [a3 softd3 softd2 softd1];
s4 = waverec(c2,l,'db4');  % 小波重构
subplot(2,2,4);
plot(s4);
xlabel('采样点'); ylabel('振幅');
grid on;
title('人为给定阈值去噪处理');



