% --------------play_mary.m-------------- %

%Notes: C D E F G
%Key #40 is middle-C
mary.keys = [44 42 40 42 44 44 44 42 42 42 44 47 47];
mary.durations = 0.25 * ones(1,length(mary.keys));
fs = 11024; % 11025 Hz also works
xx = zeros(1, sum(mary.durations)*fs);
n1 = 1;

for kk = 1:length(mary.keys)
    keynum = mary.keys(kk);
    tone = key_to_note(1, keynum, mary.durations(kk));
    n2 = n1 + length(tone) - 1;
    xx(n1:n2) = xx(n1:n2) + tone;
    n1 = n2 + 1;
end

soundsc(xx,fs);
plotspec(xx,fs,512);
audiowrite("mary.wav", xx, fs)