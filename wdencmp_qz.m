% ȥ�뺯��2: wdencmp  (��wden��һ����)  
% wdencmp�еĲ����ܶ�ʱddencmp���ģ�����: thr��sorh��keepapp

clear; clc;

% �����ź�
load leleccum;
% ������
s = leleccum(300:2000);

% ԭʼ�ź�ͼ��:
figure(1);
plot(s);
xlabel('������'); ylabel('���');
grid on;
title('ԭʼ�ź�');

% ��ԭʼ�ź���С����3���ֽ�, ����ϵ����ȡ:
[c,l] = wavedec(s,3,'db4');
a3 = appcoef(c,l,'db4',3);  % ��Ƶ���Ʋ���; 3�������
d3 = detcoef(c,l,3);
d2 = detcoef(c,l,2);
d1 = detcoef(c,l,1);

figure(2);
% ǿ��ȥ�봦��: ��Ƶ"ϵ��"ȫ���0, Ȼ�����ع�
dd3 = zeros(1,length(d3));
dd2 = zeros(1,length(d2));
dd1 = zeros(1,length(d1));
c1 = [a3 dd3 dd2 dd1];
s1 = waverec(c1,l,'db4');  % �ع�
subplot(2,2,1);
plot(s1);
xlabel('������'); ylabel('���');
grid on;
title('ǿ��ȥ�봦��');

% Ĭ����ֵȥ�봦��: ��ddencmp�����źŵ�Ĭ����ֵ, Ȼ����wdencmp��ȥ��
[thr,sorh,keepapp] = ddencmp('den','wv',s);
s2 = wdencmp('gbl', s, 'db4', 3, thr, sorh, keepapp);
subplot(2,2,2);
plot(s2);
xlabel('������'); ylabel('���');
grid on;
title('Ĭ����ֵȥ�봦��: wdencmp����');

% Ĭ����ֵȥ�봦��2: ��wden����(��ʵ��wdencmp��һ����, ֻ����wden��ȫ�Զ�һЩ)
s3 = wden(s,'minimaxi','s','mln',3,'db4');
subplot(2,2,3);
plot(s3);
xlabel('������'); ylabel('���');
grid on;
title('Ĭ����ֵȥ�봦��: wden����');

% ��Ϊ������ֵȥ�봦��: ��ֵ����Ϊ��, ��wthresh����: һ���Ƕ�ÿһ����Ƶ�ɷ�(ϵ��)������ֵ����
softd1 = wthresh(d1, 's', 10);  % 10�Ǵ��˸�����ֵ
softd2 = wthresh(d2, 's', 10);  
softd3 = wthresh(d3, 's', 25);
c2 = [a3 softd3 softd2 softd1];
s4 = waverec(c2,l,'db4');  % С���ع�
subplot(2,2,4);
plot(s4);
xlabel('������'); ylabel('���');
grid on;
title('��Ϊ������ֵȥ�봦��');



