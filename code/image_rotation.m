function [ rotated_image ] = image_rotation( image, angle_deg , Is_bilinear_interpulation)
%Rotates an image at the desired angle (to the rignt), relative to the center of the image
%If Is_bilinear_interpulation = 1, we use bilinear interpulation method (on
%the surrounding 4 pixels   
    
    angle_radians = angle_deg*pi/180;
    rotated_image = zeros(size(image));
    
    %image center
    center_x = floor((size(image,2)+1)/2); %cols of the matrix
    center_y = floor((size(image,1)+1)/2); %rows of the matrix
    image(size(image)+1, size(image)+1) = 0; 
    
    for new_y = 1:size(rotated_image,1)
        for new_x = 1:size(rotated_image,2)
            %using the inverted rotation matrix
            old_x = (new_x-center_x)*cos(angle_radians) + (new_y-center_y)*sin(angle_radians);
            old_y = -(new_x-center_x)*sin(angle_radians) + (new_y-center_y)*cos(angle_radians);
            
            if Is_bilinear_interpulation == 0
                %rounding
                old_x = round(old_x) + center_x; 
                old_y = round(old_y) + center_y;          
            else
                old_x_floored = floor(old_x) + center_x; 
                old_y_floored = floor(old_y) + center_y;
                old_dx = old_x - floor(old_x);
                old_dy = old_y - floor(old_y);
                %upper_left_pixel, upper_right_pixel, lower_left_pixel, lower_right_pixel )
            end
            
            % handle exeeding matrix (while rotating)
            if Is_bilinear_interpulation == 0
                if (old_x >= 1 && old_x <= size(image,2) && old_y >= 1 && old_y <= size(image,1))
                    rotated_image(new_x,new_y) = image(old_x,old_y);
                end
            else
                if (old_x_floored >= 1 && old_x_floored < size(image,2) && old_y_floored >= 1 && old_y_floored < size(image,1))
                    rotated_image(new_x,new_y) = pixel_shift(old_dx, old_dy, image(old_x_floored,old_y_floored), image(old_x_floored+1,old_y_floored), image(old_x_floored,old_y_floored+1), image(old_x_floored+1,old_y_floored+1));
                end
            end
        end
    end
end
