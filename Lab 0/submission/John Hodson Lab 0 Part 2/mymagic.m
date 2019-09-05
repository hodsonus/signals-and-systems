function square = mymagic(n)
    if ~isscalar(n) || n < 3 || mod(n,2) == 0
        error('Input must be an odd positive scalar >= 3.');
    end
    
    % bachet method
    % -> sum of the horizontal rows, vertical columns and corner diagonals
    %    are equal to the magic sum S. 
    % -> sum of any two numbers that are diagonally equidistant from the
    %    center (DENS) is equal to n2 + 1, i.e., or twice the number in
    %    the center cell and are complementary to each other.
    
    square = zeros(n,n);
    num = 1;
    x = 1;
    y = (n+1)/2;
    
    while num <= n^2
        % assign square to be our num and update num
        square(x, y) = num;
        num = num + 1;
        % update x and y pointers
        x = x-1;
        y = y+1;
        if x == 0 && y <= n
            % case 1 - x is invalid and y is valid
            x = n;
        elseif x > 0 && y > n
            % case 2 - x is valid and y is invalid
            y = 1;
        elseif (x == 0 && y > n) || square(x,y) ~= 0
            % case 3 - x and y are both invalid or we have previously set
            %          this cell.
            x = x+2;
            y = y-1;
        end
    end
end