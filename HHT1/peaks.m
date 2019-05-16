% 非主函数: 求极值点个数
% 注意: 若要极大值点数直接输入x，若要极小值则输入-x
function n = peaks(x)

[value,local] = findpeaks(x);

n = length(local);  % 只要极值点个数