clc ; clear;

fprintf('原始数据为:\n');
% 每次修改这里的原始数据, 个数最好是2^n
% x = [9 7 3 5]
% x = [2 5 8 9 7 4 -1 1]
x = [2 5 8 9 7 4 -1 1 2 1 8 3 8 0 3 1]

order_max = log(length(x))/log(2);
fprintf('当前数据最多分解%d阶\n',order_max);
order = double(input('自定义分解阶数order(<order_max):'));

% matlab默认的haar小波基函数:
low = [1/sqrt(2) 1/sqrt(2)];
high = [1/sqrt(2) -1/sqrt(2)];

% 最简单小波基函数:
% low = [1 1];
% high = [1 -1];

new = zeros(1,length(x));  % 最后结果 —— 均值 + 差值
ave = zeros(1,length(x)/2);   % 均值(低频)记录
dec = zeros(1,length(x)/2);   % 差值(高频)记录


% 小波循环分解部分: 其实就是低通和高通2种情况的卷积计算 
m = 1;
xtmp = x;
for norder = 1:order
    for n = 1:2:length(xtmp)
        ave(m) = sum(xtmp(n:n+1).*low);
        dec(m) = sum(xtmp(n:n+1).*high);
        m = m + 1;
    end
    % 下面2句的赋值过程, 总体是从后往前赋值的~
    % 进入过的高频就不会动了; 进入的高频再下次就会被自己分解出的高频和低频取代——总体从后往前√
    new( length(xtmp)/2+1:length(xtmp) ) = dec( 1:2^(order_max-norder) ); % 记录每次更新的高频内容; 
    new( 1:length(xtmp)/2 ) = ave( 1:2^(order_max-norder) );              % 记录每次更新的低频内容；
    xtmp = ave( 1:2^(order_max-norder) );
    m = 1;
end

fprintf('手写%d级分解结果为:\n',order);
new


% 小波重构——任意haar基函数全能重构回去
% 计算的系数: 与基函数有关
tmp1 = 1/( low(1) + high(1) );

% 迭代重构开始:
xrec = zeros(1,length(new));  % 记录复原的数据
new_rec = new;

for norder = order_max+1-order : order_max  % 这个规律让任意低阶都可以适用
    m = 1;  % 专门用来记录"前半段"位置——给奇数位用的
    for n = 1:2^norder
        half = 2^norder/2;  % 当前重构区间的一半——也是用来给奇数位计算用的
        if mod(n,2) ~= 0  
            % 奇数时操作: 
            xrec(n) = tmp1*( new_rec(m) + new_rec(m+half) );   
            m = m + 1;
        else
            % 偶数时操作: 
            xrec(n) = (new_rec(m-1) - low(1)*xrec(n-1))/low(2);       
        end
    end 
    new_rec(1:n) = xrec(1:n);  % 每次要更新的(后一次重构基于前一次结果): 从前往后
end

fprintf('%d级分解后重构:\n',order);
new_rec


        
        