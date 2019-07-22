function varargout = Robot_GUI_1(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arena configuration to draw different arenas
% AI & Robotics Lab
% University of Engineering and Technology, Lahore
% ==========================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROBOT_GUI_1 MATLAB code for Robot_GUI_1.fig
%      ROBOT_GUI_1, by itself, creates a new ROBOT_GUI_1 or raises the existing
%      singleton*.

%      H = ROBOT_GUI_1 returns the handle to a new ROBOT_GUI_1 or the handle to
%      the existing singleton*.
%
%      ROBOT_GUI_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOT_GUI_1.M with the given input arguments.
%
%      ROBOT_GUI_1('Property','Value',...) creates a new ROBOT_GUI_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Robot_GUI_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Robot_GUI_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Robot_GUI_1

% Last Modified by GUIDE v2.5 15-Feb-2019 10:03:24

% Begin initialization code - DO NOT EDIT
set(0,'DefaultFigureWindowStyle','normal')
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Robot_GUI_1_OpeningFcn, ...
                   'gui_OutputFcn',  @Robot_GUI_1_OutputFcn, ...
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

% --- Executes just before Robot_GUI_1 is made visible.
function Robot_GUI_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Robot_GUI_1 (see VARARGIN)

% Choose default command line output for Robot_GUI_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Robot_GUI_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Robot_GUI_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% ========================================================================

function arena_pic_Callback(hObject, eventdata, handles)
% hObject    handle to arena_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=get(handles.arena_pic,'Value')
rado=handles.arens;
    if a==1 
    arenaSelection = '';   
    elseif a==2
     arenaSelection = 'EW';
    elseif a== 3
     arenaSelection = 'HW'; 
       elseif a== 4
      arenaSelection = 'SW';
    elseif a==5
      arenaSelection = 'UW';   
    elseif a==6
      arenaSelection = 'WW';   
    elseif a==7
      arenaSelection = 'XW';   
    elseif a==8
      arenaSelection = 'CAW';   
    elseif a==9
        arenaSelection = 'SpW';
    elseif a==10
        % arenaSelection = 'MW';
        % elseif a==11
        arenaSelection = '';
    end
    [arena]=createArena2(rado, arenaSelection,handles);
    handles.w=arena;
 guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.

function arena_pic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arena_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in Obstacle_numb.
function Obstacle_numb_Callback(hObject, eventdata, handles)
% hObject    handle to Obstacle_numb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Obstacle_numb contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Obstacle_numb
alpha=handles.obst;
d=get(handles.Obstacle_numb,'Value');
gamma=handles.arens;
if d==1 && alpha==1
    e= '';
elseif d== 2 && alpha==1
    e=1;
elseif d== 3 && alpha==1
    e=2;
elseif d== 4 && alpha==1
    e=3;
elseif d== 5 && alpha==1
    e=4;
elseif d== 6 && alpha==1
    e=5;
elseif d== 7 && alpha==1
    e=6;
elseif d== 8 && alpha==1
    e=7;
elseif d== 9 && alpha==1
    e=8;
elseif d== 10 && alpha==1
    e=9;
    
elseif d== 1 && alpha==2
    e= '';
elseif d== 2 && alpha==2
    e=1;
elseif d== 3 && alpha==2
    e=2;
elseif d== 4 && alpha==2
    e=3;
elseif d== 5 && alpha==2
    e=4;
elseif d== 6 && alpha==2
    e=5;
elseif d== 7 && alpha==2
    e=6;
elseif d== 8 && alpha==2
    e=7;
elseif d== 9 && alpha==2
    e=8;
elseif d== 10 && alpha==2
    e=9;
end
camel=handles.gotab;

[AREna OBStacles]=createobstacle2(gamma,e,alpha,camel,handles);
handles.v=OBStacles;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Obstacle_numb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Obstacle_numb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in obstacle_loc.
function obstacle_loc_Callback(hObject, eventdata, handles)
% hObject    handle to obstacle_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns obstacle_loc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from obstacle_loc
b=get(handles.obstacle_loc,'Value');

    if b==1 
    c= '';   
    elseif b==2
     c=1;
    elseif b== 3
     c=2; 
    end
    handles.obst=c;
    guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function obstacle_loc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to obstacle_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in size_arena.
function size_arena_Callback(hObject, eventdata, handles)
% hObject    handle to size_arena (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns size_arena contents as cell array
%        contents{get(hObject,'Value')} returns selected item from size_arena
g=get(handles.size_arena,'Value');

    if g==1 
    i= '';   
    elseif g==2
     i=[0,0,840,600];
    end
    handles.arens=i;
    guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function size_arena_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size_arena (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in target_pos.
function target_pos_Callback(hObject, eventdata, handles)
% hObject    handle to target_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns target_pos contents as cell array
%        contents{get(hObject,'Value')} returns selected item from target_pos
k=get(handles.target_pos,'Value');

    if k==1 
    l= '';   
    elseif k==2
     l=1;
    elseif k== 3
     l=2; 
    end
    handles.targ=l;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function target_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to target_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on selection change in target_detail.
function target_detail_Callback(hObject, eventdata, handles)
% hObject    handle to target_detail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns target_detail contents as cell array
%        contents{get(hObject,'Value')} returns selected item from target_detail

m=get(handles.target_detail,'Value');
beta=handles.targ;
o=handles.arens;
if m==1 && beta==1
    n= '';
elseif m==2 && beta==1
    n=1;
elseif m==3 && beta==1
    n=2;
elseif m==4 && beta==1
    n=3;
elseif m== 5 && beta==1
    n=4;
elseif m== 6 && beta==1
    n=5;
elseif m==1 && beta==2
    n= '';
elseif m==2 && beta==2
    n=1;
elseif m== 3 && beta==2
    n=2;
elseif m==4 && beta==2
    n=3;
elseif m== 5 && beta==2
    n=4;
elseif m== 6 && beta==2
    n=5;
end

frt=handles.gotabs;
% arna=handles.w;

[AREna TARGet]=createtarget2(o,n,beta,frt,handles);
handles.u=TARGet;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function target_detail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to target_detail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clearing.
function clearing_Callback(hObject, eventdata, handles)
% hObject    handle to clearing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arrayfun(@cla,findall(0,'type','axes'))

% --- Executes on button press in saving.
function saving_Callback(hObject, eventdata, handles)
% hObject    handle to saving (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name = 'S_c';
TARGET=handles.u;
OBSTACLES= handles.v;
ARENA=handles.w;
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
fullName = strcat(path2,name);
zdir = [1 0 0];

Fig2 = figure;
copyobj(handles.Arena_axis, Fig2);
lado = handles.arens;
Aw = lado(3);
Ah = lado(4);

grid off
% set(Fig2, 'Units', 'pixels', 'position', [0 0 Aw+1 Ah+1 ]);
set(Fig2, 'Units', 'pixels', 'position', [0 0 Aw-80 Ah-20 ]);
% set(Fig2, 'paperunits', 'points', 'papersize', [Aw+1 Ah+1]);
saveas(Fig2,fullName,'png');
delete(Fig2);

handles.p1 = path1;
handles.p2 = path2;
save(fullName,'ARENA','OBSTACLES', 'TARGET')
guidata(hObject,handles);

% --- Executes on button press in closing.
function closing_Callback(hObject, eventdata, handles)
% hObject    handle to closing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% --- Executes on key press with focus on Obstacle_numb and none of its controls.
function Obstacle_numb_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Obstacle_numb (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in mng.
function mng_Callback(hObject, eventdata, handles)
% hObject    handle to mng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mng contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mng
butters=get(handles.mng,'Value');

    if butters==1 
    candysi= '';   
    elseif butters==2
     candysi=1;
    elseif butters== 3
      candysi=2; 
    end
    handles.gotab= candysi;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function mng_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in statnry.
function statnry_Callback(hObject, eventdata, handles)
% hObject    handle to statnry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns statnry contents as cell array
%        contents{get(hObject,'Value')} returns selected item from statnry
butters1=get(handles.statnry,'Value');

    if butters1==1 
    candysii= '';   
    elseif butters1==2
     candysii=1;
    elseif butters1== 3
      candysii=2; 
    end
    handles.gotabs= candysii;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function statnry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to statnry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Arena_axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Arena_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Arena_axis

% --- Executes on mouse press over axes background.
function Arena_axis_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Arena_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
