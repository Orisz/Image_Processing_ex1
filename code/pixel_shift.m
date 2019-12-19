function [ shifted_pixel ] = pixel_shift( dx, dy, upper_left_pixel, upper_right_pixel, lower_left_pixel, lower_right_pixel )
% Shifts a pixel by [dx, dy] (each in [0,1)), via bi-linear interpolation method
    dx_vec = [1-dx dx];
    pixels_mat = [upper_left_pixel upper_right_pixel; lower_left_pixel lower_right_pixel];
    dy_vec = [1-dy dy]';
    
    shifted_pixel = dx_vec*pixels_mat*dy_vec;
end

