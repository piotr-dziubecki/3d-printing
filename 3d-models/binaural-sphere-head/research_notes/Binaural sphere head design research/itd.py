import numpy as np
exec(open('sphere.py').read().split("a=0.0875")[0])
a=0.0875
fs=np.arange(20,20001,10.0)
for ear in (90,100):
  for src in (30,):
    ipsi=np.array([H(f,abs(ear-src),a) for f in fs]); contra=np.array([H(f,ear+src,a) for f in fs])
    # e^{-iwt}: phase of incoming wave increases with delay? determine sign from LF
    ph=np.unwrap(np.angle(ipsi/contra))
    itd=ph/(2*np.pi*fs)
    gd=np.gradient(ph,2*np.pi*fs)
    ild=20*np.log10(abs(contra)/abs(ipsi))  # flipped labels: contra var is actually ipsi
    print("ears %d src %d"%(ear,src))
    for f in [100,300,500,700,1000,1500,2000,3000,4000,6000,8000,12000,16000,20000]:
      i=np.argmin(abs(fs-f)); 
      print("  %6d ILD %6.2f dB  phaseITD %6.1f us  groupITD %6.1f us"%(f,ild[i],itd[i]*1e6,np.mean(gd[max(i-5,0):i+5])*1e6))
    # band-avg ILD
    for lo,hi in [(1000,2000),(2000,4000),(4000,8000),(8000,16000)]:
      m=(fs>=lo)&(fs<hi); print("  band %d-%d mean ILD %.2f dB"%(lo,hi,ild[m].mean()))
