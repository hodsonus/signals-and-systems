function [blurred_image_no_border] = remove_border(orig_image, blurred_image)
    % REMOVE_BORDER Removes the black border that was applied by a gaussian
    % kernel convolution operation and restores the image to the original size.
    %   Removes the half the difference between the old border size and the
    %   new border size along each border.

    % store the row and column sizes of the different images in appropriate
    % data containers
    [orig_row_size, orig_col_size] = size(orig_image);
    [blurred_row_size, blurred_col_size] = size(blurred_image);

    % calculate where the new image should start and end for each row and
    % column
    row_start = ceil( (blurred_row_size-orig_row_size)/2 );
    row_end = blurred_row_size - ceil( (blurred_row_size - orig_row_size)/2 );
    col_start = ceil( (blurred_col_size - orig_col_size)/2 );
    col_end = blurred_col_size - ceil( (blurred_col_size - orig_col_size)/2 );

    % generate and return the borderless image
    blurred_image_no_border = blurred_image(row_start:row_end, col_start:col_end);
end

