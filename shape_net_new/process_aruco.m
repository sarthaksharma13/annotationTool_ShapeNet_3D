% assuming that v4 has a table with 1,10,14 columns to be string, rest number
% each frame start with '#' followed by frame number end with '$'
clear;
clc;
close all;

raw_data=importdata('v4_aruco_raw.mat');

v4={};

frame_count=0;
i=1;
while (i<=size(raw_data,1))
	temp=char(raw_data{i,1});

	if(temp(1)=='#')
		if (frame_count==0)
			frame_count=1;
		end
		v4{frame_count,1}=str2num(temp(1,2:size(temp,2))); %frame id
		v4{frame_count,2}=0; % n tags in frame
		v4{frame_count,3}=[]; % nx1 tag id
		v4{frame_count,4}=[]; % nx3 for Transalation
		v4{frame_count,5}=[]; % nx3 for Rotation
	elseif (temp(1)=='$')
		frame_count=frame_count+1;
	elseif (frame_count~=0)
		marker_id=str2num(temp);
		v4{frame_count,2}=v4{frame_count,2}+1;
		v4{frame_count,3}=[v4{frame_count,3};str2num(temp)];
		v4{frame_count,4}=[v4{frame_count,4};[raw_data{i,11},raw_data{i,12},raw_data{i,13}]];
		v4{frame_count,5}=[v4{frame_count,5};[raw_data{i,15},raw_data{i,16},raw_data{i,17}]];
	end
	i=i+1;
end

save('v4_aruco.mat','v4');
