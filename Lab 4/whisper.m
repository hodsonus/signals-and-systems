function [xx] = whisper(dur, fs)
    %WHISPER
    xx = randn(1,floor(fs * dur));
    xx = xx - min(xx);
    xx = xx / max(xx);
end