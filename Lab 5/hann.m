function hh = hann(L)
%HANN generates a length L Hann window, hh
    hh = .5*(1 - cos(2*pi*(1:L)/(L+1)));
end