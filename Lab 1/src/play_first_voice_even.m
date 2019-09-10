% --------------play_first_voice_even.m-------------- %
load barukh_fugue

fs = 11024; % 11025 Hz also works
n1 = 1;

durations = 0.5 * ones(1,length(theVoices(1).noteNumbers));
xx = zeros(1, ceil(fs*sum(durations)));

for kk = 1:length(theVoices(1).noteNumbers)
    keynum = theVoices(1).noteNumbers(kk);
    tone = key_to_note(1, keynum, durations);
    n2 = n1 + length(tone) - 1;
    xx(n1:n2) = xx(n1:n2) + tone;
    n1 = n2 + 1;
end

soundsc(xx,fs);
plotspec(xx,fs,512);
audiowrite("first_voice_even.wav", xx, fs)