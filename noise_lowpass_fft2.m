clc; clear;

data = imread('zxc.jpg');  % ���ݡ�����ñȾ���˵ĳߴ��
data = im2double(data); 
data = rgb2gray(data);     % rgbתΪ�Ҷ�ͼ��
 data = imnoise(data, 'salt & pepper', 0.3);   % Ϊԭʼ���ݼ�����
% data = imnoise(data, 'gaussian', 0.2); 

figure(1);
imshow(data);
title('ԭʼͼ���������');

zidai = fft2(data);
zidai = fftshift(zidai);   % matlab�Դ������Ļ�����
% figure(2);
% imshow(log(abs(zidai) + 1),[]);  % һ��ֻҪʵ��
% title('�Դ���fft2���ɵ�"���Ļ�Ƶ��"ͼ��');

size_data = size(data);
M = size_data(1);  % ͼ(ԭʼ���ݾ���)�ĳ�
N = size_data(2);  % ͼ(ԭʼ���ݾ���)�Ŀ�

% ������˹��/��ͨ�˲���:
grade = 4;     % 4�װ�����˹�˲���
D0 = 150;      % ��ֹƵ��
center_M = fix(M/2);
center_N = fix(N/2);  % center_M��center_N��Ƶ���׾��ε�����
filter_lowpass = zeros(M,N);   % ��ͨ
filter_highpass = zeros(M,N);  % ��ͨ
% ��/��ͨ�˲���(����)����:
for m = 1:M
    for n = 1:N
        D = sqrt( (m-center_M)^2 + (n-center_N)^2 );  % D�Ǿ�Ƶ�ʾ������ĵľ���
        filter_lowpass(m,n) = 1/( 1 + (D/D0)^(2*grade) );
        % filter_highpass(m,n) = 1/( 1 + (D0/D)^(2*grade) );  % ע��ߵ�ͨ������
    end
end

lowpass_zidai = filter_lowpass.*zidai;  % ��ͨ�˲����������µ�Ƶ������
lowpass_data = ifft2(lowpass_zidai);
figure(3);
imshow(abs(lowpass_data));
title('"��������"��ά����Ҷ�任������˹��ͨ�˲����');
        


