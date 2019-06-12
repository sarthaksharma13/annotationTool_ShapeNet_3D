clear;
close all;
clc;

auto_annotate_file_name='../real_chair/raw_videos/video4/real_chair_auto.mat';
man_annotate_file_name='../real_chair/raw_videos/video4/real_chair_man.mat';

image_path='../real_chair/raw_videos/video4/';
output_annotate_file_name='../real_chair/raw_videos/video4/real_chair_auto_corrected.mat';

Itemp=importdata(auto_annotate_file_name);
Iref=importdata(man_annotate_file_name);

num_Views=size(Itemp,3);
num_KeyPoints=size(Itemp,1);

Inew=ones(num_KeyPoints,3,num_Views)*100;
Inew(:,3,:)=Inew(:,3,:)*0.00001;

%%

for i=1:num_Views
	 % imshow(strcat(image_path,'frame_',num2str(i,'%0.5d'),'.jpg')), hold on

 	for j=1:10


		min_dis=10000;
		min_map=-1;

 		for k=1:10
            temp_dis=norm((Itemp(j,1:2,i)-Iref(k,1:2,i)));
 			if(temp_dis<min_dis)
 				min_dis=temp_dis;
 				min_map=k;
 			end

 		end

 		if(Inew(min_map,3,i)<Itemp(j,3,i))
 			Inew(min_map,:,i)=Itemp(j,:,i);
 		end

 		% plot(Inew(j,1,i),Inew(j,2,i),'*');
 		% xlabel(strcat('view number::',num2str(i),'::','keypoint number::',num2str(j),'::','confidence::',num2str(Inew(j,3,i))));
   % 		disp(min_map)

   %      w = waitforbuttonpress;

 	end

end

save(output_annotate_file_name,'Inew');