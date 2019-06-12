clc;
clear all;
close all;
obj_prefix='Models/model_normalized_';
a = importdata('chair_mat.mat')
%for i =1:344
i = 1;
%pts = a(i,:,1), a(i,:,2), a(i,:,3)
%pts = rotx(90) * pts
obj_display(strcat(obj_prefix,num2str(i),'.obj')), hold on
scatter3(a(i,:,1), a(i,:,2), a(i,:,3),'filled')
view(0,0)
%   pause(10);
%end