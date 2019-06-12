clc;
clear;
close all;
   
fig=figure;

starting_frame=0;

keypoints_raw=importdata('hourglass_small_laptop_result.txt');
keypoints_raw_ref=importdata('hourglass_small_laptop_result_ref.txt');

%output_image_path='/home/parv/RRC_Dataset/Object_SLAM/association_result/'

if (size(keypoints_raw,1)~=size(keypoints_raw_ref,1))
	error('Something is wrong');
end

keypoints=zeros(size(keypoints_raw,2)/3,3,size(keypoints_raw,1));

for i=1:size(keypoints_raw,1)
	for j=1:size(keypoints_raw,2)/3
		keypoints(j,1,i) = keypoints_raw(i,3*(j-1)+1)*((keypoints_raw_ref(i,4))/64) + keypoints_raw_ref(i,2);
		keypoints(j,2,i) = keypoints_raw(i,3*(j-1)+2)*((keypoints_raw_ref(i,5))/64) + keypoints_raw_ref(i,3);
		keypoints(j,3,i) = keypoints_raw(i,3*(j-1)+3);
	end
end


save('small_laptop_auto_keypoint.mat','keypoints');

%keypoints_ref=importdata('small_without_auto_keypoint_ref.mat'); % first is frame id, second is object id, third is reinitilisation required (1 for yes)
keypoints_ref=zeros(size(keypoints_raw,1),3); % first is frame id, second is object id, third is reinitilisation required (1 for yes)

keypoints_ref(:,1)=keypoints_raw_ref(:,1);

%%

max_number_chair=30; %unique chair
max_frame_unseen=50;

last_chair_visible=ones(max_number_chair,1)*(-1);

look_up_table=ones(max_number_chair,3)*(-1); % last frame seen, x, y

max_thresold = 50; % pixel
max_frame_back = 5;

impath='/home/parv/RRC_Dataset/Object_SLAM/Small_run_without_tag/left';

str1='possibly new laptop';

prompt1={str1};

i=1;

while (starting_frame>keypoints_raw_ref(i,1))
	i=i+1;
end


while (i<=size(keypoints_raw,1))
	current_frame=keypoints_ref(i,1);

	object_flag_id=-1;
	min_cost=9999999;

	cx=keypoints_raw_ref(i,2)+(keypoints_raw_ref(i,4)/2);
	cy=keypoints_raw_ref(i,3)+(keypoints_raw_ref(i,5)/2);

	for j=1:size(look_up_table,1)
		if(look_up_table(j,1)~=-1)

			if ((current_frame - look_up_table(j,1)) < max_frame_back )

				if ( abs(cx - look_up_table(j,2)) < max_thresold && abs(cy - look_up_table(j,3)) < max_thresold  )
					tcost = sqrt((cx - look_up_table(j,2))*(cx - look_up_table(j,2)) + (cy - look_up_table(j,3))*(cy - look_up_table(j,3)));					
					if (tcost < min_cost)
						object_flag_id = j;
						min_cost = tcost;
					end
				end
			end

		end
	end



	if (object_flag_id~=-1)
    	% text(cx,cy, num2str(object_flag_id), 'Color', 'cyan', 'FontSize',20), hold on
    	% wtt=waitforbuttonpress();
		keypoints_ref(i,2)=object_flag_id;
		if (keypoints_ref(i,2)>0)    	
			look_up_table(object_flag_id,1)=current_frame;
			look_up_table(object_flag_id,2)=cx;
			look_up_table(object_flag_id,3)=cy;
    	end
    else
    	imshow(strcat(impath,num2str(keypoints_ref(i,1),'%0.4d'),'.jpg')), hold on
		title(strcat('frame id :',num2str(keypoints_ref(i,1))));
		plot(keypoints(:,1,i),keypoints(:,2,i),'*'), hold on

		in1=inputdlg(prompt1);
		keypoints_ref(i,2)=str2num(in1{1});
    	% text(cx,cy, num2str(keypoints_ref(i,2)), 'Color', 'cyan', 'FontSize',20), hold on
		if (keypoints_ref(i,2)>0)    	
			look_up_table(keypoints_ref(i,2),1)=current_frame;
			look_up_table(keypoints_ref(i,2),2)=cx;
			look_up_table(keypoints_ref(i,2),3)=cy;
    	end
    end

	% saveas(fig,strcat(output_image_path,num2str(i,'%0.5d'),'.jpg'));


	if (keypoints_ref(i,2)>0)
		if (last_chair_visible(keypoints_ref(i,2))==-1)
			last_chair_visible(keypoints_ref(i,2))=keypoints_ref(i,1);
			keypoints_ref(i,3)=1;
		elseif (keypoints_ref(i,1) - last_chair_visible(keypoints_ref(i,2)) > max_frame_unseen)
			last_chair_visible(keypoints_ref(i,2))=keypoints_ref(i,1);
			keypoints_ref(i,3)=1;
		else
			keypoints_ref(i,3)=0;
		end
    end
    disp(current_frame);
	save('small_laptop_auto_keypoint_ref.mat','keypoints_ref');
	i=i+1;
end


