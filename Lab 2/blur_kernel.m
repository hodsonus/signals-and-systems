function kernel = blur_kernel(sigma)
    % As described on the Wiki page, values outside of 6*sigma are
    % effectively zero
    m = 6*sigma;
    n = 6*sigma;
    % Set the origin to be the middle of the kernel
    x_origin = 1+floor(m/2);
    y_origin = 1+floor(n/2);
    kernel = zeros(m,n);
    % Set the precision to prevent rounding to zero
    digits(15);
    for ii=1:m
        for jj=1:n
            % The x and y values are determined by distance from the origin
           x = abs(x_origin-ii);
           y = abs(y_origin-jj);
           % The following is the equation for the kernel values
           kernel(ii,jj) = double(vpa((1/(2*pi*sigma^2))*exp(-((x^2)+(y^2))/(2*sigma^2))));
        end
    end
end