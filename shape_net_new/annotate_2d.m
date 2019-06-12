close all;
clc;
clear;

starting_index=10;

num_key=10;
mat_name='real_chair.mat';
image_path='/home/parv/Dropbox/Object_SLAM/real_chair/raw_videos/video4/';

if (exist(strcat(image_path,mat_name)) == 2)
	load(strcat(image_path,mat_name));
	if (starting_index == -1 && size(real_chair_mat,3)~=1)
		starting_index=size(real_chair_mat,3)+1;
	elseif (starting_index == -1)
		starting_index = 1;
	end
else
	starting_index=1;
	real_chair_mat=zeros(num_key,3,1);
	save(strcat(image_path,mat_name),'real_chair_mat');
end

fig=figure();
imshow(strcat(image_path,'frame_',num2str(starting_index,'%0.5d'),'.jpg')), hold on
title(num2str(starting_index));
dcm_obj = datacursormode(fig);
datacursormode on,

while(1)
	w = waitforbuttonpress;
        
	if (w==1)
		disp(starting_index);
		a={};
        f = getCursorInfo(dcm_obj);
        a = struct2cell(f);
        if (size(a,3)==num_key)
        	for i=1:num_key
        		real_chair_mat(i,1:2,starting_index)=a{2,1,i};
        		real_chair_mat(i,3,starting_index)=1; %confidence
        	end
    		starting_index=starting_index+1;
			save(strcat(image_path,mat_name),'real_chair_mat');

			close(fig);
			fig=figure();
			% clf;
			imshow(strcat(image_path,'frame_',num2str(starting_index,'%0.5d'),'.jpg')), hold on
			title(num2str(starting_index));
            dcm_obj = datacursormode(fig);
            datacursormode on,
        else
			disp(strcat('Keypoint selected are :',num2str(size(a,3)),' but the required Keypoints are :',num2str(num_key),'.'));
		end
	end
end

