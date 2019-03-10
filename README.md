# Fourier-Transform
主要为"离散傅里叶变换(DFT)"相关matlab和python程序

说明1：DFT程序中读取外部txt数据文件，格式只有一个要求：每行数据个数一致。      

# 时间：2019.3.10
新增程序如下：
- 卷积的手动实现(文件名：convolution.m)   
- 例题1——离散函数信号的**DFT**处理，用matlab自带程序和手动实现各一个(文件名：cx1.m与cx1_sx.m);   
  例题2——原始时域信号与**DFT+IDFT**变换后的时域信号对比，用matlab自带程序和手动实现各一个(文件名：cx2.m与cx2_sx.m);      
  例题3——频率域的**滤波**操作，并在频域滤波后转换回时域，用matlab自带程序和手动实现各一个(文件名：cx3.m与cx3_sx.m);
- 对原始的循环卷积程序(cyclic_convolution.m)稍微修改，加上用matlab自动语句直接实现的功能。
