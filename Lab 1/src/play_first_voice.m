% --------------play_first_voice.m-------------- %
load barukh_fugue

fs = 11025; % 11025 Hz also works
n1 = 1;

xx = zeros(1, ceil(fs*0.15*sum(theVoices(1).durations)));

for kk = 1:length(theVoices(1).noteNumbers)
    keynum = theVoices(1).noteNumbers(kk);
    tone = key_to_note(1, keynum, 0.15*theVoices(1).durations(kk));
    n2 = n1 + length(tone) - 1;
    xx(n1:n2) = xx(n1:n2) + tone;
    n1 = n2 + 1;
end

soundsc(xx,fs);
plotspec(xx,fs,512);
audiowrite("first_voice.wav", xx, fs)