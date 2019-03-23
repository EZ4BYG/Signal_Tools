% ��������fft2��д���Դ����һ�£�
% ifft2�������ֱ�����Դ���fft2�Ľ����
clc; clear;

data = imread('zxc.jpg');  % ���ݡ�����ñȾ���˵ĳߴ��
data = im2double(data); 
data = rgb2gray(data);     % rgbתΪ�Ҷ�ͼ��
subplot(1,3,1);
imshow(data);
title('ԭʼͼ��')

F = fft2(data);
subplot(1,3,2);
imshow(real(F));  % һ�㻭ͼֻҪʵ��, ��Ϊ����ʱʵ�鶼Ҫ����
title('�Դ���fft2���ɵ�"Ƶ��"ͼ��');

% s = ifft2(F);
% subplot(1,3,3);
% imshow(s);
% return;

size_data = size(F);
M = size_data(1);  % ͼ(ԭʼ���ݾ���)�ĳ�
N = size_data(2);  % ͼ(ԭʼ���ݾ���)�Ŀ�

% �����Ǹ���Ҷ��任�ر���һЩ����:
Wm = exp(-j*2*pi/M);
Wn = exp(-j*2*pi/N);  % ��ͬG���ò�ͬ��W
Em = zeros(M);
En = zeros(N);        % E�Ǹ����������
Gm = zeros(M)+Wm;
Gn = zeros(N)+Wn;  % G�Ǽ���ʱҪ�õľ���
f = zeros(M,N);    % F��ת����Ƶ��Ľ��

% ��Gm�ļ���: ѭ������ΪM
fprintf('��ά��ɢ������Ҷ�任��ʼ:\n');
for row = 0:M-1
    for col = 0:M-1
        Em(row+1,col+1) = -row * col;
        Gm(row+1,col+1) = Gm(row+1,col+1)^Em(row+1,col+1);
    end
end
Gm = Gm/M;
% ��Gn�ļ���: ѭ������ΪN
for row = 0:N-1
    for col = 0:N-1
        En(row+1,col+1) = -row * col;
        Gn(row+1,col+1) = Gn(row+1,col+1)^En(row+1,col+1);
    end
end
Gn = Gn/N;   % ע�⣺���/N�������/M��������G֮��ų��Եģ���Ϊ��������ʱ��������仯��

f = real(Gm*F*Gn);  % f = Gm*F*Gn�Ǽ��㹫ʽ��һ��ֻҪʵ��
subplot(1,3,3);
imshow(f);
title('��д��myidft2���ɵ�"ԭʼ"ͼ��');

error = sum(sum((real(f)-real(data)).^2));
if error < 10^(-10)
    fprintf('���任����ԭͼһ��!\n');
else
    fprintf('��һ��!\n');
end