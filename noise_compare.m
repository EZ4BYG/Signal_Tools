clc; clear;

data = imread('rb.jpg');   % ���ݡ�����ñȾ���˵ĳߴ��
data = im2double(data);    % ԭͼ�������uint8����������ʱdouble ��Ҫתһ��

% rgbתΪ�Ҷ�ͼ��
data = rgb2gray(data);     % �������������
subplot(2,2,1)
imshow(data);
title('ԭʼ�Ҷ�ֵͼ��');

% ��˹����: ��ֵΪm������Ϊvar�ĸ�˹�����ӵ�ͼ����  varԽ��Խģ��
 noise_data = imnoise(data, 'gaussian', 0.02); 
% ��������: 0.1��ȫͼ10%�ĳ̶�����Ⱦ
% noise_data = imnoise(data, 'salt & pepper', 0.3);

% noise_data = im2double(noise_data);  % ����ǵ�Ҫ��תΪdouble����
subplot(2,2,2);
imshow(noise_data);
title('����"��˹/����"������ͼ��')

% ��ʼ����˲�:
x = zeros(5,5)+1;     % ����ˡ��������Ƿ�����Ϊ������/��
x = rot90(rot90(x));  % �µľ����

% �˵ĳߴ�
size_x = size(x);
row_x = size_x(1);  % �˵�����
col_x = size_x(2);  % �˵�����
% ���ݵĳߴ�
size_data = size(data);
row_data = size_data(1);  % ���ݵ�����
col_data = size_data(2);  % ���ݵ�����

% �˵�����Ԫ��:
centerx_row = round(row_x/2);
centerx_col = round(col_x/2);
centerx = x(centerx_row,centerx_col);

% ��ԭʼ��������:
data_tmp = zeros(row_data+row_x-1,col_data+row_x-1);
data_tmp(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1) = noise_data;
data_k = data_tmp;
% ���ߺ������ݾ���ߴ�:
size_data_k = size(data_k);
row_data_k = size_data_k(1);
col_data_k = size_data_k(2);

% m = centerx_row:row_data+row_x-2
% ��ʼ�������: m n �������ݾ������������
result_mean = zeros(row_data_k,col_data_k);
result_mid = zeros(row_data_k,col_data_k);
% m nһ������������1
for m = centerx_row:centerx_row+row_data-1
    for n = centerx_row:centerx_row+col_data-1
        % tt����ʱ�����˴�С��ͬ�������еĲ��־���:
        tt = data_k(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_row-1):n+(centerx_row-1));
        juan1 = mean(x.*tt);
        result_mean(m,n) = mean(juan1(:));
        juan2 = median(x.*tt);
        result_mid(m,n) = median(juan2(:));
    end
end

% ���֮ǰ���ߵ�0:
result_mean = result_mean(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);
result_mid = result_mid(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);

% ��ͼ:
subplot(2,2,3);
imshow(result_mean);
title('��ֵ�˲���ͼ��');
subplot(2,2,4);
imshow(result_mid);
title('��ֵ�˲���ͼ��');

% ����: ��˹�����þ�ֵ�˲��ã�������������ֵ�˲��á�