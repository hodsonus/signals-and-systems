function [song, fs] = singSong(theVoices, A, B)
    % SINGSONG

    fs = 10000;
    bpm = 120;
    bps = bpm / 60;
    spb = 1 / bps;
    spp = spb / 4; %seconds per pulse, theVoices is measured in pulses with 4 pulses per beat
    
    harm = 30;
    
    % determine how long we need to make the song by looking at the last
    % note in each of theVoices
    maxIndex = 1;
    for i = 1:length(theVoices)
        lastNoteNumber = length(theVoices(i).noteNumbers);
        lastNote = glottal_key_to_note(theVoices(i).noteNumbers(lastNoteNumber), theVoices(i).durations(lastNoteNumber)*spp, harm, fs);
        currentIndex = spp*fs*theVoices(i).startPulses(lastNoteNumber) + length(lastNote) - 1;
        if currentIndex > maxIndex
            maxIndex = currentIndex;
        end
    end

    song = zeros(1, ceil(maxIndex)); %Create a vector of zeros with length equal to the total number of samples in the entire song

    % then add in the notes
    for i = 1:length(theVoices)
        theVoices(i).vowels = regexp(theVoices(i).vowels, sprintf('\\w{1,%d}', 2), 'match'); % split the vowel string into a cell array where each element is the jth vowel
        for j = 1:length(theVoices(i).noteNumbers)
            keynum = theVoices(i).noteNumbers(j); % get the ith jth keynum
            dur = theVoices(i).durations(j)*spp; % get the ith jth duration
            note = ADSR(glottal_key_to_note(keynum, dur, harm, fs)); % apply envelope to glottal sound
            vowel = theVoices(i).vowels{j}; % get the ith jth vowel
            a = A(vowel); % get the filter coefficients for the ith jth vowel
            b = B(vowel);
            note = filter(b,a,note); % apply the vowel filter
            note = note ./ max(note); % normalize volume
            locstart = spp*fs*theVoices(i).startPulses(j); % Index of where note starts
            locend = locstart + length(note) - 1; % index of where note ends
            % floor is included here to remove the warning "Integer operands are required for colon operator when used as index."
            song(floor(locstart):floor(locend)) = song(floor(locstart):floor(locend)) + note;
        end
    end
end