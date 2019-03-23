clc; clear;

% �����
k = [1 1 1;1 -8 1;1 1 1];      % "ǿ��Ե��"�����

data = imread('zxc.jpg');  % ���ݡ�����ñȾ���˵ĳߴ��
figure(1);
imshow(data);
data = double(data);
% ���������:
data1 = data(:,:,1);
data2 = data(:,:,2);
data3 = data(:,:,3);

% ��ά���:
result1 = conv2(data1, k, 'same');
result2 = conv2(data2, k, 'same');
result3 = conv2(data3, k, 'same');
result = cat(3, result1, result2, result3);
figure(2);
image(result);

% �������ʼ: ����Ͳ���, ������3��result
size_k = size(k);
bc = fix(size_k(1)/2)  % ������Χ����ı߳�
x = data1;
% x = [8 11 13 1 1 1 2;5 26 17 2 2 3 2;39 12 11 1 3 4 5]
size_x = size(x);
rowx = size_x(1);
colx = size_x(2);

% ��չ��ߴ�:
kz1 = zeros(rowx+(rowx-1)*bc+bc*2,colx+(colx-1)*bc+bc*2);
kz2 = zeros(rowx+(rowx-1)*bc+bc*2,colx+(colx-1)*bc+bc*2); 
kz3 = zeros(rowx+(rowx-1)*bc+bc*2,colx+(colx-1)*bc+bc*2); 
% ע����ʽ���ߵ�д����Ϊ�˱�֤ͨ����(�������߳��Ⱦ���ʵ��)
size_kz = size(kz1);
rowkz = size_kz(1);
colkz = size_kz(2);

% ��ԭ��ֵ����Ӧλ�ò��ȥ:
fprintf('������ر߿�ʼ:\n')
countn = 1;
countm = 1; % �����еļ�����(�������)
mtmp = bc*countm;
ntmp = bc*countn; % ��������ʱ�����Ǽ�¼xԭ���ݵ����� 
for m = bc+1:bc+1:rowkz
    for n = bc+1:bc+1:colkz
        kz1(m,n) = x(m-mtmp,n-ntmp);  % ��Ӧλ�ò��ȥ
        kz2(m,n) = x(m-mtmp,n-ntmp);
        kz3(m,n) = x(m-mtmp,n-ntmp);
        countn = countn + 1;
        ntmp = bc*countn;
    end
    countm = countm + 1;
    mtmp = bc*countm;
    % ����żǵûָ�(��Ϊ�е���һ�ֿ�ʼ��)
    countn = 1;
    ntmp = bc*countn;
end

% ���(������е�һ��):
fprintf('������о����ʼ:\n')
fresult1 = zeros(rowkz,colkz);
fresult2 = zeros(rowkz,colkz);
fresult3 = zeros(rowkz,colkz);
k = rot90(rot90(k));
for mm = bc+1:rowkz-bc
    for nn = bc+1:colkz-bc
        t1 = kz1(mm-bc:mm+bc,nn-bc:nn+bc);
        t2 = kz2(mm-bc:mm+bc,nn-bc:nn+bc);
        t3 = kz3(mm-bc:mm+bc,nn-bc:nn+bc);
        fjuan1 = sum(k.*t1);
        fjuan2 = sum(k.*t2);
        fjuan3 = sum(k.*t3);
        fresult1(mm,nn) = sum(fjuan1(:));
        fresult2(mm,nn) = sum(fjuan2(:));
        fresult3(mm,nn) = sum(fjuan3(:));
    end
end

fresult1 = fresult1(bc:rowkz-bc,bc:colkz-bc);
fresult2 = fresult2(bc:rowkz-bc,bc:colkz-bc);
fresult3 = fresult3(bc:rowkz-bc,bc:colkz-bc);

fresult = cat(3, fresult1, fresult2, fresult3);
figure(3);
imshow(fresult)





