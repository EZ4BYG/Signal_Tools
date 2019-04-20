clc; clear;

% 导入自带的一个一维电压信号, 取前4096个点
load leleccum;
s = leleccum(1:4096);

% 多尺度/级分解:
% 命令: wavedec
[C,L]=wavedec(s,3,'db1');

% 系数提取: 提取经过变换之后的信号: 小波域下的低频系数(近似信息)和高频系数(细节信号), 即"时域→小波域"!
% 说明: 系数提取是多级分解才用！1级分解有就分成2个部分，不需要提取。
% 命令: appcoef低频系数提取; detcoef高频系数提取
cA3=appcoef(C,L,'db1',3);  % 低: 3表示第三层
cD3=detcoef(C,L,3); 
cD2=detcoef(C,L,2);
cD1=detcoef(C,L,1); % 3个高: 最后的数字表示的是层数
figure(1)
% 4个部分长度不一样！
subplot(2,2,1); plot(cA3); title('3级分解中低频近似部分'); grid on;  % 长度 1/2^3 = 1/8
xlabel('小波域: 横轴坐标无实际意义');
subplot(2,2,2); plot(cD3); title('3级分解中高频细节部分'); grid on;  % 长度 1/2^3 = 1/8
xlabel('小波域: 横轴坐标无实际意义');
subplot(2,2,3); plot(cD2); title('2级分解中高频细节部分'); grid on;  % 长度 1/2^2 = 1/4
xlabel('小波域: 横轴坐标无实际意义');
subplot(2,2,4); plot(cD1); title('1级分解中高频细节部分'); grid on;  % 长度 1/2^1 = 1/2
xlabel('小波域: 横轴坐标无实际意义');
suptitle('时域→小波域');

% 多级重构系数: 从小波域还原出信号高频部分的子信号, 即从"小波域→时域"！
% 命令: wrcoef  参数中a是低频, d是高频
A3=wrcoef('a',C,L,'db1',3); % 低
D3=wrcoef('d',C,L,'db1',3);
D2=wrcoef('d',C,L,'db1',2);
D1=wrcoef('d',C,L,'db1',1); % 3个高
figure(2)
subplot(2,2,1); plot(A3); title('原始信号中的低频信号成分'); grid on;
xlabel('采样点'); ylabel('振幅');
subplot(2,2,2); plot(D3); title('原始信号中的高频信号成分1'); grid on;
xlabel('采样点'); ylabel('振幅');
subplot(2,2,3); plot(D2); title('原始信号中的高频信号成分2'); grid on;
xlabel('采样点'); ylabel('振幅');
subplot(2,2,4); plot(D1); title('原始信号中的高频信号成分3'); grid on;
xlabel('采样点'); ylabel('振幅');
suptitle('小波域→时域');

% 重构原始信号: 滤波后单纯的恢复原始信号
% 命令: waverec
s_rec = waverec(C,L,'db1');
figure(3);
subplot(1,2,1); plot(s); title('原始信号'); grid on;
xlabel('采样点'); ylabel('振幅');
subplot(1,2,2); plot(s_rec); title('重构原始信号'); grid on;
xlabel('采样点'); ylabel('振幅');
suptitle('时域原始与重构原始信号');
