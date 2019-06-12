% clc;
% close all;
% clear all;
% maximum_file_size=600000;
% keypoints = zeros(10,3);
% model_dir = dir('/home/rishabh/Desktop/ICRA2018/chair_new_models');
obj_prefix='/home/rishabh/Desktop/ICRA2018/chair_new_models';
% 
% fileID = fopen('/home/rishabh/Desktop/ICRA2018/chair_annotations.txt','a');
% k = 1;prompt1={'Yes or no'};
% fig=figure();
i = 393;
number = num2str(i);
obj_display(strcat(obj_prefix,'/model_normalized_',number,'.obj')); hold on,
kps = [-0.254500 0.363912 -0.203608 -0.238588 0.339322 0.203608 -0.105122 0.014277 0.203608 -0.115448 0.021490 -0.203608 0.220583 0.011229 -0.203608 0.220583 0.011229 0.203608 -0.254500 -0.357973 0.189726 -0.254447 -0.358001 -0.217491 0.254718 -0.345812 -0.217491 0.251972 -0.347435 0.190199];
for i = 1:10
    scatter3(kps(3*i-2),kps(3*i-1),kps(3*i),'filled')
end

%fprintf(fileID,'%s ',model_dir(3).name)
%disp(model_dir(3).name)
% view([1,1,-5]);
% %view([0,0,-5]);
% valid_flag = 1;
% dcm_obj = datacursormode(fig);
% datacursormode on,
% while(i <= 394)
%     if(valid_flag == 0)
%         close(fig);
%         fig = figure();
%         i = i + 1;
%         number = num2str(i);
%         obj_display(strcat(obj_prefix,'/model_normalized_',number,'.obj')), hold on
%         view([1,1,-5]);
%         tempz=inputdlg(prompt1);
%         valid_flag=str2num(tempz{1});
%         dcm_obj = datacursormode(fig);
%         datacursormode on,
%     else
%         w = waitforbuttonpress;
%         if(w == 1)
%             f = getCursorInfo(dcm_obj);
%             keypoints(k,1) = f.Position(1);
%             keypoints(k,2) = f.Position(2);
%             keypoints(k,3) = f.Position(3);
%             disp(k)
%             k = k + 1;
%             if(k > 10)
%                 k = 1;
%                 %fprintf(fileID,'%s ',model_dir(i).name);
%                 for list = 1:10
%                     fprintf(fileID,'%f %f %f ',keypoints(list,1),keypoints(list,2),keypoints(list,3));
%                 end
%                 fprintf(fileID,'\n');
%                 close(fig);
%                 i = i + 1;
%                 fig = figure();
%                 number = num2str(i);
%                 %disp(i)
%                 obj_display(strcat(obj_prefix,'/model_normalized_',number,'.obj')), hold on
%                 view([1,1,-5]);
%                 dcm_obj = datacursormode(fig);
%                 datacursormode on,
%                 tempz=inputdlg(prompt1);
%                 valid_flag=str2num(tempz{1});    
%             end
%         end
%     end
% end
% fclose(fileID);