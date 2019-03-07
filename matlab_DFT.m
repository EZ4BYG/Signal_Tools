clc; clear;
% ���ⲿ��ȡ�ļ�:
f_file = 'ceshi.txt';
fprintf('�ļ���ȡ�ɹ�!ԭʼ����Ϊ:\n')
data_org = load(f_file)';
[m,n] = size(data_org);
data = reshape(data_org, 1, m*n) % �����ݶ���һ��

num = 0;
N = length(data);
t = 0:N-1;
Xk = fft(data,N);  % fft����

fprintf('��ɢ����Ҷ���任:\n');
for num = 1:N
    if mod(num,4) == 0 && num ~= 0
        fprintf('X(%d): %f %fi\n', num-1, real(Xk(num)), imag(Xk(num)));
    else
        fprintf('X(%d): %f %fi\t', num-1, real(Xk(num)), imag(Xk(num)));
    end
end
fprintf('\n');
mag = abs(Xk);  % ģ

fprintf('����Ҷ��任:');
iXk = ifft(Xk)

% ��ͼ:
figure(1);  % ʱ��ͼ��
plot(t,data,'-o');
xlabel('����ʱ���'); ylabel('���'); title('ʱ���ź�'); grid on;


