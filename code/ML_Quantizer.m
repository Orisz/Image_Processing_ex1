function [ dataout, distortion, QL ] = ML_Quantizer(  data, levels, meps   )

maxIteration = 20;%starting value fo loop
fk_mat = zeros(levels,3);%the new levels after we finish
distortion = zeros(maxIteration,1);%distortion for each iteration
Epsilon = Inf;

double_data = im2double(data);%converting to double
[rows,cols,rgb_dim] = size(double_data);
num_of_pixels = rows*cols;
rgb_mat = reshape(double_data,[num_of_pixels,rgb_dim]);%each dim of rgb is now a vector
unique_rgb_mat = unique(rgb_mat,'rows');
random_indices = sort(randperm(length(unique_rgb_mat),levels)); 
fk_mat = unique_rgb_mat(random_indices,:); %randomize quantization levels from original image

%ReshapedData = reshape(data,[],1,dims(3));
fk_mat = reshape(fk_mat,1,rgb_dim,levels);
counter = 1;

%for later on
dataout = zeros(num_of_pixels ,3);

while ((Epsilon > meps) && (counter <= maxIteration))
    %for each QL(fk matrix) selected find for each pixle what is the
    %nearest QL for him so we can calc the new center of mass for each
    %QL
    % 1st dim number of pixels
    %2nd dim=3 the rgb representation
    %3rd dim number of levels (#QL)
    rgb_mat_3d = repmat(rgb_mat,1,1 , levels);
    fk_mat_3d = repmat(fk_mat,length(rgb_mat),1,1);
    Distance = sqrt(sum((rgb_mat_3d-fk_mat_3d).^2,2));%2d NumOfPixels*level matrix of the distance of each pixel(pixel is made from rgb values) from each level
    [minDist , minIdx] = min(Distance,[],3);
    %where minIdx id the assingment to the QL
    distortion(counter) = sum(minDist.^2)/num_of_pixels;
    
    %finding the new QL(fk_matrix)
    for i=1:levels
       pixle_indices = find( minIdx==i);%what pixles are of level number i
       fk_mat(1,:,i) = mean(rgb_mat(pixle_indices,:));
    end
    
    %generate new picture from the QL levels only!
    for j=1:length(minIdx)
    dataout(j,:) = fk_mat(1,:,minIdx(j));
    end
       
    %calc new epsilon
    if counter>1
      Epsilon = abs(distortion(counter)-distortion(counter-1))/distortion(counter-1);
    end
    
    counter = counter + 1;
end%end while
QL = reshape(fk_mat,rgb_dim,levels);
dataout = uint8(reshape(dataout,[rows,cols,rgb_dim])*255);
end%end func

