%% Lab 1 Part 2

%% 2.1 - Construction of the Bach Fugue
%
load bach_fugue.mat
song = playSong(theVoices);
audiowrite('bach_fugue.wav',song/max(song),8000);

%% 2.2 - Musical Tweaks - Enveloping
%
type ADSR
type playSongWithADSR

load bach_fugue.mat
song = playSongWithADSR(theVoices);
audiowrite('bach_fugue_ADSR.wav',song/max(song),8000);

%% 2.3 - Musical Tweaks - Fourier Series of a Trumpet
%
type playSongWithTrumpet
type key_to_trumpet_note

load bach_fugue.mat
song = playSongWithTrumpet(theVoices);
audiowrite('bach_fugue_trumpet_ADSR.wav',song/max(song),44100);

%%
%  Question 1: Suppose the maximum frequency in the Bach Fugue is 1200 Hz.
%  What is the minimum sampling frequency needed to synthesize, without
%  aliasing, a trumpet sound containing nine harmonics?
%%
%  According to the Nyquist Theorem, we need a sampling frequency of at
%  least 1200 Hz * 2 + 1 = 2401 Hz to avoice aliasing.