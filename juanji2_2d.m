clc; clear;

x = rand(7,7);     % ����ˡ��������Ƿ�����Ϊ������/��
data = rand(8,7);  % ���ݡ�����ñȾ���˵ĳߴ��

zidai = conv2(data,x,'same')

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
data_tmp(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1) = data;
data_k = data_tmp;
% ���ߺ������ݾ���ߴ�:
size_data_k = size(data_k);
row_data_k = size_data_k(1);
col_data_k = size_data_k(2);

% m = centerx_row:row_data+row_x-2
% ��ʼ�������: m n �������ݾ������������
result = zeros(row_data_k,col_data_k);

for m = centerx_row:centerx_row+row_data-1
    for n = centerx_row:centerx_row+col_data-1
        % tt����ʱ�����˴�С��ͬ�������еĲ��־���:
        tt = data_k(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_row-1):n+(centerx_row-1));
        % juan���м�ÿһ�ξ��������͵��м���:
        juan = sum(x.*tt);
        result(m,n) = sum(juan(:));
    end
end

% ���֮ǰ���ߵ�0:
result = result(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1)
