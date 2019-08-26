function [fun,t] = one_cos(amp, angular_freq, phase, duration)
    step = 2*pi/(25*angular_freq);
    t = -duration:step:duration;
    fun = amp*cos(angular_freq*t+phase);
end