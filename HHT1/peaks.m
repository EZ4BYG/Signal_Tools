% ��������: ��ֵ�����
% ע��: ��Ҫ����ֵ����ֱ������x����Ҫ��Сֵ������-x
function n = peaks(x)

[value,local] = findpeaks(x);

n = length(local);  % ֻҪ��ֵ�����