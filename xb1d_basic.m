clc ; clear;

% ÿ���޸������ԭʼ����, ���������2^n
% x = [9 7 3 5];
 x = [2 5 8 9 7 4 -1 1];
% x = [2 5 8 9 7 4 -1 1 2 1 8 3 8 0 3 1];

order_max = log(length(x))/log(2);
fprintf('��ǰ�������ֽ�%d��\n',order_max);
order = double(input('�Զ���ֽ����( order<order_max ):'));

% matlabĬ�ϵ�haarС��������:
low = [1/sqrt(2) 1/sqrt(2)];
high = [1/sqrt(2) -1/sqrt(2)];

% ���С��������:
% low = [0.5 0.5];
% high = [0.5 -0.5];

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
    % ������ĸ�Ƶ�Ͳ��ᶯ��; ����ĵ�Ƶ���´ξͻᱻ�Լ��ֽ���ĸ�Ƶ�͵�Ƶȡ����������Ӻ���ǰ��
    new( length(xtmp)/2+1:length(xtmp) ) = dec( 1:2^(order_max-norder) ); % ��¼ÿ�θ��µĸ�Ƶ����; 
    new( 1:length(xtmp)/2 ) = ave( 1:2^(order_max-norder) );              % ��¼ÿ�θ��µĵ�Ƶ���ݣ�
    xtmp = ave( 1:2^(order_max-norder) );
    m = 1;
end

fprintf('��д%d���ֽ���Ϊ:\n',order);
new
 
fprintf('matlab�Դ�%d���ֽ���Ϊ:\n',order);
wavedec(x,order,'haar')

fprintf('�Դ���%d���ع��ṹ:\n',order);
[C,S] = wavedec(x,order,'haar');
waverec(C,S,'haar')


    