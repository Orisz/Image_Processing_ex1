function [ reshaped_data_out_1, distortion_1 ,QL_1 , reshaped_data_out_2, distortion_2 ,QL_2 ] = Video_Quantizer ( vid , max_grad_idex ,levels,meps )
%We split the video into 2 videos
vid_1 = vid(:,:,:,1:max_grad_idex);
vid_2 = vid(:,:,:,max_grad_idex+1:end);

%maxloyd on first video
[vid_dim(1), vid_dim(2), vid_dim(3), vid_dim(4)] = size(vid_1);
ReshapedVideo = reshape(vid_1 ,[vid_dim(1)*vid_dim(4),vid_dim(2),vid_dim(3)]);
[ dataout1, distortion_1, QL_1 ] = ML_Quantizer( ReshapedVideo, levels, meps  );
reshaped_data_out_1 = reshape(dataout1 ,vid_dim);

%maxloyd on second video
[vid_dim(1), vid_dim(2), vid_dim(3), vid_dim(4)] = size(vid_2);
ReshapedVideo = reshape(vid_2 ,[vid_dim(1)*vid_dim(4),vid_dim(2),vid_dim(3)]);
[ dataout2, distortion_2, QL_2 ] = ML_Quantizer( ReshapedVideo, levels, meps  );
reshaped_data_out_2 = reshape(dataout2 ,vid_dim);
end

