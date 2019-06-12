function varargout = wireframe(varargin)
% WIREFRAME MATLAB code for wireframe.fig
%      WIREFRAME, by itself, creates a new WIREFRAME or raises the existing
%      singleton*.
%
%      H = WIREFRAME returns the handle to a new WIREFRAME or the handle to
%      the existing singleton*.
%
%      WIREFRAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WIREFRAME.M with the given input arguments.
%
%      WIREFRAME('Property','Value',...) creates a new WIREFRAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wireframe_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wireframe_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wireframe

% Last Modified by GUIDE v2.5 15-Sep-2017 15:54:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wireframe_OpeningFcn, ...
                   'gui_OutputFcn',  @wireframe_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before wireframe is made visible.
function wireframe_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wireframe (see VARARGIN)

file_name='chair_mat.mat';
keypoint_raw_data=importdata(file_name);


keypoint_data=[];

global mean_wire_frame;
global pca_wire_frame;
global ly;
global ly_max;

ly=zeros(10,1);
ly_max=1;

for tt=1:size(keypoint_raw_data,1)
    if(keypoint_raw_data(tt,1,1)~=0)
        temp_p=keypoint_raw_data(tt,:,:);
        keypoint_data=[keypoint_data;temp_p];
    end
end


mean_wire_frame=mean(keypoint_data);
keypoint_data=reshape(keypoint_data,size(keypoint_data,1),size(keypoint_data,2)*size(keypoint_data,3));

temp_mean=reshape(mean_wire_frame,size(mean_wire_frame,2)*3,1);
Xmean_large=repmat(temp_mean',size(keypoint_data,1),1);

[pca_wire_frame, score, valx ]=pca(keypoint_data);
ly_projection=(keypoint_data - Xmean_large) * pca_wire_frame;
ly_mean=mean(ly_projection);

save('pca_wire_frame.mat','pca_wire_frame');
save('pca_eigval_wire_frame.mat','valx');
save('mean_wire_frame.mat','mean_wire_frame');
save('pca_average_lambda.mat','ly_mean');
update_fig();

% Choose default command line output for wireframe
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using wireframe.

% if strcmp(get(hObject,'Visible'),'off')
%     plot(rand(5));
% end

% UIWAIT makes wireframe wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wireframe_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
% function pushbutton1_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% axes(handles.axes1);
% cla;

% switch popup_sel_index
%     case 1
%         plot(rand(5));
%     case 2
%         plot(sin(1:0.01:25.99));
%     case 3
%         bar(1:.5:10);
%     case 4
%         plot(membrane);
%     case 5
%         surf(peaks);
% end


% % --------------------------------------------------------------------
% function FileMenu_Callback(hObject, eventdata, handles)
% % hObject    handle to FileMenu (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)


% % --------------------------------------------------------------------
% function OpenMenuItem_Callback(hObject, eventdata, handles)
% % hObject    handle to OpenMenuItem (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% file = uigetfile('*.fig');
% if ~isequal(file, 0)
%     open(file);
% end

% % --------------------------------------------------------------------
% function PrintMenuItem_Callback(hObject, eventdata, handles)
% % hObject    handle to PrintMenuItem (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% printdlg(handles.figure1)

% % --------------------------------------------------------------------
% function CloseMenuItem_Callback(hObject, eventdata, handles)
% % hObject    handle to CloseMenuItem (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
%                      ['Close ' get(handles.figure1,'Name') '...'],...
%                      'Yes','No','Yes');
% if strcmp(selection,'No')
%     return;
% end

% delete(handles.figure1)


% % --- Executes on selection change in popupmenu1.
% function popupmenu1_Callback(hObject, eventdata, handles)
% % hObject    handle to popupmenu1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from popupmenu1


% % --- Executes during object creation, after setting all properties.
% function popupmenu1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to popupmenu1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: popupmenu controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%      set(hObject,'BackgroundColor','white');
% end

% set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(1,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(2,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(3,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(4,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(5,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(6,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(7,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(8,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(9,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ly;
global ly_max;
val_slider=get(hObject,'Value');
val_max=get(hObject,'Max');
val_min=get(hObject,'Min');
ly(10,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
update_fig();


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function update_fig()

    global mean_wire_frame;
    global ly;
    global pca_wire_frame;


    update=zeros(size(mean_wire_frame,2)*3,1);

    for tz=1:10
        update=update+pca_wire_frame(:,tz)*ly(tz);
    end

    current_wire_frame=mean_wire_frame+reshape(update,size(mean_wire_frame));
    cla;
    plot3(current_wire_frame(1,:,1),current_wire_frame(1,:,2),current_wire_frame(1,:,3),'.'), hold on
    xlabel('x');
    ylabel('y');
    zlabel('z');
    axis equal, hold on
    view([2,1.9,-6]), hold on,
    rotate3d on, hold on
    p1=1; p2=2;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=2; p2=3;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=3; p2=4;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=4; p2=1;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=5; p2=4;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=3; p2=6;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=6; p2=5;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=3; p2=7;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=8; p2=4;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=5; p2=9;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=6; p2=10;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=3; p2=5;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=4; p2=6;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=3; p2=1;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
    p1=2; p2=4;
    line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.slider1, 'value', 0);
    set(handles.slider2, 'value', 0);
    set(handles.slider3, 'value', 0);
    set(handles.slider4, 'value', 0);
    set(handles.slider5, 'value', 0);
    set(handles.slider6, 'value', 0);
    set(handles.slider7, 'value', 0);
    set(handles.slider8, 'value', 0);
    set(handles.slider9, 'value', 0);
    set(handles.slider10, 'value', 0);
    global ly;
    ly=ly*0;
    update_fig();



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% function varargout = wireframe(varargin)
% % WIREFRAME MATLAB code for wireframe.fig
% %      WIREFRAME, by itself, creates a new WIREFRAME or raises the existing
% %      singleton*.
% %
% %      H = WIREFRAME returns the handle to a new WIREFRAME or the handle to
% %      the existing singleton*.
% %
% %      WIREFRAME('CALLBACK',hObject,eventData,handles,...) calls the local
% %      function named CALLBACK in WIREFRAME.M with the given input arguments.
% %
% %      WIREFRAME('Property','Value',...) creates a new WIREFRAME or raises the
% %      existing singleton*.  Starting from the left, property value pairs are
% %      applied to the GUI before wireframe_OpeningFcn gets called.  An
% %      unrecognized property name or invalid value makes property application
% %      stop.  All inputs are passed to wireframe_OpeningFcn via varargin.
% %
% %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
% %      instance to run (singleton)".
% %
% % See also: GUIDE, GUIDATA, GUIHANDLES

% % Edit the above text to modify the response to help wireframe

% % Last Modified by GUIDE v2.5 15-Sep-2017 15:54:53

% % Begin initialization code - DO NOT EDIT
% gui_Singleton = 1;
% gui_State = struct('gui_Name',       mfilename, ...
%                    'gui_Singleton',  gui_Singleton, ...
%                    'gui_OpeningFcn', @wireframe_OpeningFcn, ...
%                    'gui_OutputFcn',  @wireframe_OutputFcn, ...
%                    'gui_LayoutFcn',  [] , ...
%                    'gui_Callback',   []);
% if nargin && ischar(varargin{1})
%     gui_State.gui_Callback = str2func(varargin{1});
% end

% if nargout
%     [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
% else
%     gui_mainfcn(gui_State, varargin{:});
% end
% % End initialization code - DO NOT EDIT

% % --- Executes just before wireframe is made visible.
% function wireframe_OpeningFcn(hObject, eventdata, handles, varargin)
% % This function has no output args, see OutputFcn.
% % hObject    handle to figure
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% % varargin   command line arguments to wireframe (see VARARGIN)

% file_name='laptop_mat.mat';
% keypoint_raw_data=importdata(file_name);


% keypoint_data=[];

% global mean_wire_frame;
% global pca_wire_frame;
% global ly;
% global ly_max;

% ly=zeros(10,1);
% ly_max=1;

% for tt=1:size(keypoint_raw_data,1)
%     if(keypoint_raw_data(tt,1,1)~=0)
%         temp_p=keypoint_raw_data(tt,:,:);
%         keypoint_data=[keypoint_data;temp_p];
%     end
% end



% mean_wire_frame=mean(keypoint_data);

% keypoint_data=reshape(keypoint_data,size(keypoint_data,1),size(keypoint_data,2)*size(keypoint_data,3));

% temp_mean=reshape(mean_wire_frame,size(mean_wire_frame,2)*3,1);
% Xmean_large=repmat(temp_mean',size(keypoint_data,1),1);

% [pca_wire_frame, score, valx ]=pca(keypoint_data);
% ly_projection=(keypoint_data - Xmean_large) * pca_wire_frame;
% ly_mean=mean(ly_projection);

% save('laptop_pca_wire_frame.mat','pca_wire_frame');
% save('laptop_pca_eigval_wire_frame.mat','valx');
% save('laptop_mean_wire_frame.mat','mean_wire_frame');
% save('laptop_pca_average_lambda.mat','ly_mean');
% update_fig();

% % Choose default command line output for wireframe
% handles.output = hObject;

% % Update handles structure
% guidata(hObject, handles);

% % This sets up the initial plot - only do when we are invisible
% % so window can get raised using wireframe.

% % if strcmp(get(hObject,'Visible'),'off')
% %     plot(rand(5));
% % end

% % UIWAIT makes wireframe wait for user response (see UIRESUME)
% % uiwait(handles.figure1);


% % --- Outputs from this function are returned to the command line.
% function varargout = wireframe_OutputFcn(hObject, eventdata, handles)
% % varargout  cell array for returning output args (see VARARGOUT);
% % hObject    handle to figure
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Get default command line output from handles structure
% varargout{1} = handles.output;

% % --- Executes on button press in pushbutton1.
% % function pushbutton1_Callback(hObject, eventdata, handles)
% % % hObject    handle to pushbutton1 (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % axes(handles.axes1);
% % cla;

% % switch popup_sel_index
% %     case 1
% %         plot(rand(5));
% %     case 2
% %         plot(sin(1:0.01:25.99));
% %     case 3
% %         bar(1:.5:10);
% %     case 4
% %         plot(membrane);
% %     case 5
% %         surf(peaks);
% % end


% % % --------------------------------------------------------------------
% % function FileMenu_Callback(hObject, eventdata, handles)
% % % hObject    handle to FileMenu (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)


% % % --------------------------------------------------------------------
% % function OpenMenuItem_Callback(hObject, eventdata, handles)
% % % hObject    handle to OpenMenuItem (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % file = uigetfile('*.fig');
% % if ~isequal(file, 0)
% %     open(file);
% % end

% % % --------------------------------------------------------------------
% % function PrintMenuItem_Callback(hObject, eventdata, handles)
% % % hObject    handle to PrintMenuItem (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % printdlg(handles.figure1)

% % % --------------------------------------------------------------------
% % function CloseMenuItem_Callback(hObject, eventdata, handles)
% % % hObject    handle to CloseMenuItem (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
% %                      ['Close ' get(handles.figure1,'Name') '...'],...
% %                      'Yes','No','Yes');
% % if strcmp(selection,'No')
% %     return;
% % end

% % delete(handles.figure1)


% % % --- Executes on selection change in popupmenu1.
% % function popupmenu1_Callback(hObject, eventdata, handles)
% % % hObject    handle to popupmenu1 (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)

% % % Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
% % %        contents{get(hObject,'Value')} returns selected item from popupmenu1


% % % --- Executes during object creation, after setting all properties.
% % function popupmenu1_CreateFcn(hObject, eventdata, handles)
% % % hObject    handle to popupmenu1 (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    empty - handles not created until after all CreateFcns called

% % % Hint: popupmenu controls usually have a white background on Windows.
% % %       See ISPC and COMPUTER.
% % if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
% %      set(hObject,'BackgroundColor','white');
% % end

% % set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% % --- Executes on slider movement.
% function slider1_Callback(hObject, eventdata, handles)

% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(1,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();

% % --- Executes during object creation, after setting all properties.
% function slider1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% % --- Executes on slider movement.
% function slider2_Callback(hObject, eventdata, handles)
% % hObject    handle to slider2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(2,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();

% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% % --- Executes on slider movement.
% function slider3_Callback(hObject, eventdata, handles)
% % hObject    handle to slider3 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(3,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();


% % --- Executes during object creation, after setting all properties.
% function slider3_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider3 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% % --- Executes on slider movement.
% function slider4_Callback(hObject, eventdata, handles)
% % hObject    handle to slider4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(4,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();


% % --- Executes during object creation, after setting all properties.
% function slider4_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% % --- Executes on slider movement.
% function slider5_Callback(hObject, eventdata, handles)
% % hObject    handle to slider5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(5,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();


% % --- Executes during object creation, after setting all properties.
% function slider5_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% % --- Executes on slider movement.
% function slider6_Callback(hObject, eventdata, handles)
% % hObject    handle to slider6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(6,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();


% % --- Executes during object creation, after setting all properties.
% function slider6_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% % --- Executes on slider movement.
% function slider7_Callback(hObject, eventdata, handles)
% % hObject    handle to slider7 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(7,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();


% % --- Executes during object creation, after setting all properties.
% function slider7_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider7 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% % --- Executes on slider movement.
% function slider8_Callback(hObject, eventdata, handles)
% % hObject    handle to slider8 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(8,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();


% % --- Executes during object creation, after setting all properties.
% function slider8_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider8 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% % --- Executes on slider movement.
% function slider9_Callback(hObject, eventdata, handles)
% % hObject    handle to slider9 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(9,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();


% % --- Executes during object creation, after setting all properties.
% function slider9_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider9 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% % --- Executes on slider movement.
% function slider10_Callback(hObject, eventdata, handles)
% % hObject    handle to slider10 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% global ly;
% global ly_max;
% val_slider=get(hObject,'Value');
% val_max=get(hObject,'Max');
% val_min=get(hObject,'Min');
% ly(10,1)=((val_slider-val_min)*ly_max)/(val_max-val_min);
% update_fig();


% % --- Executes during object creation, after setting all properties.
% function slider10_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider10 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% function update_fig()

%     global mean_wire_frame;
%     global ly;
%     global pca_wire_frame;


%     update=zeros(size(mean_wire_frame,2)*3,1);

%     for tz=1:10
%         update=update+pca_wire_frame(:,tz)*ly(tz);
%     end

%     current_wire_frame=mean_wire_frame+reshape(update,size(mean_wire_frame));
%     cla;
%     plot3(current_wire_frame(1,:,1),current_wire_frame(1,:,2),current_wire_frame(1,:,3),'.'), hold on
%     xlabel('x');
%     ylabel('y');
%     zlabel('z');
%     axis equal, hold on
%     view([2,1.9,-6]), hold on,
%     rotate3d on, hold on

%     disp(current_wire_frame)

%     p1=1; p2=2;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=2; p2=3;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=3; p2=4;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=1; p2=4;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=1; p2=3;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=2; p2=4;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=4; p2=5;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=5; p2=6;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=3; p2=6;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=4; p2=6;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6), hold on
%     p1=3; p2=5;
%     line([current_wire_frame(1,p1,1);current_wire_frame(1,p2,1)],[current_wire_frame(1,p1,2);current_wire_frame(1,p2,2)],[current_wire_frame(1,p1,3);current_wire_frame(1,p2,3)],'LineWidth',6);


% % --- Executes on button press in pushbutton2.
% function pushbutton2_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%     set(handles.slider1, 'value', 0);
%     set(handles.slider2, 'value', 0);
%     set(handles.slider3, 'value', 0);
%     set(handles.slider4, 'value', 0);
%     set(handles.slider5, 'value', 0);
%     set(handles.slider6, 'value', 0);
%     set(handles.slider7, 'value', 0);
%     set(handles.slider8, 'value', 0);
%     set(handles.slider9, 'value', 0);
%     set(handles.slider10, 'value', 0);
%     global ly;
%     ly=ly*0;
%     update_fig();
