# -*- coding: utf-8 -*-
"""
Created on Thu Mar  7 16:55:35 2019

@author: GBY
"""

import numpy as np 
from math import *

# 手动输入信号:
# print('原始信号为:')
# a = np.array([2,-1,-2,-1,6,2,8,9])
# b = np.array([-3,4,-2,4,3,-5,1,-8])
# print('a: ', a)
# print('b: ', b)
# N = len(a)

# 随机生成的信号
N = int(input('采样点数:'))
print('原始信号为:')
a = np.random.randint(low=-2*N, high=2*N, size = N)
b = np.random.randint(low=-2*N, high=2*N, size = N)
print('a: ', a)
print('b: ', b)

xk_a = a.T
xk_b = b.T
WN = np.exp(-2*pi*complex(0,1)/N)
WN_nk_a = np.zeros((N,N)) + WN
WN_nk_b = np.zeros((N,N)) + WN
E_a = np.zeros((N,N))
E_b = np.zeros((N,N))

# a,b原始信号的DFT计算部分，得到t信号的频率域
for row in range(N):
    for col in range(N):
        E_a[row,col] = row*col
        E_b[row,col] = row*col
        WN_nk_a[row,col] = WN_nk_a[row,col]**E_a[row,col]
        WN_nk_b[row,col] = WN_nk_b[row,col]**E_b[row,col]
        
Xk_a = np.dot(WN_nk_a,xk_a)
Xk_b = np.dot(WN_nk_b,xk_b)

Xk_t = Xk_a*Xk_b # T信号(频率域)

# t信号IDFT计算部分：转回到时间域(原始循环卷积信号)
WN_nk_t = np.zeros((N,N)) + WN
E_t = np.zeros((N,N))

for row in range(N):
    for col in range(N):
        E_t[row,col] = -row*col
        WN_nk_t[row,col] = WN_nk_t[row,col]**E_t[row,col]
        
xk_t = np.real( (np.dot(WN_nk_t,Xk_t)).T/N )
print('循环卷积t信号为:')
print('t: ', xk_t)
        