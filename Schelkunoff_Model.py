#import scipy.special as sp
import numpy as np
import math
from mpmath import mp
# pip install mpmath
import matplotlib.pyplot as plt
import time as time

tim = time.time()

mu0 	= 4*math.pi*10**-7; 			# Vs/Am
eps0	= 8.854*10**-12; 				# As/Vm
c0 		= 299792457; 					# m/s


############
# Thomas numbers
############

# a		= 0.25/2*10**-3;                # mm
# b		= 135/2*10**-3;                 # mm
# c		= 139.7/2*10**-3;               # mm
# sigma	= 5.76*10**7; 					# 1/Ohm*m
# epsPE   = 1.0; 

############
# Tesche numbers
############

a		= 2.5*10**-3;                # mm
b		= 9.345*10**-3;                 # mm
c		= 9.945*10**-3;               # mm
sigma	= 5.76*10**7; 					# 1/Ohm*m
epsPE   = 2.5; 

############
# RG58 or Jans numbers
############

a		= 0.4675*10**-3;                # mm
b		= 1.475*10**-3;                 # mm
c		= 1.8 *10**-3;               # mm
sigma	= 5.8*10**7; 					# 1/Ohm*m
epsPE   = 1.9; 


f   = np.logspace(5, 8, 100); 
omega = 2*math.pi*f; 

Lp = mu0/(2*math.pi)*mp.log(b/a); 			    # ln(ra/ri)
Cp = 2*math.pi*eps0*epsPE/(mp.log(b/a)); 	    # ln(ra/ri)


etac	= np.sqrt(1j*omega*mu0/sigma); 
gammac	= np.sqrt(1j*omega*mu0*sigma);

# shortcuts
i0 = lambda x: mp.besseli(0,x)
i1 = lambda x: mp.besseli(1,x)
k0 = lambda x: mp.besselk(0,x)
k1 = lambda x: mp.besselk(1,x)

# Zap	= etac/(2*math.pi*a)*(sp.iv(0,gammac*a) / sp.iv(1,gammac*a)); 
ZapA = etac/(2*math.pi*a)

#Zbp	= etac/(2*math.pi*b)* (sp.iv(0,gammac*b) * sp.kv(1,gammac*c) + sp.kv(0,gammac*b) * sp.iv(1,gammac*c)) /  (sp.iv(1,gammac*b)*sp.kv(1,gammac*b) - sp.iv(1,gammac*b)*sp.kv(1,gammac*b))
ZbpA = etac/(2*math.pi*b)


ZL = mp.matrix(f.size, 1)
YC = mp.matrix(f.size, 1)
Zap = mp.matrix(f.size, 1)
Zbp = mp.matrix(f.size, 1)
Zp = mp.matrix(f.size, 1)
Yp = mp.matrix(f.size, 1)
Zc = mp.matrix(f.size, 1)
A = np.ndarray(f.size)
R = np.ndarray(f.size)
I = np.ndarray(f.size)
Gr = np.ndarray(f.size)
Gi = np.ndarray(f.size)

for n in range(f.size):
    Zap[n] = ZapA[n]*( i0(gammac[n]*a) / i1(gammac[n]*a) )
    Zbp[n] = ZbpA[n] * ((i0(gammac[n]*b) * k1(gammac[n]*c) + k0(gammac[n]*b)*i1(gammac[n]*c)) / ( i1(gammac[n]*c)*k1(gammac[n]*b) - i1(gammac[n]*b)*k1(gammac[n]*c) ) )
    ZL[n] = 1j*omega[n]*Lp
    YC[n] = 1j*omega[n]*Cp
    Zp[n] = Zap[n] + Zbp[n] + ZL[n]
    Yp[n] = YC[n] # + G[n]
    Zc[n] = mp.sqrt(Zp[n]/Yp[n])
    A[n] = mp.fabs(Zc[n])
    R[n] = mp.re(Zc[n])
    I[n] = mp.im(Zc[n])
    Gr[n] = mp.re(mp.sqrt(Zp[n]*Yp[n]))
    Gi[n] = mp.im(mp.sqrt(Zp[n]*Yp[n]))

fig = plt.figure()
plt.plot(f/10**6, A, label='Magnitude', color='red')
plt.xlabel('Frequency [MHz]')
plt.ylabel('Magnitude of Z$_{c}$ [$\Omega$]')
plt.legend()
plt.xlim([-0.3,100])
#plt.show()
fig2 = plt.figure()
plt.plot(f/10**6, R, label='Real Part', color='red')
plt.xlabel('Frequency [MHz]')
plt.ylabel('Real Part of Z$_{c}$ [$\Omega$]')
plt.legend()
plt.xlim([-0.3,100])
#plt.show()
fig2 = plt.figure()
plt.plot(f/10**6, I, label='Imaginary Part', color='red')
plt.xlabel('Frequency [MHz]')
plt.ylabel('Imaginary Part of Z$_{c}$ [$\Omega$]')
plt.legend()
plt.xlim([-0.3,100])
print("Total duration: ", time.time() - tim, " s")
#plt.show()

fig4 = plt.figure()
plt.plot(f/10**6, A, label='Amplitude', color='red')
plt.plot(f/10**6, R, label='Real Part', color='blue')
plt.plot(f/10**6, I, label='Imaginary Part', color='green')
plt.xlabel('Frequency [MHz]')
plt.ylabel('Z$_c$ [$\Omega$]')
plt.legend()
plt.xlim([-0.3, 100])
#plt.show()

fig5 = plt.figure()
plt.semilogx(f/10**3, A, label='Magnitude', color='red')
plt.semilogx(f/10**3, R, label='Real Part', color='blue')
plt.semilogx(f/10**3, I, label='Imaginary Part', color='green')
plt.legend()
plt.xlabel('Frequency [kHz]')
plt.ylabel('Characteristic Impedance Z$_c$ [$\Omega$]')
plt.grid()

fig6 = plt.figure()
plt.loglog(f/10**6, Gr, label='Attenuation constant [1/m]', color='red')
plt.loglog(f/10**6, Gi, label='Propagation phase constant [1/m]', color='blue')
plt.xlabel('Frequency [MHz]')
plt.ylabel('Propagation constant')
plt.legend()
plt.show()

#print("Zc \n", Zc)
