clear; clc;
chair_mat=importdata('chair_mat.mat');

%remove_list=[11; 16; 23; 54; 58; 70; 80; 89; 94; 110; 125; 128; 154; 164; 344; 341; 314; 310; 295; 271; 259; 260; 172; 207; 224; 225; 237; 244; 291];
remove_list=[68; 19; 33; 45; 268; 144];

for j=1:size(remove_list,1)
	chair_mat(remove_list(j),:,:)=zeros(10,3);
end

save('chair_mat.mat','chair_mat');
