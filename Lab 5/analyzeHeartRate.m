function bpms = analyzeHeartRate(ecg)
%ANALYZEHEARTRATE extracts the BPM from an ECG in windows

    signal_length_sec = 1 * 60 * 60;
    window_length_sec = 60 * 2;
    overlap_length_sec = 10;
    
    fs = round(length(ecg)/signal_length_sec);
    
    window_length_samp = window_length_sec*fs;
    overlap_length_samp = overlap_length_sec*fs;
    
    start_samp = 1;
    end_samp = start_samp + window_length_samp - 1;
    
    bpms = [];
    while end_samp < length(ecg)
        xx = ecg(start_samp : end_samp);
        h = hann(length(xx));
        xx = xx .* h;
        xx = [xx zeros(1,50000)];
        XX = abs(fftshift(fft(xx)));
        
        ww = -pi:(2*pi/length(XX)):(pi-1/length(XX));
        ff = fs * ww / (2 * pi);
        hr_range = find(ff > 1 & ff < 2);
        ff = ff(hr_range);
        XX = XX(hr_range);
         
        bpm = ff(XX == max(XX)) * 60;
        bpms = [bpms bpm];
        
        start_samp = end_samp - overlap_length_samp;
        end_samp = start_samp + window_length_samp - 1;
    end
end