function tone = ADSR(tone)
    %{
    ADSR: Apply an envelope to a particular note.
    Input Args:
    -tone: the tone to apply the ADSR envelope to.
    Output:
    -tone: the tone that was supplied as a paramater, with the ADSR
    envelope.
    Usage: 
    envelopedTone = ADSR(tone);
    %}

    A = linspace(0.0, 0.9, (length(tone)*0.25)); % rise 25%
    D = linspace(0.9, 0.7, (length(tone)*0.05)); % drop 5%
    S = linspace(0.7, 0.7, (length(tone)*0.40)); % maintain 40%
    R = linspace(0.7, 0.0, (length(tone)*0.30)); % drop 30%
    ADSR = [A D S R];
    
    x = zeros(size(tone));
    x(1:length(ADSR)) = ADSR;
    tone = tone .* x;
end