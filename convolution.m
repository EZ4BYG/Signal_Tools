a = [1 3 4 9 8 7];
b = [2 4 6 3];          % a*b  a在前b在后
a_length = length(a);
b_length = length(b);
r = zeros(1,a_length+b_length-1); % 记录卷积结果，总长度是a+b-1

for k = 1:a_length    % a做循环总长 因为a在前所以是a在移动
    c = a(k)*b;       % a所有的数都会和b数组所有元素乘一遍，但各自在r中起作用的位置不同
    
    d = r(k:k+b_length-1);  % r(k:k+wb-1)很妙！提取当前a(k)元素会影响的r的区间
    d = d+c;                % 把当前a(k)影响的范围"对应"加进去
    
    r(k:k+b_length-1) = d;  % 把r当前受影响的区域更新
end

fprintf('卷积结果为:')
r
