clc ; clear;

% 每次修改这里的原始数据, 个数最好是2^n
% x = [9 7 3 5];
 x = [2 5 8 9 7 4 -1 1];
% x = [2 5 8 9 7 4 -1 1 2 1 8 3 8 0 3 1];

order_max = log(length(x))/log(2);
fprintf('当前数据最多分解%d阶\n',order_max);
order = double(input('自定义分解阶数( order<order_max ):'));

% matlab默认的haar小波基函数:
low = [1/sqrt(2) 1/sqrt(2)];
high = [1/sqrt(2) -1/sqrt(2)];

% 最简单小波基函数:
% low = [0.5 0.5];
% high = [0.5 -0.5];

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
    % 进入过的高频就不会动了; 进入的低频再下次就会被自己分解出的高频和低频取代——总体从后往前√
    new( length(xtmp)/2+1:length(xtmp) ) = dec( 1:2^(order_max-norder) ); % 记录每次更新的高频内容; 
    new( 1:length(xtmp)/2 ) = ave( 1:2^(order_max-norder) );              % 记录每次更新的低频内容；
    xtmp = ave( 1:2^(order_max-norder) );
    m = 1;
end

fprintf('手写%d级分解结果为:\n',order);
new
 
fprintf('matlab自带%d级分解结果为:\n',order);
wavedec(x,order,'haar')

fprintf('自带的%d级重构结构:\n',order);
[C,S] = wavedec(x,order,'haar');
waverec(C,S,'haar')


    