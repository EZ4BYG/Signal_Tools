% 非主函数: 判断当前函数是否为imf —— 零点个数与极值点个数对比
function u = isimf(x)

N = length(x);
u1 = sum( x(1:N-1).*x(2:N) < 0 );  % 零点个数
u2 = peaks(x) + peaks(-x);  % 极大值 + 极小值总点数

if abs(u2-u1) > 1
    u = 0;  % 不是imf函数
else
    u = 1;  % 是imf函数
end
