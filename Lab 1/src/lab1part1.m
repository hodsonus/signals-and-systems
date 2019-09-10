%% Lab 1 Part 1

%% 1.1 - A Function to Play a Note
%
type key_to_note.m

%% 1.2 - Synthesize a Song - Mary Had a Little Lamb that NEVER Grew Up!
%
type play_mary.m
play_mary

%% 1.4 - The Evenly-Timed First Voice
%
type play_first_voice_even
play_first_voice_even

%% 1.5 - The Correctly-Timed First Voice
%
type play_first_voice
play_first_voice

%% 1.6 - Silence and startPulses: Construction of the Better Fugue
%
type playSong

load better_fugue.mat
song = playSong(theVoices);
audiowrite('better_fugue.wav',song/max(song),11024);

load barukh_fugue.mat
song = playSong(theVoices);
audiowrite('barukh_fugue.wav',song/max(song),11024);