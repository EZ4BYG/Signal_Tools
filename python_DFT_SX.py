# -*- coding: utf-8 -*-
"""
Created on Thu Mar  7 09:09:35 2019

@author: GBY
"""

import numpy as np
import math

######### 文件读取部分 #########
num = []
# 把嵌套列表拆开成单元素的列表
def ff(li_st):
    for i in li_st:
        if type(i) != list:
            num.append(float(i))  # 记得转类型,原txt中读入默认为字符串
        else:
            ff(i)
            
f = open('ceshi.txt')
print('文件读取成功!原始数据为:')

source_lines = f.readlines()  # 以行为单位读
f.close()

num_tmp = []
for line in source_lines:
    temp1 = line.strip()      # 删掉每一行中的空白字符: \t \n \r都会自动删了
    temp2 = temp1.split(' ')  # 把每一行中按空格切割成独立元素
    num_tmp.append(temp2)     # 把每一行切割好的小列表依次加入到一个大列表中,形成嵌套列表
    
ff(num_tmp)  # 把嵌套列表放入ff函数中,得到的num就是一个单元素的列表
print(num)

######### 傅里叶正变换部分 #########
N = len(num)
pi = math.pi
a = complex(0,1)  # 表示复数用的

xk = np.array(num).reshape(len(num),1)
XK = np.zeros((N,N))
WN = np.exp(-2*pi*a/N)

WN_nk = np.zeros((N,N)) + WN
E = np.zeros((N,N))

# DFT计算部分
for row in range(N):
    for col in range(N):
        E[row,col] = row*col
        WN_nk[row,col] = WN_nk[row,col]**E[row,col]
       
Xk = np.dot(WN_nk,xk)
Xk_list = Xk.tolist()
print('离散傅里叶正变换结果:')
for i in Xk_list:
    print(i)
    
######### 傅里叶逆变换部分 #########
WN_nk_n = np.zeros((N,N)) + WN
E_n = np.zeros((N,N))

# iDFT计算部分
for row in range(N):
    for col in range(N):
        E_n[row,col] = -row*col
        WN_nk_n[row,col] = WN_nk_n[row,col]**E_n[row,col]

xk_n = np.real( (np.dot(WN_nk_n,Xk)).T/N )
print('离散傅里叶逆变换结果:')
print(xk_n)

