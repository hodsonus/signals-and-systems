function song = playSongWithTrumpet(theVoices) 
    %{
    PLAYSONG: Produce a sinusoidal waveform containing the combination of the different notes in theVoices
    Input Args:
    -theVoices: structure contains noteNumbers, durations, and startpulses vectors for multiple voices.
    Output:
    -song: vector that represents discrete-time version of a musical waveform
    Usage: song = playSong()
    %}

    fs = 44100;
    bpm = 120;
    bps = bpm / 60;
    spb = 1 / bps;
    spp = spb / 4; %seconds per pulse, theVoices is measured in pulses with 4 pulses per beat
    
    maxIndex = 1;
    for i = 1:length(theVoices)
        lastNoteNumber = length(theVoices(i).noteNumbers);
        lastNote = key_to_trumpet_note(theVoices(i).noteNumbers(lastNoteNumber), theVoices(i).durations(lastNoteNumber)*spp);
        currentIndex = spp*fs*theVoices(i).startPulses(lastNoteNumber) + length(lastNote) - 1;
        if currentIndex > maxIndex
            maxIndex = currentIndex;
        end
    end

    song = zeros(1, ceil(maxIndex)); %Create a vector of zeros with length equal to the total number of samples in the entire song

    %Then add in the notes
    for i = 1:length(theVoices)
        for j = 1:length(theVoices(i).noteNumbers)
            keynum = theVoices(i).noteNumbers(j);
            dur = theVoices(i).durations(j)*spp;
            note = ADSR(key_to_trumpet_note(keynum, dur)); %Create sinusoid of correct length to represent a single note
            locstart = spp*fs*theVoices(i).startPulses(j); % Index of where note starts
            locend = locstart + length(note) - 1; % index of where note ends
            % floor is included here to remove the warning "Integer operands are required for colon operator when used as index."
            song(floor(locstart):floor(locend)) = song(floor(locstart):floor(locend)) + note;
        end
    end
    song = song/max(song);
    soundsc(song, fs);
end