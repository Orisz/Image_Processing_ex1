clc; 
close all; 
clear;

%% Section a
r_normalized = (0:255) / 255;
c = 1;
gamma_vals = [0.01, 0.05, 0.1, 0.3, 0.5, 0.7, 1, 2, 3, 5, 10, 20];

% Plotting
figure;
hold on
grid on

for gamma = gamma_vals
    s = c*(r_normalized.^gamma); %transformation
    plot(255*r_normalized,255*s);
end

xlim([0,255])
ylim([0,255])
title('Gamma Correction');
xlabel('input pixel value (r)');
ylabel('output pixel value (s(r))');
legend([repmat('\gamma = ',size(gamma_vals,2),1) , num2str(gamma_vals','%.2f')]);

%% Section b
chosen_gamma = 0.5;
pic = imread('../Maria.jpg');

% original
figure();
subplot(2,2,1);
imshow(pic);
title('Maria - original');
subplot(2,2,3);
histogram(pic);
axis tight
title('Histogram of Maria - original');
grid on;

% operate LUT
LUT = c*(r_normalized.^chosen_gamma); %all transformation values
LUT = uint8(255*LUT); 
a = double(pic)+1;
pic_corrected = LUT(double(pic)+1); %output is the same dimentions matrix, 
                                    %and each cell transforms to it's destination using the LUT

% image after LUT
subplot(2,2,2);
imshow(pic_corrected);
title(['Maria - after correction, for \gamma = ', num2str(chosen_gamma)]);
subplot(2,2,4);
histogram(pic_corrected);
axis tight
title('Histogram of Maria - after correction');

%% Sections c
threshold = 0; %equalization over entire picture
figure;
[equalized_pic, LUT] = image_equalization(pic,threshold);
subplot(1,3,1);
histogram(equalized_pic);
grid on
title('Histogram of Maria - after equalization');
xlabel('pixel value');
ylabel('number of pixels');
xlim([0 260]);
subplot(1,3,2);
imshow(equalized_pic)
title('Maria - after equalization');
subplot(1,3,3);
LUT_x = (1:1:256);
plot(LUT_x, LUT);
ylim([0 260]);
grid on
title('Maria - equalization LUT');
xlabel('input pixel value');
ylabel('output pixel value');

%% Section d
figure;
threshold = 4; %equalization on pixel with the value above threshold
[equalized_pic, LUT] = image_equalization(pic,threshold);
subplot(1,3,1);
histogram(equalized_pic);
grid on
title({'Histogram - after equalization only on';['pixels with value above ',num2str(threshold)]})
xlabel('pixel value');
ylabel('number of pixels');
xlim([0 260]);
subplot(1,3,2);
imshow(equalized_pic)
title({'Maria - equalization after only on pixels';['with value above ',num2str(threshold)]})
subplot(1,3,3);
LUT_x = (1:1:256);
plot(LUT_x, LUT);
ylim([0 260]);
grid on
title({'Maria - equalization LUT only on';['pixels with value above ',num2str(threshold)]})
xlabel('input pixel value');
ylabel('output pixel value');

