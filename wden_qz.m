% 去噪函数1: wden
% 常用完整语法: [XD,CXD,LXD] = wden(X, TRTR, SORH, SCAL, N, 'wname');
% (1) 等号左边: X是原始信号；SORH软硬阈值(不是s就是h)；
% SCAL阈值尺度改变的比例(3种选择)：1. 'one'基本模式；2. 'sln'非白噪声模式；3.'mln'不同分解层次独立噪声估计
% TPTR是阈值选取规则(几个固定的)：1. 'rigrsure'; 2. 'sqtwolog'; 3. 'heursure'; 4. 'minimaxi'                                       
% N为小波分解层数；'wname'是选用的小波基
% (2) 等号左边: XD是去噪后的信号；CXD与LXD都是XD的结构，一般左边只要X就够了。

clear; clc;

t = 0:1000;
s = cos(0.03*t);
subplot(3,1,1);
plot(s);
xlabel('采样点'); ylabel('振幅'); grid on;
title('原始信号');

% 噪声信号
load noissin;
ns = noissin;
subplot(3,1,2);
plot(ns);
xlabel('采样点'); ylabel('振幅'); grid on;
title('受污染信号');

% 去噪
xd = wden(ns,'minimaxi','s','mln',4,'db4');
subplot(3,1,3);
plot(xd);
xlabel('采样点'); ylabel('振幅'); grid on;
title('去噪信号');