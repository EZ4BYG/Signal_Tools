clc; clear;

% �����Դ���һ��һά��ѹ�ź�, ȡǰ4096����
load leleccum;
s = leleccum(1:4096);

% ��߶�/���ֽ�:
% ����: wavedec
[C,L]=wavedec(s,3,'db1');

% ϵ����ȡ: ��ȡ�����任֮����ź�: С�����µĵ�Ƶϵ��(������Ϣ)�͸�Ƶϵ��(ϸ���ź�), ��"ʱ���С����"!
% ˵��: ϵ����ȡ�Ƕ༶�ֽ���ã�1���ֽ��оͷֳ�2�����֣�����Ҫ��ȡ��
% ����: appcoef��Ƶϵ����ȡ; detcoef��Ƶϵ����ȡ
cA3=appcoef(C,L,'db1',3);  % ��: 3��ʾ������
cD3=detcoef(C,L,3); 
cD2=detcoef(C,L,2);
cD1=detcoef(C,L,1); % 3����: �������ֱ�ʾ���ǲ���
figure(1)
% 4�����ֳ��Ȳ�һ����
subplot(2,2,1); plot(cA3); title('3���ֽ��е�Ƶ���Ʋ���'); grid on;  % ���� 1/2^3 = 1/8
xlabel('С����: ����������ʵ������');
subplot(2,2,2); plot(cD3); title('3���ֽ��и�Ƶϸ�ڲ���'); grid on;  % ���� 1/2^3 = 1/8
xlabel('С����: ����������ʵ������');
subplot(2,2,3); plot(cD2); title('2���ֽ��и�Ƶϸ�ڲ���'); grid on;  % ���� 1/2^2 = 1/4
xlabel('С����: ����������ʵ������');
subplot(2,2,4); plot(cD1); title('1���ֽ��и�Ƶϸ�ڲ���'); grid on;  % ���� 1/2^1 = 1/2
xlabel('С����: ����������ʵ������');
suptitle('ʱ���С����');

% �༶�ع�ϵ��: ��С����ԭ���źŸ�Ƶ���ֵ����ź�, ����"С�����ʱ��"��
% ����: wrcoef  ������a�ǵ�Ƶ, d�Ǹ�Ƶ
A3=wrcoef('a',C,L,'db1',3); % ��
D3=wrcoef('d',C,L,'db1',3);
D2=wrcoef('d',C,L,'db1',2);
D1=wrcoef('d',C,L,'db1',1); % 3����
figure(2)
subplot(2,2,1); plot(A3); title('ԭʼ�ź��еĵ�Ƶ�źųɷ�'); grid on;
xlabel('������'); ylabel('���');
subplot(2,2,2); plot(D3); title('ԭʼ�ź��еĸ�Ƶ�źųɷ�1'); grid on;
xlabel('������'); ylabel('���');
subplot(2,2,3); plot(D2); title('ԭʼ�ź��еĸ�Ƶ�źųɷ�2'); grid on;
xlabel('������'); ylabel('���');
subplot(2,2,4); plot(D1); title('ԭʼ�ź��еĸ�Ƶ�źųɷ�3'); grid on;
xlabel('������'); ylabel('���');
suptitle('С�����ʱ��');

% �ع�ԭʼ�ź�: �˲��󵥴��Ļָ�ԭʼ�ź�
% ����: waverec
s_rec = waverec(C,L,'db1');
figure(3);
subplot(1,2,1); plot(s); title('ԭʼ�ź�'); grid on;
xlabel('������'); ylabel('���');
subplot(1,2,2); plot(s_rec); title('�ع�ԭʼ�ź�'); grid on;
xlabel('������'); ylabel('���');
suptitle('ʱ��ԭʼ���ع�ԭʼ�ź�');
