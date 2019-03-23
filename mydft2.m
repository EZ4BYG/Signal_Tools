clc; clear;

data = imread('zxc.jpg');  % ���ݡ�����ñȾ���˵ĳߴ��
data = im2double(data); 
data = rgb2gray(data);     % rgbתΪ�Ҷ�ͼ��
% subplot(1,3,1);
% imshow(data);
title('ԭʼͼ��')

zidai = fft2(data);
%subplot(1,3,2);
figure(3)
imshow(real(zidai));  % һ��ֻҪʵ��
title('�Դ���fft2���ɵ�"Ƶ��"ͼ��');

size_data = size(data);
M = size_data(1);  % ͼ(ԭʼ���ݾ���)�ĳ�
N = size_data(2);  % ͼ(ԭʼ���ݾ���)�Ŀ�

% �����Ǹ���Ҷ���任�ر���һЩ����:
Wm = exp(-j*2*pi/M);
Wn = exp(-j*2*pi/N); % ��ͬG���ò�ͬ��W
Em = zeros(M);
En = zeros(N);     % E�Ǹ����������
Gm = zeros(M)+Wm;
Gn = zeros(N)+Wn;  % G�Ǽ���ʱҪ�õľ���
F = zeros(M,N);    % F��ת����Ƶ��Ľ��

% ��Gm�ļ���: ѭ������ΪM
fprintf('��ά��ɢ����Ҷ�任��ʼ:\n');
for row = 0:M-1
    for col = 0:M-1
        Em(row+1,col+1) = row * col;
        Gm(row+1,col+1) = Gm(row+1,col+1)^Em(row+1,col+1);
    end
end
% ��Gn�ļ���: ѭ������ΪN
for row = 0:N-1
    for col = 0:N-1
        En(row+1,col+1) = row * col;
        Gn(row+1,col+1) = Gn(row+1,col+1)^En(row+1,col+1);
    end
end

F = real(Gm*data*Gn);  % F = Gm*f*Gn�Ǽ��㹫ʽ��һ��ֻҪʵ��
% subplot(1,3,3);
% imshow(F);
title('��д��myfft2���ɵ�"Ƶ��"ͼ��');

error = sum(sum((real(F)-real(zidai)).^2));
if error < 10^(-10)
    fprintf('�Դ�����д���һ��!\n');
else
    fprintf('��һ��!\n');
end



        
