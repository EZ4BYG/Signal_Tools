clc; clear;

% x = [1 1 1;1 -7 1;1 1 1];      % "ǿ��Ե��"�����
x = [-1 -1 0;-1 0 1;0 1 1];    % "����"�����
% x = [-1 -1 -1 -1 0;-1 -1 -1 0 1;-1 -1 0 1 1;-1 0 1 1 1;0 1 1 1 1];  % "���Ÿ���"�����
% x = [-1 -1 -1;-1 8 -1;-1 -1 -1];   % ȫ�����Ե��ȡ
% x = [0 0 -1 0 0;0 0 -1 0 0;0 0 4 0 0;0 0 -1 0 0;0 0 -1 0 0];  % "�����Ե���"�����
% x = [3 0 0 0 0;0 -1 0 0 0;0 0 -1 0 0;0 0 0 -1 0;0 0 0 0 -1];  % "��Ե�ڻ�"�����
% x = [0 0 1 0 0;0 0 1 0 0;1 1 -10 1 1;0 0 1 0 0;0 0 1 0 0];    % "��Ե�ǳ��ڻ�"�����
% x = [1 1 1;1 1 1;1 1 1];  % ����

data = imread('zxc.jpg');  % ���ݡ�����ñȾ���˵ĳߴ��
figure(1);
imshow(data)
data = double(data);
% zidai = conv3(data,x,'same');  û���Դ���3ά���

x = rot90(rot90(x));  % �µľ����

% �˵ĳߴ�
size_x = size(x);
row_x = size_x(1);  % �˵�����
col_x = size_x(2);  % �˵�����
% ���ݵĳߴ�
layer = data(:,:,1);      % ÿһ��ĳߴ綼��һ����
size_data = size(layer);
row_data = size_data(1);  % ���ݵ�����
col_data = size_data(2);  % ���ݵ�����

% �˵�����Ԫ��:
centerx_row = round(row_x/2);
centerx_col = round(col_x/2);
centerx = x(centerx_row,centerx_col);

% ��ԭʼ��������: 0ֵ��ܴ�Ҷ�һ��
data_tmp1 = zeros(row_data+row_x-1,col_data+row_x-1); 
data_tmp2 = zeros(row_data+row_x-1,col_data+row_x-1);
data_tmp3 = zeros(row_data+row_x-1,col_data+row_x-1);  % ÿ���³ߴ�:����,��Ҷ�һ��

% ��ֵҪ��: ÿһ�㸳��ͬ���Ӧ��ֵ
data_tmp1(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1) = data(:,:,1);
data_tmp2(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1) = data(:,:,2);
data_tmp3(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1) = data(:,:,3); 

% ���ߺ�ÿ��������: ����һ��
data_k1 = data_tmp1;
data_k2 = data_tmp2;
data_k3 = data_tmp3;  

% ���ߺ������ݾ���ߴ�: ÿ����һ����,��һ��ľ���
size_data_k = size(data_k1);
row_data_k = size_data_k(1);
col_data_k = size_data_k(2);

% ��¼ÿ������Ľ��: �����ͬ,�ֿ���¼
result1 = zeros(row_data_k,col_data_k);
result2 = zeros(row_data_k,col_data_k);
result3 = zeros(row_data_k,col_data_k);

% ��ʼ�������: m n �������ݾ������������
% һ������������1
for m = centerx_row:centerx_row+row_data-1
    for n = centerx_row:centerx_row+col_data-1
        % ttn����ʱ�����˴�С��ͬ�������еĲ��־���: ÿ����ֵ��һ��,Ҫ�ֿ���¼
        tt1 = data_k1(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_row-1):n+(centerx_row-1));
        tt2 = data_k2(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_row-1):n+(centerx_row-1));
        tt3 = data_k3(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_row-1):n+(centerx_row-1));
        % juan���м�ÿһ�ξ��������͵��м���: ÿ������һ��,Ҫ�ֿ���¼
        juan1 = sum(x.*tt1);
        juan2 = sum(x.*tt2);
        juan3 = sum(x.*tt3);
        % ÿһ�����ļ�¼: �ֱ��¼����ͬ�ľ�����
        result1(m,n) = sum(juan1(:));
        result2(m,n) = sum(juan2(:));
        result3(m,n) = sum(juan3(:));
    end
end

% ȥ��֮ǰ���ߵ�0: ��ȥ����
result1 = result1(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);
result2 = result2(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);
result3 = result3(centerx_row:centerx_row+row_data-1,centerx_row:centerx_row+col_data-1);

% 3��ͼ��ϲ���ԭͼ
result = cat(3,result1,result2,result3);

figure(2);
imshow(result);
