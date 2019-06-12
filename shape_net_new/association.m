clc;
clear;
close all;
    


keypoints_raw=importdata('hourglass_result.txt');
keypoints_raw_ref=importdata('hourglass_result_ref.txt');


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


save('new_auto_keypoint.mat','keypoints');





keypoints_ref=zeros(size(keypoints_raw,1),3); % first is frame id, second is object id, third is reinitilisation required (1 for yes)

keypoints_ref(:,1)=keypoints_raw_ref(:,1);





%%

max_number_chair=30; %unique chair
max_frame_unseen=50;

last_chair_visible=ones(max_number_chair,1)*(-1);

impath='/home/parv/RRC_Dataset/Object_SLAM/Data_run1/left';

str1='Enter Chair Id. 0 for useless and start id from';

prompt1={str1};

for i=1:size(keypoints_raw,1)

	imshow(strcat(impath,num2str(keypoints_ref(i,1),'%0.4d'),'.jpg')), hold on
	title(strcat('frame id :',num2str(keypoints_ref(i,1))));
	plot(keypoints(:,1,i),keypoints(:,2,i),'*'), hold on

	in1=inputdlg(prompt1);

	keypoints_ref(i,2)=str2num(in1{1});

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

	save('new_auto_keypoint_ref.mat','keypoints_ref');

end


