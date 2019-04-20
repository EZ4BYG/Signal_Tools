clc; clear;

% �����Դ���һ��һά��ѹ�ź�, ȡǰ4096����
load leleccum;
s = leleccum(1:4096);

% һ��"�ֽ�": ʱ�� �� С����
% ˵��: 2��"ϵ��(��+��)"�ĳߴ�ȫ����һ�� 2048
% ����: dwt
[cA1,cD1] = dwt(s,'haar');
figure(1);
subplot(2,2,1); plot(cA1); title('С����: ��Ƶ���Ʋ���(������һ��)'); grid on;
xlabel('С����: ����������ʵ������');
subplot(2,2,2); plot(cD1); title('С����: ��Ƶϸ�ڲ���(������һ��)'); grid on;
xlabel('С����: ����������ʵ������');

% 1���ֽ�ϵ��"�ع�": С���� �� ʱ��
% ˵��: 2��"���ź�(��+��)"�ĳߴ�ȫ����ԭʼ��Сһ�� 4096����
% ����: upcoef
A1 = upcoef('a',cA1,'haar',1);
D1 = upcoef('d',cD1,'haar',1);
subplot(2,2,3); plot(A1); title('ʱ��: ԭʼ�źŵ�Ƶ���Ʋ���(����һ��)'); grid on;
xlabel('������'); ylabel('���');
subplot(2,2,4); plot(D1); title('ʱ��: ԭʼ�źŸ�Ƶϸ�ڲ���(����һ��)'); grid on;
xlabel('������'); ylabel('���');

% �ع�ԭʼ�ź�: �����õĻ��Ƿֽ����ϵ��
% ����: idwt
s_rec = idwt(cA1,cD1,'haar');
figure(2);
subplot(1,2,1); plot(s); title('ԭʼʱ���ź�: 4096��������'); grid on;
xlabel('������'); ylabel('���');
subplot(1,2,2); plot(s_rec); title('�ع�ԭʼ�ź�: ����һ��'); grid on;
xlabel('������'); ylabel('���');
suptitle('һάԭʼ�ź����ع�ԭʼ�ź�');