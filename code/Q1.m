clc;clear all;close all;
%% Q1 section a
scenary = load('..\scenary.mat');
implay(scenary.Vid);
%% section c
data = imread('..\scotland.jpg');
levels = [4 8 16 32];
figure(1);
for i=1:4
    [ dataout, distortion, QL ] = ML_Quantizer( data, levels(i), 0.05  );
    subplot(2,2,i);
    imshow(dataout,[]);
    titleQuant = sprintf('Scotland Quantized With %d Levels' , levels(i));
    title(titleQuant);

end
%% section d
vidDim = size(scenary.Vid);
reshaped_data = reshape(scenary.Vid ,[vidDim(1)*vidDim(4),vidDim(2),vidDim(3)]);
[ dataout, distortion, QL ] = ML_Quantizer( reshaped_data, 10, 0.05  );


reshaped_data_out = reshape(dataout ,vidDim);
figure(2);
distortion = distortion(distortion~=0);
epsilon = (abs(diff(distortion)))./(distortion(1:end-1));
plot(1:length(epsilon), epsilon);
title('Relative improvement as function of itteration');
grid on;
implay(reshaped_data_out);

%*************************************************************************
%for part f we need the original distortion b4 the separation so we plot it
%here 
figure(6);
plot(1:length(distortion), distortion);
grid on;
title('Distortion as a function of Itteration');
ylabel('Avg Square Error');
xlabel('Iterration');
%**************************************************************************


%% Part e
%find biggest diff from 2 following frames  
vidDim = size(scenary.Vid);
vid_gray = zeros(vidDim);
for i=1:vidDim(4)
    vid_gray(:,:,i) = rgb2gray(scenary.Vid(:,:,:,i));
end
%fill in the grads values
grad_value = zeros(1,vidDim(4)-1);
for i=1:vidDim(4)-1 
    grad_value(i) = sum(sum(abs(vid_gray(:,:,i+1) - vid_gray(:,:,i))));
end
%find the max grad index
[max_grad_value,max_grad_idx] = max(grad_value);

[ reshaped_data_out_1,distortion_1,QL_1,reshaped_data_out_2,distortion_2,QL_2 ]=Video_Quantizer ( scenary.Vid , max_grad_idx ,10,0.05 );
%if number of itters<max_iter(dist is pre allocated)
distortion_1 = distortion_1(distortion_1~=0);
epsilon_1 = (abs(diff(distortion_1)))./(distortion_1(1:end-1));
%if number of itters<max_iter(dist is pre allocated)
distortion_2 = distortion_2(distortion_2~=0);
epsilon_2 = (abs(diff(distortion_2)))./(distortion_2(1:end-1));

%*********************************************************************
%for part f we need to compare the distortion from this part to the
%one from d section
figure(7);
%video part_1
subplot(1,2,1);
plot(1:length(distortion_1), distortion_1);
grid on;
title('Distortion vid 1 as a function of Itteration');
ylabel('Avg Square Error');
xlabel('Iterration');
%video part 2
subplot(1,2,2);
plot(1:length(distortion_2), distortion_2);
grid on;
title('Distortion vid 2 as a function of Itteration');
ylabel('Avg Square Error');
xlabel('Iterration');
%*********************************************************************
figure(3);

subplot(1,2,1);
plot(1:length(epsilon_1), epsilon_1);
title('Improvement vs itteration part 1');
grid on;

subplot(1,2,2);
plot(1:length(epsilon_2), epsilon_2);
title('Improvement vs itteration part 2');
grid on;


sum_of_dist_part_1 = zeros(1,vidDim(4)-1);
sum_of_dist_part_2 = zeros(1,vidDim(4)-1);
for i = 1:vidDim(4)-1
    [~,distortion_1,~,~,distortion_2,~]=Video_Quantizer(scenary.Vid,i,10,0.05);
    distortion_1 = distortion_1(distortion_1~=0);
    distortion_2 = distortion_2(distortion_2~=0);
    
    sum_of_dist_part_1(i) = mean(distortion_1);
    sum_of_dist_part_2(i) = mean(distortion_2);
end


figure(4);
plot(1:length(sum_of_dist_part_1), sum_of_dist_part_1,'r');
hold on;
plot(1:length(sum_of_dist_part_2), sum_of_dist_part_2,'g' );
title('Distortion as function of Dividing Frame');
xlabel('Dividing Frame');
ylabel('Distortion');
grid on;
legend('Vid_1' , 'Vid_2');

%% part f
%'reshaped_data_out_1' and 'reshaped_data_out_2' are calculated at part e

implay(reshaped_data_out_1);
implay(reshaped_data_out_2);







