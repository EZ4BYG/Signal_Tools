x = zeros(1,500);

% ���������
for t = 1:500
    if (t<200)
        x(t) = 50.*exp(t/300).*sin(2*pi*0.01*t);
    elseif (t>=200) & (t<300)
        x(t) = 50.*exp(t/300).*sin(2*pi*0.01*200) + 30;
    elseif (t>=300) & (t<400)
        x(t) = 50.*exp(t/300).*sin(2*pi*0.01*200) + 10;
    else
        x(t) = 50.*exp(t/300).*sin(2*pi*0.01*200) + 10 + 250*sin(2*pi*0.003*t);
    end
end

% һ���ֽ�: haar
% [cA1,cD1] = dwt(x,'haar');
% A1 = upcoef('a',cA1,'haar',1);
% D1 = upcoef('d',cD1,'haar',1);
% figure(1);
% subplot(1,3,1); plot(x); title('ԭʼ�ź�'); grid on;
% xlabel('������'); ylabel('���');
% subplot(1,3,2); plot(A1); title('ʱ��: ԭʼ�źŵ�Ƶ���Ʋ���(����һ��)'); grid on;
% xlabel('С����: x��y��������');
% subplot(1,3,3); plot(D1); title('ʱ��: ԭʼ�źŸ�Ƶϸ�ڲ���(����һ��)'); grid on;
% xlabel('С����: x��y��������');
% figure(2);
% plot(D1); title('��Ƶ�ɷ�ͻ�����'); grid on;

% �༶(3��)�ֽ�: db4
[C,L] = wavedec(x,3,'db4');
A3=wrcoef('a',C,L,'db4',3); % ��
D3=wrcoef('d',C,L,'db4',3);
D2=wrcoef('d',C,L,'db4',2);
D1=wrcoef('d',C,L,'db4',1); % 3����
figure(2)
subplot(2,2,1); plot(A3); title('ԭʼ�ź��еĵ�Ƶ�źųɷ�'); grid on;
xlabel('С����: x��y��������');
subplot(2,2,2); plot(D3); title('ԭʼ�ź��еĸ�Ƶ�źųɷ�1'); grid on;
xlabel('С����: x��y��������');
subplot(2,2,3); plot(D2); title('ԭʼ�ź��еĸ�Ƶ�źųɷ�2'); grid on;
xlabel('С����: x��y��������');
subplot(2,2,4); plot(D1); title('ԭʼ�ź��еĸ�Ƶ�źųɷ�3'); grid on;
xlabel('С����: x��y��������');
% suptitle('С�����ʱ��');