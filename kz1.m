clear; clc;

% ԭʼ���ݳߴ�:
bc = 1;  % ������Χ����ı߳�(ÿ���޸�����)
x = [8 11 13 1 1;5 26 17 2 2;39 12 11 1 3]  % ԭʼ����(����ߴ����ֵ)
size_x = size(x);
rowx = size_x(1);
colx = size_x(2);

% ��չ��ߴ�:
kz = zeros(rowx+(rowx-1)*bc+bc*2,colx+(colx-1)*bc+bc*2); 
% ע����ʽ���ߵ�д����Ϊ�˱�֤ͨ����(�������߳��Ⱦ���ʵ��)
size_kz = size(kz);
rowkz = size_kz(1);
colkz = size_kz(2);

% ��ԭ��ֵ����Ӧλ�ò��ȥ:
countn = 1;
countm = 1; % �����еļ�����(�������)
mtmp = bc*countm;
ntmp = bc*countn; % ��������ʱ�����Ǽ�¼xԭ���ݵ����� 
for m = bc+1:bc+1:rowkz
    for n = bc+1:bc+1:colkz
        kz(m,n) = x(m-mtmp,n-ntmp);  % ��Ӧλ�ò��ȥ
        countn = countn + 1;
        ntmp = bc*countn;
    end
    countm = countm + 1;
    mtmp = bc*countm;
    % ����żǵûָ�(��Ϊ�е���һ�ֿ�ʼ��)
    countn = 1;
    ntmp = bc*countn;
end

kz