clc; clear;

% 导入自带的一个一维电压信号, 取前4096个点
load leleccum;
s = leleccum(1:4096);

% 一级"分解": 时域 → 小波域
% 说明: 2个"系数(低+高)"的尺寸全部是一半 2048
% 命令: dwt
[cA1,cD1] = dwt(s,'haar');
figure(1);
subplot(2,2,1); plot(cA1); title('小波域: 低频近似部分(点数少一半)'); grid on;
xlabel('小波域: 横轴坐标无实际意义');
subplot(2,2,2); plot(cD1); title('小波域: 高频细节部分(点数少一半)'); grid on;
xlabel('小波域: 横轴坐标无实际意义');

% 1级分解系数"重构": 小波域 → 时域
% 说明: 2个"子信号(低+高)"的尺寸全部和原始大小一样 4096！！
% 命令: upcoef
A1 = upcoef('a',cA1,'haar',1);
D1 = upcoef('d',cD1,'haar',1);
subplot(2,2,3); plot(A1); title('时域: 原始信号低频近似部分(点数一样)'); grid on;
xlabel('采样点'); ylabel('振幅');
subplot(2,2,4); plot(D1); title('时域: 原始信号高频细节部分(点数一样)'); grid on;
xlabel('采样点'); ylabel('振幅');

% 重构原始信号: 参数用的还是分解出的系数
% 命令: idwt
s_rec = idwt(cA1,cD1,'haar');
figure(2);
subplot(1,2,1); plot(s); title('原始时域信号: 4096个采样点'); grid on;
xlabel('采样点'); ylabel('振幅');
subplot(1,2,2); plot(s_rec); title('重构原始信号: 点数一样'); grid on;
xlabel('采样点'); ylabel('振幅');
suptitle('一维原始信号与重构原始信号');