function res = oddsummer(n)
    if ~isscalar(n) || n < 1
        error('Input must be a positive scalar');
    end
    res = sum(1:2:n);
end