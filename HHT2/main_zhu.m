clear; clc;

x = xlsread('shuju.xlsx');
x = x(1001:1001+1023)';  % ��Ч���ݳ�������2^n��������ȡ1024�����10��������0
N = length(x);
fs = 100;          % ����Ƶ�� = 1/�������
t = (0:N-1)/fs;   % ʱ��̶�

 [modes its] = ceemdan(x,0.01,500,5000);  % ����ģ̬�ֽ�ĸĽ�����
% [modes,ort,nbits] = emd(x);  % ԭʼ����

%��IMF������ȡ˲ʱƵ���������A����ÿ��IMF���������,f:ÿ��IMF��Ӧ��˲ʱƵ�ʣ�t��ʱ�����к�
[A,f,t] = hhspectrum(modes);   
%��ÿ��IMF�źźϳ���ȡHilbert�ף�E����Ӧ�����ֵ��Cenf��ÿ�������Ӧ������Ƶ��  �������Ϊʱ�䣬����ΪƵ��    
[E,t,Cenf] = toimage(A,f);     

figure(2);
t = t/fs;  % ת���ɲ�����ʱ��
Cenf = Cenf*1000; % ��1000�ָ���ʵ��Ƶ��ֵ(ԭʼ�ǹ�һ����ֵ)
gca = mesh(t,Cenf,E);   
xlabel('������ʱ��(s)'); ylabel('���'); title('ceemdan�ֽ��ϣ������-�Ʊ任ʱƵ��');
axis([0 max(t) 0 100]);
view(0,90); 
colormap('HSV');
colorbar;
