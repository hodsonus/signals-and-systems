function xx = key_to_trumpet_note(keynum, dur)
    %{
    KEY_TO_TRUMPET_NOTE: Produce a sinusoidal waveform corresponding to a given piano key number
    Input Args:
    -X: amplitude (default = 1)
    -keynum: number of the note on piano keyboard -dur: duration of the note (in seconds)
    Output:
    -xx: sinusoidal waveform of the note
    %}
    harmonics.amplitudes = [0.1155, 0.3417, 0.1789, 0.1232, 0.0678, 0.0473, 0.0260, 0.0045, 0.0020];
    harmonics.phases = [-2.1299, 1.6727, -2.5454, 0.6607, -2.0390, 2.1597, -1.0467, 1.8581, -2.3925];
    
    fs = 44100;
    tt = 0:(1/fs):dur-1/fs;
    freq = 440 * (   2^( (keynum-49)/12 )   );
    xx = zeros(1,length(tt));
    
    for k = 1:length(harmonics.amplitudes)
        A = harmonics.amplitudes(k);
        phi = harmonics.phases(k);
        xx = xx + real( A*exp(j*2*pi*freq*tt)*exp(j*phi) );
    end
end