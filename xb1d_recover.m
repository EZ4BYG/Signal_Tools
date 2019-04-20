clc ; clear;

fprintf('ԭʼ����Ϊ:\n');
% ÿ���޸������ԭʼ����, ���������2^n
% x = [9 7 3 5]
% x = [2 5 8 9 7 4 -1 1]
x = [2 5 8 9 7 4 -1 1 2 1 8 3 8 0 3 1]

order_max = log(length(x))/log(2);
fprintf('��ǰ�������ֽ�%d��\n',order_max);
order = double(input('�Զ���ֽ����order(<order_max):'));

% matlabĬ�ϵ�haarС��������:
low = [1/sqrt(2) 1/sqrt(2)];
high = [1/sqrt(2) -1/sqrt(2)];

% ���С��������:
% low = [1 1];
% high = [1 -1];

new = zeros(1,length(x));  % ����� ���� ��ֵ + ��ֵ
ave = zeros(1,length(x)/2);   % ��ֵ(��Ƶ)��¼
dec = zeros(1,length(x)/2);   % ��ֵ(��Ƶ)��¼


% С��ѭ���ֽⲿ��: ��ʵ���ǵ�ͨ�͸�ͨ2������ľ������ 
m = 1;
xtmp = x;
for norder = 1:order
    for n = 1:2:length(xtmp)
        ave(m) = sum(xtmp(n:n+1).*low);
        dec(m) = sum(xtmp(n:n+1).*high);
        m = m + 1;
    end
    % ����2��ĸ�ֵ����, �����ǴӺ���ǰ��ֵ��~
    % ������ĸ�Ƶ�Ͳ��ᶯ��; ����ĸ�Ƶ���´ξͻᱻ�Լ��ֽ���ĸ�Ƶ�͵�Ƶȡ����������Ӻ���ǰ��
    new( length(xtmp)/2+1:length(xtmp) ) = dec( 1:2^(order_max-norder) ); % ��¼ÿ�θ��µĸ�Ƶ����; 
    new( 1:length(xtmp)/2 ) = ave( 1:2^(order_max-norder) );              % ��¼ÿ�θ��µĵ�Ƶ���ݣ�
    xtmp = ave( 1:2^(order_max-norder) );
    m = 1;
end

fprintf('��д%d���ֽ���Ϊ:\n',order);
new


% С���ع���������haar������ȫ���ع���ȥ
% �����ϵ��: ��������й�
tmp1 = 1/( low(1) + high(1) );

% �����ع���ʼ:
xrec = zeros(1,length(new));  % ��¼��ԭ������
new_rec = new;

for norder = order_max+1-order : order_max  % �������������ͽ׶���������
    m = 1;  % ר��������¼"ǰ���"λ�á���������λ�õ�
    for n = 1:2^norder
        half = 2^norder/2;  % ��ǰ�ع������һ�롪��Ҳ������������λ�����õ�
        if mod(n,2) ~= 0  
            % ����ʱ����: 
            xrec(n) = tmp1*( new_rec(m) + new_rec(m+half) );   
            m = m + 1;
        else
            % ż��ʱ����: 
            xrec(n) = (new_rec(m-1) - low(1)*xrec(n-1))/low(2);       
        end
    end 
    new_rec(1:n) = xrec(1:n);  % ÿ��Ҫ���µ�(��һ���ع�����ǰһ�ν��): ��ǰ����
end

fprintf('%d���ֽ���ع�:\n',order);
new_rec


        
        