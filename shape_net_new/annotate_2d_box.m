close all;
clc;
clear;

starting_index=-2;
mat_name='real_chair_box_2.mat';
image_path='/home/parv/Dropbox/Object_SLAM/real_chair/raw_videos/video4/';
output_image_path='/home/rishabh/DataSet/real_chair_1/'
outputfile_name='real_chair_box_2.txt'

if(starting_index>=-1)
	if (exist(strcat(image_path,mat_name)) == 2)
		load(strcat(image_path,mat_name));
		if (starting_index == -1)
			starting_index=size(real_chair_box,3)+1;
		end
	else
		starting_index=1;
		real_chair_box=zeros(2,2,1);
		save(strcat(image_path,mat_name),'real_chair_box');
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
	        if (size(a,3)==2)
	    		real_chair_box(1,:,starting_index)=a{2,1,2};
	    		real_chair_box(2,:,starting_index)=a{2,1,1}-a{2,1,2};

	    		starting_index=starting_index+1;
				save(strcat(image_path,mat_name),'real_chair_box');

				close(fig);
				fig=figure();
				% clf;
				imshow(strcat(image_path,'frame_',num2str(starting_index,'%0.5d'),'.jpg')), hold on
				title(num2str(starting_index));
	            dcm_obj = datacursormode(fig);
	            datacursormode on,
	        else
				disp('Error: Select Agains');
			end
		end
	end
else
	load(strcat(image_path,mat_name));
	outputfile=fopen(strcat(image_path,outputfile_name),'w');	
	for i=1:size(real_chair_box,3)
		fprintf(outputfile,'%sframe_%0.5d.jpg %d %d %d %d\n',output_image_path,i,real_chair_box(1,1,i),real_chair_box(1,2,i),real_chair_box(2,1,i),real_chair_box(2,2,i));
    	% fprintf(outputfile,strcat('parv','parkhiya\n'));
    end
	fclose(outputfile);    
end