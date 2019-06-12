
keypoint_number=6;
maximum_file_size=600000;

maximum_file_size=600000;
mat_name='Laptop_annotation.mat';
model_dir = dir('/home/rishabh/Desktop/3D_laptopModels/03642806/');
obj_prefix='/home/rishabh/Desktop/3D_laptopModels/03642806/';

if(exist(mat_name, 'file') == 2 )
    load(mat_name);
else
    Laptop_annotation=zeros(1,keypoint_number,3);
    save(mat_name,'Laptop_annotation');
end
i = 3;
fig=figure();
filesize=struct2cell(dir(strcat(obj_prefix,model_dir(i).name,'/model.obj')));

while(filesize{3}>maximum_file_size)
    i
    'file size greater'
    i = i+1;
    %starting_index=starting_index+1;
    filesize=struct2cell(dir(strcat(obj_prefix,model_dir(i).name,'/model.obj')));
end            
obj_display(strcat(obj_prefix,model_dir(i).name,'/model.obj')), hold on
view([2,1.9,-5]);
dcm_obj = datacursormode(fig);
datacursormode on,
while (1)
    w = waitforbuttonpress;
    k = 1;
    if(w==1)
        i
        %a={};
        f = getCursorInfo(dcm_obj);
        a(k) = f.Position;
        k = k + 1;
        %a = f;
        if(size(a,1)==keypoint_number)
            for j=1:keypoint_number
                Laptop_annotation(i,j,:)=a{2,1,j};
            end
            k = 1;
            i = i +1;
            save(mat_name,'Laptop_annotation');

            filesize=struct2cell(dir(strcat(obj_prefix,model_dir(i).name,'/model.obj')));
            while(filesize{3}>maximum_file_size)
                i =i+1;
                filesize=struct2cell(dir(strcat(obj_prefix,model_dir(i).name,'/model.obj')));
            end            
            obj_display(strcat(obj_prefix,model_dir(i).name,'/model.obj')), hold on
            view([2,1.9,-5]);
            dcm_obj = datacursormode(fig);
            datacursormode on,
        else
            'keypoint selected by you are more or less than specified. hold ALT and selet points'
        end 
    end
end
% for i = 3:length(model_dir)
%     fig=figure();
%     %filesize=struct2cell(dir(strcat(obj_prefix,model_dir(i).name,'/model.obj')));        
%     obj_display(strcat(obj_prefix,model_dir(i).name,'/model.obj')), hold on
%     view([2,1.9,-5]);
%     dcm_obj = datacursormode(fig);
%     w = waitforbuttonpress;
%     if(w == 1)
%         i
%         a={};
%         f = getCursorInfo(dcm_obj);
%         %a = struct2cell(f);
%     end
% end
% 
