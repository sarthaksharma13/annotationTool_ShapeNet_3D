clear;
clc;
close all;


dis_flag=0;
use_object_frame_bound=1;

keypoints_ref=importdata('flying_auto_keypoint_ref.mat'); % first is frame id, second is object id, third is reinitilisation required (1 for yes)
keypoints=importdata('flying_auto_keypoint.mat');
object_frame_bound=importdata('flying_bounds.txt');

keypoints_ref_pro=[];
keypoints_pro=zeros(10,3,1);
obs_count=1;
max_num_object=30;
confidence_thres=0.05;
max_frame_not_seen=50;
mapping = [5,4,6,3,9,8,10,7,1,2]; %from hourglass to mean wireframe

last_seen_object=ones(max_num_object,1)*(-1);

starting_frame=0;
upto_frame=keypoints_ref(size(keypoints_ref,1),1);

 %starting_frame=10;
 %upto_frame=20;


% impath='/home/parv/RRC_Dataset/Object_SLAM/Data_run1/left';

i=1;

while (starting_frame>keypoints_ref(i,1))
	i=i+1;
end

while (i<= size(keypoints_ref,1) && keypoints_ref(i,1)<=upto_frame)
 	
	if (keypoints_ref(i,2)>=20 || keypoints_ref(i,2)==0)
		keypoints_ref(i,2)=0;
	else

		object_id =  keypoints_ref(i,2);
		current_frame = keypoints_ref(i,1);

		% if (use_object_frame_bound==0 || (current_frame >= object_frame_bound(object_id,1) && current_frame <= object_frame_bound(object_id,2)) || (current_frame >= (object_frame_bound(object_id,2)+keypoints_ref(size(keypoints_ref,1),1)/2)))
		if (use_object_frame_bound==0 || (current_frame >= object_frame_bound(object_id,1) && current_frame <= object_frame_bound(object_id,2)) || (current_frame >= (object_frame_bound(object_id,2)+859)))
			valid_keypoint_count=0;

			for j=1:10
				if (keypoints(j,1,i) > 0 && keypoints(j,2,i) > 0 && keypoints(j,3,i) >= confidence_thres)
					valid_keypoint_count = valid_keypoint_count + 1;
				end
			end

			if (last_seen_object(object_id)==-1)

				if (valid_keypoint_count>=9)
					for z=1:10
						keypoints_pro(mapping(z),:,obs_count)=keypoints(z,:,i);
					end
					keypoints_ref_pro=[keypoints_ref_pro; [current_frame,object_id,1]];
					obs_count=obs_count+1;
					last_seen_object(object_id)=current_frame;
				end
			elseif ((current_frame - last_seen_object(object_id)) > max_frame_not_seen )

				if (valid_keypoint_count>=9)
					for z=1:10
						keypoints_pro(mapping(z),:,obs_count)=keypoints(z,:,i);
					end				
					keypoints_ref_pro=[keypoints_ref_pro; [current_frame,object_id,1]];
					obs_count=obs_count+1;
					last_seen_object(object_id)=current_frame;
				end
			else

				if (valid_keypoint_count>=7)
					for z=1:10
						keypoints_pro(mapping(z),:,obs_count)=keypoints(z,:,i);
					end				
					keypoints_ref_pro=[keypoints_ref_pro; [current_frame,object_id,0]];
					obs_count=obs_count+1;
					last_seen_object(object_id)=current_frame;
				end
			end


			if(dis_flag==1)
				imshow(strcat(impath,num2str(keypoints_ref(i,1),'%0.4d'),'.jpg')), hold on
				title(strcat('frame id :',num2str(keypoints_ref(i,1))));
				plot(keypoints(:,1,i),keypoints(:,2,i),'*'), hold on

				if (keypoints_ref(i,2)>0)
			    	text(mean(keypoints(:,1,i)),mean(keypoints(:,2,i)), num2str(keypoints_ref(i,2)), 'Color', 'cyan', 'FontSize',20), hold on
				end

				w=waitforbuttonpress();
			end
		end

	end

    i=i+1;

end

save('flying_auto_keypoint_ref_pro.mat','keypoints_ref_pro');
save('flying_auto_keypoint_pro.mat','keypoints_pro');