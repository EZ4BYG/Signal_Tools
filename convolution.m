a = [1 3 4 9 8 7];
b = [2 4 6 3];          % a*b  a��ǰb�ں�
a_length = length(a);
b_length = length(b);
r = zeros(1,a_length+b_length-1); % ��¼���������ܳ�����a+b-1

for k = 1:a_length    % a��ѭ���ܳ� ��Ϊa��ǰ������a���ƶ�
    c = a(k)*b;       % a���е��������b��������Ԫ�س�һ�飬��������r�������õ�λ�ò�ͬ
    
    d = r(k:k+b_length-1);  % r(k:k+wb-1)�����ȡ��ǰa(k)Ԫ�ػ�Ӱ���r������
    d = d+c;                % �ѵ�ǰa(k)Ӱ��ķ�Χ"��Ӧ"�ӽ�ȥ
    
    r(k:k+b_length-1) = d;  % ��r��ǰ��Ӱ����������
end

fprintf('������Ϊ:')
r
