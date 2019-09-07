function xx = key_to_note(X, keynum, dur)
    %{
    KEY_TO_NOTE: Produce a sinusoidal waveform corresponding to a given piano key number Input Args:
    -X: amplitude (default = 1)
    -keynum: number of the note on piano keyboard -dur: duration of the note (in seconds)
    Output:
    -xx: sinusoidal waveform of the note
    %}
    fs = 11024;
    tt = 0:(1/fs):dur-1/fs;
    freq = 440 * (   2^( (keynum-49)/12 )   );
    xx = real( X*exp(j*2*pi*freq*tt) );
end