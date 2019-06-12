Data = load('chair_mat.mat');
DataField = fieldnames(Data);
dlmwrite('FileName.txt', Data.(DataField{1}));