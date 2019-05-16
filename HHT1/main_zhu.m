% ������: ����ģ̬�ֽ�

clear; clc;

x = xlsread('shuju.xlsx');
x = x(1001:1001+1023)';  % ��Ч���ݳ�������2^n��������ȡ1024�����10��������0
N = length(x);
fs = 100;          % ����Ƶ�� = 1/�������
t = (0:N-1)/fs;   % ʱ��̶�

imf = [];

num = 1;  % ������
xx = x;   % ����ԭʼ���ݱ���������
while ~ismono(xx)
    x1 = xx;
    sd = inf;  % ��sd��������ֵΪ0(<0.01)������
    % ��sd������<0.01����x1����imf����ʱ������while�ڲ�ѭ��
    while (sd > 0.01) || ~isimf(x1)
        s1 = getspline(x1,t);    % ����ֵ�����ֵ���
        s2 = -getspline(-x1,t);  % ��Сֵ�����ֵ���
        x2 = x1 - (s1+s2)/2;
        
        sd = sum( (x1-x2).^2 )/sum(x1.^2);
        x1 = x2;
    end
    
    imf(num,:) = x1;
    xx = xx - x1;
    num = num + 1;
end

imf(num,:) = xx;  % ���һ������Ҳ�Ž�ȥ


% ����ģ̬�ֽ���ĺ���(���һ��������)
figure(1);
merge = 0;
[row,col] = size(imf);
for n = 1:row
    % �Ѿ���ֽ�������ټ����� 
    merge = merge + imf(n,:);
    % ÿһ����ͼ
    subplot(row,1,n)
    plot(t,imf(n,:));
    axis([min(t) max(t) -inf inf]);
end
suptitle('����ģ̬�ֽ⺯��');

% ���ֽ�ϲ����Ա��Ƿ�һ��(һ��˵��û�ֽ��)
figure(2);
subplot(2,1,1);
plot(t,x);
axis([min(t) max(t) -inf inf]);
xlabel('������ʱ��'); ylabel('���'); title('ԭʼ����');

subplot(2,1,2);
plot(t,merge);
axis([min(t) max(t) -inf inf]);
xlabel('������ʱ��'); ylabel('���'); title('����ģ̬�ֽ���ֺϲ�������');


% ���ù����亯�������ϣ�������׷���:
[dA,df,t1] = hhspectrum(imf); 
[E,t2,Cenf] = toimage(dA,df); 

figure(3);
t2 = t2/fs;  % ת���ɲ�����ʱ��
Cenf = Cenf*1000; % ��1000�ָ���ʵ��Ƶ��ֵ(ԭʼ�ǹ�һ����ֵ)
gca = mesh(t2,Cenf,E);   
xlabel('������ʱ��(s)'); ylabel('���'); title('ϣ������-�Ʊ任ʱƵ��');
axis([0 max(t2) 0 100]);
view(0,90); 
colormap('HSV');
colorbar;





