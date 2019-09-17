function [yy] = echo_filter(xx,r,p)
    % ECHO_FILTER - Applies an echo given the magnitude of an echo r and a 
    % time delay p to an input signal xx
    yy = zeros(length(xx) + p, 1);
    yy(1:length(xx)) = xx;
    yy(p:length(yy)-1) = yy(p:length(yy)-1) + r .* xx;
end

