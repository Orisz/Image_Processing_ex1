function [ shifted_image ] = bi_interpolation_cyclic_shift( image, dx, dy )
%Shifts an image by [dx,dy]

    %Preparations
    shifted_image = zeros(size(image));
    dx_floored = floor(dx); 
    dy_floored = floor(dy);
    dx = dx - dx_floored;
    dy = dy - dy_floored;

    for i = 1:(size(image,1)-1) %"y"
        for j = (1:size(image,2)-1) % "x"
            %+1 in each coordinate for index correction (starts with 1)
            upper_left_pixel = image(1 + mod(j-1-dx_floored, size(image,1)), 1 + mod(i-1-dy_floored, size(image,2)));
            lower_left_pixel = image(1 + mod(j-dx_floored, size(image,1)), 1 + mod(i-1-dy_floored, size(image,2)));
            upper_right_pixel = image(1 + mod(j-1-dx_floored, size(image,1)), 1+ mod(i-dy_floored, size(image,2)));
            lower_right_pixel = image(1 + mod(j-dx_floored, size(image,1)), 1 + mod(i-dy_floored, size(image,2)));

            shifted_image(j,i) = pixel_shift(dx, dy, upper_left_pixel...
                , upper_right_pixel, lower_left_pixel, lower_right_pixel);         
        end
    end
end


