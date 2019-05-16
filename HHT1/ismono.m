% 非主函数: 剩余信号的单调性判断(是否整个程序结束)
function u = ismono(x)

u1 = peaks(x)*peaks(-x);  

if u1 ~= 0
    u = 0;  % 非单调: 不存在极大值点或极小值点
else
    u = 1;  % 单调：有一个极值不是0，就不是单调的
end