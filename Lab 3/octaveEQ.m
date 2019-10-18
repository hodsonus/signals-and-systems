function [y] = octaveEQ(xx , eq , fs)
%OCTAVEEQ an equalizer function with modified gain for notes in each octave

    l_table = [256, 128, 64, 32, 16];
    radian_octave_table = 2 * pi * [94.4, 188.85, 379.24, 755.51, 1551] / fs;
    
    c = length(radian_octave_table);
    ww = 0:pi/500:pi;
    
    filter_table = cell(c,1);

    % generate the five filters and store in the filter table
    for ci = 1:c
        
        % get the properties of the cith filter table
        wc = radian_octave_table(ci);
        L = l_table(ci);

        % generate the impulse response and the frequency response
        n = (0:1:(L-1));
        h = (0.54 - 0.46*cos(2*pi*n/(L-1))).*cos(wc*(n-(L-1)/2));
        H = freekz(h,1,ww);

        % scale the filter proportional to eq
        [pm, ~] = max(abs(H));
        B = 1/pm;
        h = h * B * 10^(eq(ci)/20);

        filter_table{ci} = h;
    end
    
    % pad each filter to the maximum filter size and update in the filter
    % table
    max_length = max(l_table);
    for ci=2:c
        filter = filter_table{ci};
        offset = floor((max_length - length(filter))/2);
        padded_filter = zeros(1,max_length);
        padded_filter(offset:(offset+length(filter)-1)) = filter;
        filter_table{ci} = padded_filter;
    end
    
    % sum each filter into h_net
    h_net = zeros(1,max_length);
    for ci=1:c
        h_net = h_net + filter_table{ci};
    end
    
    % convolve to get the output
    y = conv(xx,h_net);
end