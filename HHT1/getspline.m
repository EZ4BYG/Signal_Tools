% ��������: ������ݵļ���ֵ����Сֵ������(����������ֵ�������)
function s = getspline(x,t)

N = length(x);

[value,local] = findpeaks(x);

% ԭʼ��ֵ��: ��ֵ��
t1 = t(local);
x1 = x(local);

s = spline(t1,x1,t);
