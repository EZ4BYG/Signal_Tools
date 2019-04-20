x = zeros(1,500);

% 待检测数据
for t = 1:500
    if (t<200)
        x(t) = 50.*exp(t/300).*sin(2*pi*0.01*t);
    elseif (t>=200) & (t<300)
        x(t) = 50.*exp(t/300).*sin(2*pi*0.01*200) + 30;
    elseif (t>=300) & (t<400)
        x(t) = 50.*exp(t/300).*sin(2*pi*0.01*200) + 10;
    else
        x(t) = 50.*exp(t/300).*sin(2*pi*0.01*200) + 10 + 250*sin(2*pi*0.003*t);
    end
end

% 一级分解: haar
% [cA1,cD1] = dwt(x,'haar');
% A1 = upcoef('a',cA1,'haar',1);
% D1 = upcoef('d',cD1,'haar',1);
% figure(1);
% subplot(1,3,1); plot(x); title('原始信号'); grid on;
% xlabel('采样点'); ylabel('振幅');
% subplot(1,3,2); plot(A1); title('时域: 原始信号低频近似部分(点数一样)'); grid on;
% xlabel('小波域: x和y轴无量纲');
% subplot(1,3,3); plot(D1); title('时域: 原始信号高频细节部分(点数一样)'); grid on;
% xlabel('小波域: x和y轴无量纲');
% figure(2);
% plot(D1); title('高频成分突变点检测'); grid on;

% 多级(3级)分解: db4
[C,L] = wavedec(x,3,'db4');
A3=wrcoef('a',C,L,'db4',3); % 低
D3=wrcoef('d',C,L,'db4',3);
D2=wrcoef('d',C,L,'db4',2);
D1=wrcoef('d',C,L,'db4',1); % 3个高
figure(2)
subplot(2,2,1); plot(A3); title('原始信号中的低频信号成分'); grid on;
xlabel('小波域: x和y轴无量纲');
subplot(2,2,2); plot(D3); title('原始信号中的高频信号成分1'); grid on;
xlabel('小波域: x和y轴无量纲');
subplot(2,2,3); plot(D2); title('原始信号中的高频信号成分2'); grid on;
xlabel('小波域: x和y轴无量纲');
subplot(2,2,4); plot(D1); title('原始信号中的高频信号成分3'); grid on;
xlabel('小波域: x和y轴无量纲');
% suptitle('小波域→时域');