clc; clear;
% 从外部读取文件:
f_file = 'ceshi.txt';
fprintf('文件读取成功!原始数据为:\n')
data_org = load(f_file)';
[m,n] = size(data_org);
data = reshape(data_org, 1, m*n) % 把数据读到一行

num = 0;
N = length(data);
t = 0:N-1;
Xk = fft(data,N);  % fft计算

fprintf('离散傅里叶正变换:\n');
for num = 1:N
    if mod(num,4) == 0 && num ~= 0
        fprintf('X(%d): %f %fi\n', num-1, real(Xk(num)), imag(Xk(num)));
    else
        fprintf('X(%d): %f %fi\t', num-1, real(Xk(num)), imag(Xk(num)));
    end
end
fprintf('\n');
mag = abs(Xk);  % 模

fprintf('傅里叶逆变换:');
iXk = ifft(Xk)

% 画图:
figure(1);  % 时域图像
plot(t,data,'-o');
xlabel('采样时间点'); ylabel('振幅'); title('时域信号'); grid on;


