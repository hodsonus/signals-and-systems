tt = 0:1/11025:0.9;
xx = cos(4000*pi*tt);
zz = 1.4*exp(j*pi/2)*exp(j*4000*pi*tt); plot(tt, xx, 'b-', tt, real(zz), 'r--')
grid on
title('TEST PLOT OF A SINUSOID')
xlabel('TIME (sec)')