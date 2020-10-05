# Signaltools

Contents: Fourier-Transform, Wavelet-Transform, τp Transform, Hilbert—Huang Transform 

# Time: 2019.3.09
- Programs about Discrete Fourier Transform(DFT), Inverse Transform(IDFT) and Convolution(Matlab+Python)

**Tips**:
- DFT needs to read external .txt file, and the .txt file has only one requirement: Consistent number of data per line
- 2D Convolution has only one requirement: 2D data matrix size > Convolution kernel size(the sides have to be odd)

# Time: 2019.3.10
- Convolution(by myself) —— **convolution.m**
- Example1: a 1D discrete signal is processed by DFT —— **cx1.m** and **cx1_sx.m**
- Example2: another 1D discrete signal is processed by DFT and IDFT —— **cx2.m** and **cx2_sx.m**
- Example3: doing DFT for a time-domain signal, then it's converted to frequency-domain signal. Then the frequency-domain signal is filtered —— **cx3.m** and **cx3_sx.m**
- Cyclic convolution for a signal —— **cyclic_convolution.m**
- Frequency-Amplitude diagram centralization after 2D DFT —— **center_fft2.m**
- Butterworth low-pass filtering —— **origin_lowpass_fft2.m**
- 

# Time：2019.03.23
- 2D Convolution(by myself), then tested with a simple 2D matrix —— **juanji1_2d.m** and **juanji2_2d.m**
- Image processing by 2D convolution, using various convolution kernels to realize different image processing effects —— **juanji3_2d.m**
- Image filtering by 2D convolution, **Median-filtering** and **Mean-filtering** for *Gaussian noise* and *salt noise* —— **noise_mean.m** and **noise_midval.m**
- 2D Deconvolution(by myself), then tested with a simple 2D matrix processed by 2D convolution —— **fjuanji1_2d.m** and **kz1.m** 
- 2D Discrete Fourier transform and Inverse Fourier transform(by myself) —— **mydft2.m** and **myidft2.m**
- Filtering in frequency domain for the image with noise —— **noise_lowpass_fft2.m** and **noise_compare.m**

**Tips**:
- Mang programs use the picture named **zxc.jpg**
- You can see more detailed interpretation from my blog: https://www.jianshu.com/nb/35397386

# Time：2019.04.20
- 1D signal multistage decomposition, reconstruction and recover by wavelet —— **xb1d_basic.m** and **xb1d_recover.m**
- Using Matlab own wavelet toolbox functions —— **oned_process1.m** and **oned_process2.m**
- Example1: identify the discontinuities in the signal by multistage wavelet decomposition —— **Identify_breakpoint.m**
- Example2: **time-frequency analysis** by wavelet and short-time Fourier transform, studying the variation of frequency with time in **time-varying signal** —— **tfrstft.m** and **time_freq_analy.m**
- Example3: denoising by wavelet —— **wden_qz.m** and **wdencmp_qz.m**
- Example4: time-frequency analysis of actual seismic data, and drawing contour map, mesh2D and mesh3D pictures —— **shiji.m**, Data: **shuju.xlsx**
- You can see more detailed interpretation from my blog: https://www.jianshu.com/nb/35397386

**Tips**:
- When you want to use the time-frequency analysis function, you have to use the **tfrstft.m** function. So remember to include this file!

# Time：2019.04.25
- Geophysical-specific τp transform —— **τp.m**
- You can see more detailed interpretation from my blog: https://www.jianshu.com/p/4439a1cb5c35

# Time：2019.04.28
- 1D Discrete Hilbert Transform(DHT) —— **Hilbert.m**
- DHT is applied to the real signal to obtain its '3I' property: Instantaneous-frequency, Instantaneous-phase and Instantaneous-amplitude —— **HT3S.m**
- You can see more detailed interpretation from my blog: https://www.jianshu.com/p/b591d95ae80b

# Time：2019.05.16
- Time-frequency analysis by Hilbert—Huang Transform(HHT) —— **HHT1** folder
- Time-frequency analysis by HHT with advanced ceemdan decomposition —— **HHT2** folder —— **Recommand**!!
- You can see more detailed interpretation from my blog: https://www.jianshu.com/p/3363abb64f32

**Tips**:
- HHT is currently the best method for time-frequency analysis. The new improvements simply change its empirical mode decomposition process, but the idea remains the same! So when you want to conduct time-frequency analysis, I recommend you use HHT instead of wavelet!

---

# 时间：2019.3.09
- 主要为"离散傅里叶变换(DFT)与卷积(conv)"相关matlab和python程序

**说明**：
- DFT程序中读取外部txt数据文件，格式只有一个要求：**每行数据个数一致**。       
- 二维卷积只有一个要求：二维数据矩阵尺寸 **>** 卷积核尺寸(边长最好为奇数)。

# 时间：2019.3.10
新增程序如下：
- 卷积的手动实现(文件名：convolution.m)   
- 例题1——离散函数信号的**DFT**处理，用matlab自带程序和手动实现各一个(文件名：cx1.m与cx1_sx.m);   
- 例题2——原始时域信号与**DFT+IDFT**变换后的时域信号对比，用matlab自带程序和手动实现各一个(文件名：cx2.m与cx2_sx.m);      
- 例题3——频率域的**滤波**操作，并在频域滤波后转换回时域，用matlab自带程序和手动实现各一个(文件名：cx3.m与cx3_sx.m);
- 对原始的循环卷积程序(cyclic_convolution.m)稍微修改，加上用matlab自动语句直接实现的功能;
- 相关说明参考：[一维卷积与一维离散傅里叶变换](https://www.jianshu.com/nb/35397386)。


# 时间：2019.03.23
新增程序如下：
- 二维卷积的手动实现，并用简单的二维矩阵进行测试(文件名：juanji1_2d.m与juanji2_2d.m);
- 二维卷积对图像的处理：用多种卷积核实现不同的图像处理效果(文件名：juanji3_2d.m);
- 二维卷积对图像做滤波：针对"**高斯噪声和椒盐噪声**"做"**中值滤波和均值滤波**"(文件名：noise_mean.m与noise_midval.m);
- 二维反卷积实现(文件名：fjuanji1_2d.m与kz1.m);
- 二维离散傅里叶正变换与逆变换的手动实现(文件名：mydft2.m与myidft2.m);
- 二维离散傅里叶变换后"**频振图中心化**"的手动实现(文件名：center_fft2.m);
- 在二维离散傅里叶变换后的"**频域**"内做"**巴特沃斯低通滤波**"效果(文件名：origin_lowpass_fft2.m);
- 对加了"高斯噪声/椒盐噪声"的二维图像矩阵进行频域滤波(文件名：noise_lowpass_fft2.m与noise_compare.m)。
- 另外，上面很多程序中用到了"**zxc.jpg**"图片，也放了进去方便直接测试程序(文件名：zxc.jpg);
- 相关说明参考：[二维卷积与二维离散傅里叶变换](https://www.jianshu.com/nb/35397386)。


# 时间：2019.04.20
新增程序如下：
- 一维信号小波多级分解与重构/恢复原始信号的手动实现(文件名：xb1d_basic.m与xb1d_recover.m)；
- 一维信号相关matlab自带函数的使用(文件名：oned_process1.m与oned_process2.m)；
- 小波应用1：利用小波多级分解辨识信号中的间断点(文件名：Identify_breakpoint.m)；
- 小波应用2：利用小波和短时傅里叶变换做**时频分析**，研究**时变信号**中**频率随时间**的变化情况(文件名：tfrstft.m与time_freq_analy.m)；
- 小波应用3：小波变换去噪(文件名：wden_qz.m与wdencmp_qz.m)；
- 小波应用4：实际地震数据的时频分析，并绘制等值线图、mesh2d、mesh3d图像(文件名：shiji.m；数据名：shuju.xlsx)；
- 相关参考说明：[小波变换](https://www.jianshu.com/nb/35397386)。     
**注意：时频分析应用时，各个函数都要配上tfrstft.m函数(放在一起)，它里面有一些时频变换的基础功能。**


# 时间：2019.04.25
新增程序如下：
- 地球物理专用的τp变换程序(文件名：tp.m)；
- 相关说明参考：[τp变换](https://www.jianshu.com/p/4439a1cb5c35)。


# 时间：2019.04.28
新增程序如下：
- 一维离散希尔伯特变换手动实现(文件名：Hilbert.m)；
- 根据离散希尔伯特变换得到信号的**3瞬属性**：瞬时振幅/包络、瞬时相位、瞬时频率(文件名：HT3S.m)；
- 相关说明参考：[离散希尔伯特变换](https://www.jianshu.com/p/b591d95ae80b)。


# 时间：2019.05.16
新增程序如下：
- 说明：希尔伯特-黄变换是目前时频分析最好的方法。新的改进都只不过改变它的经验模态分解过程，思想不变！
- **希尔伯特-黄变换**手动实现以及时频分析(文件夹名：HHT1);
- 用自带工具包的函数完成希尔伯特-黄变换与时频分析，并配备更高级的ceemdan分解方式(文件夹名：HHT2)；(**推荐**)
- 相关说明参考：[希尔伯特-黄变换](https://www.jianshu.com/p/3363abb64f32)。
