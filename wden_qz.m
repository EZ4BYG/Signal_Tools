% ȥ�뺯��1: wden
% ���������﷨: [XD,CXD,LXD] = wden(X, TRTR, SORH, SCAL, N, 'wname');
% (1) �Ⱥ����: X��ԭʼ�źţ�SORH��Ӳ��ֵ(����s����h)��
% SCAL��ֵ�߶ȸı�ı���(3��ѡ��)��1. 'one'����ģʽ��2. 'sln'�ǰ�����ģʽ��3.'mln'��ͬ�ֽ��ζ�����������
% TPTR����ֵѡȡ����(�����̶���)��1. 'rigrsure'; 2. 'sqtwolog'; 3. 'heursure'; 4. 'minimaxi'                                       
% NΪС���ֽ������'wname'��ѡ�õ�С����
% (2) �Ⱥ����: XD��ȥ�����źţ�CXD��LXD����XD�Ľṹ��һ�����ֻҪX�͹��ˡ�

clear; clc;

t = 0:1000;
s = cos(0.03*t);
subplot(3,1,1);
plot(s);
xlabel('������'); ylabel('���'); grid on;
title('ԭʼ�ź�');

% �����ź�
load noissin;
ns = noissin;
subplot(3,1,2);
plot(ns);
xlabel('������'); ylabel('���'); grid on;
title('����Ⱦ�ź�');

% ȥ��
xd = wden(ns,'minimaxi','s','mln',4,'db4');
subplot(3,1,3);
plot(xd);
xlabel('������'); ylabel('���'); grid on;
title('ȥ���ź�');