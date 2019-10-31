function [xx] = glottal_key_to_note(keynum, dur, harm, fs)
    %GLOTTAL_KEY_TO_NOTE
    
    freq = 220 * (   2^( (keynum-49)/12 )   );
    A = 1;
    phi = 0;

    tt = 0:(1/fs):dur-1/fs;
    xx = zeros(1,length(tt));

    for k = [-harm:-1 1:harm]
        xx = xx + real( A*exp(j*2*pi*freq*k*tt)*exp(j*phi) );
    end

end

