close all;
clear;
clc;

%% Section c
pic_gray = im2double(imread('..\cameraman.jpg'));
figure
subplot(2,2,1)
imshow(pic_gray);
title('Original image')

shifted_pic = bi_interpolation_cyclic_shift(pic_gray, 170.3, 130.8);
subplot(2,2,2)
imshow(shifted_pic);
title('Shifted image')

%% Section D
pic_gray = im2double(imread('..\Brad.jpg'));
mask1 = zeros(size(pic_gray));
[rows_size, cols_size] = size(pic_gray); % (x,y)
for x = 1:cols_size
    for y = 1:rows_size
        mask1(y,x) = 0;
        if ((x-255)^2 + (y-275)^2 < 64^2) && (y > 276) %(x-x0)^2 + (y-y0)^2 = R^2
            mask1(y,x) = 1;
        end
    end
end

subplot(2,2,3)
imshow(mask1);
title('Mask1');

%% Section E
brad_win = im2double(imread('..\Brad.jpg'));
brad_win = brad_win.*mask1;
subplot(2,2,4)
imshow(brad_win);
title('Masked Brad');

%% Section F
figure
subplot(2,3,1)
imshow(image_rotation(brad_win, 45, 0));
title('Masked Brad, 45 deg rotation, NN');

subplot(2,3,2)
imshow(image_rotation(brad_win, 60, 0));
title('Masked Brad, 60 deg rotation, NN');

subplot(2,3,3)
imshow(image_rotation(brad_win, 90, 0));
title('Masked Brad, 90 deg rotation, NN');

%% Section G
subplot(2,3,4)
imshow(image_rotation(brad_win,45,1));
title('Brad Masked, rotatad 45 deg, bi-inter');

subplot(2,3,5)
imshow(image_rotation(brad_win,60,1));
title('Brad Masked, rotatad 60 deg, bi-inter');

subplot(2,3,6)
imshow(image_rotation(brad_win,90,1));
title('Brad Masked, rotatad 90 deg, bi-inter');