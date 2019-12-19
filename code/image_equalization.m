function [ eq_image, final_LUT ] = image_equalization( image, threshold )
    %if threshold = 0, meaning there is no threshold
    
    [OriginalimageHisto, ] = imhist(image);
    LUT_before_thresh = (1:threshold)/255; %keep original mapping
    
    % hist equalization as in at the tutorial
    hist_after_thresh = (OriginalimageHisto(threshold+1:end).')./sum(OriginalimageHisto(threshold+1:end)); 
    final_LUT = uint8(round(255*[(LUT_before_thresh) cumsum(hist_after_thresh)])); %cumsum makes histeq
    eq_image = final_LUT(double(image)+1);
end

