% 主函数: 经验模态分解

clear; clc;

x = xlsread('shuju.xlsx');
x = x(1001:1001+1023)';  % 有效数据长必须是2^n，所以我取1024，最后10几个点是0
N = length(x);
fs = 100;          % 采样频率 = 1/采样间隔
t = (0:N-1)/fs;   % 时间刻度

imf = [];

num = 1;  % 计数器
xx = x;   % 代替原始数据被操作而已
while ~ismono(xx)
    x1 = xx;
    sd = inf;  % 用sd代替包络均值为0(<0.01)的条件
    % 当sd不满足<0.01，或x1不是imf函数时，进入while内层循环
    while (sd > 0.01) || ~isimf(x1)
        s1 = getspline(x1,t);    % 极大值包络插值结果
        s2 = -getspline(-x1,t);  % 极小值包络插值结果
        x2 = x1 - (s1+s2)/2;
        
        sd = sum( (x1-x2).^2 )/sum(x1.^2);
        x1 = x2;
    end
    
    imf(num,:) = x1;
    xx = xx - x1;
    num = num + 1;
end

imf(num,:) = xx;  % 最后一个余项也放进去


% 经验模态分解出的函数(最后一个是余项)
figure(1);
merge = 0;
[row,col] = size(imf);
for n = 1:row
    % 把经验分解的内容再加起来 
    merge = merge + imf(n,:);
    % 每一个画图
    subplot(row,1,n)
    plot(t,imf(n,:));
    axis([min(t) max(t) -inf inf]);
end
suptitle('经验模态分解函数');

% 将分解合并，对比是否一致(一致说明没分解错)
figure(2);
subplot(2,1,1);
plot(t,x);
axis([min(t) max(t) -inf inf]);
xlabel('采样点时间'); ylabel('振幅'); title('原始数据');

subplot(2,1,2);
plot(t,merge);
axis([min(t) max(t) -inf inf]);
xlabel('采样点时间'); ylabel('振幅'); title('经验模态分解后又合并的数据');


% 调用工具箱函数，完成希尔伯特谱分析:
[dA,df,t1] = hhspectrum(imf); 
[E,t2,Cenf] = toimage(dA,df); 

figure(3);
t2 = t2/fs;  % 转换成采样点时间
Cenf = Cenf*1000; % 乘1000恢复成实际频率值(原始是归一化的值)
gca = mesh(t2,Cenf,E);   
xlabel('采样点时间(s)'); ylabel('振幅'); title('希尔伯特-黄变换时频谱');
axis([0 max(t2) 0 100]);
view(0,90); 
colormap('HSV');
colorbar;





