import numpy as np
from scipy.special import spherical_jn, spherical_yn, eval_legendre
c=343.0
def h1p(n,x): return spherical_jn(n,x,True)+1j*spherical_yn(n,x,True)
def H(f,theta_deg,a,N=None):
    """Plane-wave pressure on rigid sphere / free-field pressure at centre. e^{-iwt} convention, wave from direction of theta=0."""
    ka=2*np.pi*f*a/c
    if N is None: N=int(ka+30)
    th=np.radians(theta_deg); s=0j
    for n in range(N):
        s+=(1j)**(n+1)*(2*n+1)*eval_legendre(n,np.cos(th))/h1p(n,ka)
    return s/ka**2
def pair(f,src,ear,a):
    # ear at +ear (left, source side) and -ear; source az src (positive toward left). angle of incidence:
    # incidence angle between source direction and ear direction in horizontal plane
    tn=abs(ear-src); tf=abs(ear+src)
    tn=min(tn,360-tn); tf=min(tf,360-tf)
    return H(f,tn,a),H(f,tf,a)
def wood(src,ear,a):
    def dt(th):
        th=np.radians(th); return -a*np.cos(th)/c if th<=np.pi/2 else a*(th-np.pi/2)/c
    tn=abs(ear-src); tf=abs(ear+src)
    return dt(tf)-dt(tn)
a=0.0875
print("ka=1 at f=%.0f Hz"%(c/(2*np.pi*a)))
for ear in (90,100):
  print("\n=== ears +/-%d deg, a=%.4f"%(ear,a))
  print("Woodworth ITD src30: %.1f us; src90: %.1f us"%(wood(30,ear,a)*1e6,wood(90,ear,a)*1e6))
  print(" f[Hz]  ILD[dB]  ITDphase[us]  near|H|dB far|H|dB")
  for f in [50,100,200,300,500,700,1000,1500,2000,3000,4000,6000,8000,10000,12000,16000,20000]:
    hn,hf=pair(f,30,ear,a)
    ild=20*np.log10(abs(hn)/abs(hf))
    # phase delay difference: with e^{-iwt}, pressure ~ e^{ikx}; phase lag of far rel near
    dphi=np.angle(hn/hf)  # far ear lags -> near phase larger?
    w=2*np.pi*f
    itd=dphi/w
    print("%6d %7.2f %10.1f %8.2f %8.2f"%(f,ild,itd*1e6,20*np.log10(abs(hn)),20*np.log10(abs(hf))))
# low-freq limit check 3a/c sin
print("\n3a/c sin30 = %.1f us ; 2a/c sin30 = %.1f us; (a/c)(th+sin th) th=30: %.1f us"%(3*a/c*0.5*1e6,2*a/c*0.5*1e6,a/c*(np.pi/6+0.5)*1e6))
print("max: 3a/c=%.1f us, Woodworth 90deg (a/c)(pi/2+1)=%.1f us"%(3*a/c*1e6,a/c*(np.pi/2+1)*1e6))
# radius sensitivity
for aa in (0.080,0.0835,0.085,0.0875,0.090):
  print("a=%.4f Woodworth ITD(30,ear90)=%.1f us  ITD(90,ear90)=%.1f us  ITD(30,ear100)=%.1f"%(aa,wood(30,90,aa)*1e6,wood(90,90,aa)*1e6,wood(30,100,aa)*1e6))
# diffuse-field coherence between antipodal points on rigid sphere vs free-field sinc
print("\n f  coh_sphere(180deg) coh_sphere(160deg)  sinc(kd) d=0.175")
for f in [50,100,200,300,400,500,600,800,1000,1500,2000,3000]:
  ka=2*np.pi*f*a/c; N=int(ka+30)
  def coh(psi):
    num=0;den=0
    for n in range(N):
      w=(2*n+1)/abs(h1p(n,ka))**2
      num+=w*eval_legendre(n,np.cos(np.radians(psi))); den+=w
    return num/den
  k=2*np.pi*f/c; d=2*a
  print("%5d %8.3f %8.3f %8.3f"%(f,coh(180),coh(160),np.sinc(k*d/np.pi)))
