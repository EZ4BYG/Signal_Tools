% ��������: �жϵ�ǰ�����Ƿ�Ϊimf ���� �������뼫ֵ������Ա�
function u = isimf(x)

N = length(x);
u1 = sum( x(1:N-1).*x(2:N) < 0 );  % ������
u2 = peaks(x) + peaks(-x);  % ����ֵ + ��Сֵ�ܵ���

if abs(u2-u1) > 1
    u = 0;  % ����imf����
else
    u = 1;  % ��imf����
end
