clear; close all; clc;

modelStartIdx = 1;
modelEndIdx = 60;

starting_index=-1;
keypoint_number=14;
maximum_file_size=600000;
mat_name='/home/junaid/shape_net_new/car_keypoints_mat.mat';
model_dir = '/media/data/data/datasets/ShapeNet/ShapeNetCore.v1/02958343/';
modelNames = fopen('shape_net_filtered.txt');

% check if startModelIdx >1
if(modelStartIdx > 1)
    
    % ignore the lines before start idx
    for i = 1:modelStartIdx-1
        fgetl(modelNames);
    end
end

modelCntr = modelStartIdx;
car_mat = [];
if(exist(mat_name, 'file') == 2 )
    load(mat_name);
    if(starting_index==-1)
        starting_index=size(car_mat,1)+1;
    end
else
    starting_index=1;
    car_mat=zeros(1,keypoint_number,3);
    save(mat_name,'car_mat');
end
 
fig=figure();

while(modelCntr<=modelEndIdx)
    
    
    model = fgetl(modelNames);
    obj_prefix=strcat(model_dir,model,'/model');  

       

    filesize=struct2cell(dir(strcat(obj_prefix,'.obj')));
    while(filesize{3}>maximum_file_size)
        starting_index
        'file size greater'
        starting_index=starting_index+1;
        filesize=struct2cell(dir(strcat(obj_prefix,'.obj')));
    end
    
    obj_display(strcat(obj_prefix,'.obj')), hold on
    fprintf('Keypoint selection sequence: \n');
    fprintf('\t Front side: Right {roof top, mirror, headlight}, Left{ headlight, mirror, roof top}\n');
    fprintf('\t Right side: front wheel, rear wheel\n ');
    fprintf('\t Back side : Right {rooftop, back light}, Left {back light, rooftop} \n');
    fprintf('\t Left side : rear wheel, front wheel\n');
    
    view(90,0); camroll(90);camzoom(3.5);    
    dcm_obj = datacursormode(fig);

    while (1)
        w = waitforbuttonpress;

        if(w==1)

            % if SPACE then save
            if(fig.CurrentCharacter == ' ')
                a={};
                f = getCursorInfo(dcm_obj);
                if(~isempty(f))
                    a = struct2cell(f);
                    
                    if(size(a,3)==keypoint_number)
                        for i=1:keypoint_number
                            car_mat(starting_index,i,:)=a{2,1,i};
                        end
                        starting_index=starting_index+1;
                        save(mat_name,'car_mat');
                        fprintf('Keypoints saved...');
                        break;
                    else
                        fprintf('keypoint selected by you are more or less than specified. hold ALT and selet points');
                    end
                else
                    fprintf('No Keypoints selected');
                end

            elseif(fig.CurrentCharacter == 'r') % right
                 campos([cosd(90)*10,0,sind(90)*10]);
            elseif(fig.CurrentCharacter == 'b') % left
                 campos([cosd(180)*10,0,sind(180)*10]);     
            elseif(fig.CurrentCharacter == 'l') % right
                campos([cosd(270)*10,0,sind(270)*10]);            
            elseif(fig.CurrentCharacter == 'f') % front
                campos([cosd(0)*10,0,sind(0)*10]);   
            elseif(fig.CurrentCharacter == '+') % zoom more    
                camzoom(1.5);
            elseif(fig.CurrentCharacter == '-') % zoom less    
                camzoom(1/1.5);    
            elseif(fig.CurrentCharacter == 'n') % skip model
                break;
            end
            


        end
    end
    
    modelCntr = modelCntr + 1;
end
% 
% left mirror: view(90,0);camroll(90);camzoom(4.5);campan(-1.0, 0,'data', [0,1,0]);camzoom(2)
% right mirror: view(90,0);camroll(90);camzoom(4.5);campan(1.0, 0,'data', [0,1,0]);camzoom(2)
% rear: view(-90,0);camroll(-90);camzoom(4.5)
% front: view(90,0); camroll(90);camzoom(4.5);
% left front wheel: view(-180,-90);campan(-2.0, 0,'data', [0,1,0]);camzoom(4);
% left rear wheel: view(-180,-90);campan(2.0, 0,'data', [0,1,0]);camzoom(4);
% 
% right fron wheel: view(0, 90);campan(2.0, 0,'data', [0,1,0]);camzoom(4);
% 
% top: view(180,0) ; camzoom(3)