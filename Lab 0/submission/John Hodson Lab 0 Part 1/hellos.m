function hellos(n)
    if (~isscalar(n) || n < 1)
        error('Input must be a positive scalar');
    end
    for i=1:n
        fprintf("hello\n");
    end
end