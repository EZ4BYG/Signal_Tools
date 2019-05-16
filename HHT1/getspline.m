% 非主函数: 获得数据的极大值、极小值包络线(三次样条插值后的数据)
function s = getspline(x,t)

N = length(x);

[value,local] = findpeaks(x);

% 原始插值点: 极值点
t1 = t(local);
x1 = x(local);

s = spline(t1,x1,t);
