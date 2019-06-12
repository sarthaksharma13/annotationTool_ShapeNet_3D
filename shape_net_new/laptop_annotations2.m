clc;
close all;
clear all;
maximum_file_size=600000;
keypoints = zeros(6,3);
model_dir = dir('/home/rishabh/Desktop/3D_laptopModels/03642806/');
obj_prefix='/home/rishabh/Desktop/3D_laptopModels/03642806/';

fileID = fopen('Laptop_annotations.txt','a');
k = 1;i = 400;prompt1={'Yes or no'};
fig=figure();
obj_display(strcat(obj_prefix,model_dir(400).name,'/model.obj')); hold on,
%fprintf(fileID,'%s ',model_dir(3).name)
disp(model_dir(3).name)
view([1,1,-5]);
%view([0,0,-5]);
valid_flag = 1;
dcm_obj = datacursormode(fig);
datacursormode on,
while(i < length(model_dir))
    if(valid_flag == 0)
        close(fig);
        fig = figure();
        i = i + 1;
        obj_display(strcat(obj_prefix,model_dir(i).name,'/model.obj')), hold on
        view([1,1,-5]);
        tempz=inputdlg(prompt1);
        valid_flag=str2num(tempz{1});
        dcm_obj = datacursormode(fig);
        datacursormode on,
    else
        w = waitforbuttonpress;
        if(w == 1)
            f = getCursorInfo(dcm_obj);
            keypoints(k,1) = f.Position(1);
            keypoints(k,2) = f.Position(2);
            keypoints(k,3) = f.Position(3);
            disp(k)
            k = k + 1;
            if(k > 6)
                k = 1;
                fprintf(fileID,'%s ',model_dir(i).name);
                for list = 1:6
                    fprintf(fileID,'%f %f %f ',keypoints(list,1),keypoints(list,2),keypoints(list,3));
                end
                fprintf(fileID,'\n');
                close(fig);
                i = i + 1;
                fig = figure();
                %disp(i)
                obj_display(strcat(obj_prefix,model_dir(i).name,'/model.obj')), hold on
                view([1,1,-5]);
                dcm_obj = datacursormode(fig);
                datacursormode on,
                tempz=inputdlg(prompt1);
                valid_flag=str2num(tempz{1});    
            end
        end
    end
end
fclose(fileID);