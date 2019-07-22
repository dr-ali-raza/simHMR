function varargout = Robot_GUI_3(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experiment Execution
% AI & Robotics Lab
% University of Engineering and Technology, Lahore
% ==========================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROBOT_GUI_3 MATLAB code for Robot_GUI_3.fig
%      ROBOT_GUI_3, by itself, creates a new ROBOT_GUI_3 or raises the existing
%      singleton*.
%
%      H = ROBOT_GUI_3 returns the handle to a new ROBOT_GUI_3 or the handle to
%      the existing singleton*.
%
%      ROBOT_GUI_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOT_GUI_3.M with the given input arguments.
%
%      ROBOT_GUI_3('Property','Value',...) creates a new ROBOT_GUI_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Robot_GUI_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Robot_GUI_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Robot_GUI_3

% Last Modified by GUIDE v2.5 02-Dec-2013 11:59:03

% Begin initialization code - DO NOT EDIT
set(0,'DefaultFigureWindowStyle','docked')
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Robot_GUI_3_OpeningFcn, ...
                   'gui_OutputFcn',  @Robot_GUI_3_OutputFcn, ...
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

% --- Executes just before Robot_GUI_3 is made visible.
function Robot_GUI_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Robot_GUI_3 (see VARARGIN)

% Choose default command line output for Robot_GUI_3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Robot_GUI_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Robot_GUI_3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in tsk.
function tsk_Callback(hObject, eventdata, handles)
% hObject    handle to tsk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns tsk contents as cell array
%        contents{get(hObject,'Value')} returns selected item from tsk
gain=get(handles.tsk,'Value');

if gain==1
    ip= '';
elseif gain==2
    ip=1;
elseif gain== 3
    ip=2;
elseif gain==4
    ip=3;
end
handles.tsks=ip;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function tsk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tsk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in arna.
function arna_Callback(hObject, eventdata, handles)
% hObject    handle to arna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.siml_tor);

 arenaName = 'S_c';
 path1 = pwd;
 path2 = strcat(path1,'\saved_figrs\');
 arenaName = strcat(path2,arenaName);
 
 load(arenaName,'ARENA','OBSTACLES', 'TARGET')
 course = rgb2gray(imread(arenaName,'png'));
 course = flipud(course);
 course = imresize(course, [600 840]);
 h1 = imshow(course); 
%  axis image; 
 colormap gray;
 hold on;

handles.cour=h1;
handles.co=course;
guidata(hObject, handles);

% --- Executes on button press in rbt_cnfgr.
function rbt_cnfgr_Callback(hObject, eventdata, handles)
% hObject    handle to rbt_cnfgr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

arenaName = 'S_c';
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
arenaName = strcat(path2,arenaName);
load(arenaName,'ARENA','OBSTACLES', 'TARGET')

cnfigurename='S_d';
cnfigurename = strcat(path2,cnfigurename);
load(cnfigurename,'KINEM','ROBOT_NO', 'INITIAL_CNDITION','VIEW_ANGLE','SENSOR_RANGE')
%ab=KINEM;
bc=ROBOT_NO;
cd=INITIAL_CNDITION;
de=VIEW_ANGLE;
ef=SENSOR_RANGE;
with_out_kinem1(bc,cd,de,ef)
guidata(hObject, handles);

% --- Executes on button press in enrgy_tr.
function enrgy_tr_Callback(hObject, eventdata, handles)
% hObject    handle to enrgy_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.ener_tace);
%energyTrace         = [];
enrgy=handles.eere;
axis([0 length(enrgy) 0 max(enrgy)+100]);
plot(enrgy(1:end),'r'),
xlabel('Simulation Steps')
% ylabel('Energy Trace')
guidata(hObject, handles);

% --- Executes on button press in coll_trc.
function coll_trc_Callback(hObject, eventdata, handles)
% hObject    handle to coll_trc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.co_tace);
collison=handles.consi;
axis([0 length(collison) -0.5 1.5]);
plot(collison(1:end),'m')
% ylabel('Collision Trace')
xlabel('Simulation Steps')
guidata(hObject, handles);

% --- Executes on button press in tm_smltn.
function tm_smltn_Callback(hObject, eventdata, handles)
% hObject    handle to tm_smltn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timer=handles.casde;
azi=num2str(timer);
%zdisplay('bpm')
set(handles.sim_tm,'string',azi);
%set(handles.scnd,'string','seconds');

guidata(hObject,handles);

% --- Executes on selection change in apprch.
function apprch_Callback(hObject, eventdata, handles)
% hObject    handle to apprch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns apprch contents as cell array
%        contents{get(hObject,'Value')} returns selected item from apprch
bt=get(handles.apprch,'Value');
    if bt==1 
    ct= '';   
    elseif bt==2
     ct=1;
    elseif bt== 3
     ct=2; 
    end
    handles.vfhi=ct;
    guidata(hObject,handles);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function apprch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to apprch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in run_prgrm.
function run_prgrm_Callback(hObject, eventdata, handles)
% hObject    handle to run_prgrm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arenaName = 'S_c';
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
arenaName = strcat(path2,arenaName);
load(arenaName,'ARENA','OBSTACLES', 'TARGET')

cnfigurename ='S_d';
cnfigurename = strcat(path2,cnfigurename);

adf=handles.vfhi;%1==vfh ;
ajk=handles.tsks;%1==obstacle avoidance; 2==target seeking; 3==exploration
load(cnfigurename,'KINEM','ROBOT_NO', 'INITIAL_CNDITION','VIEW_ANGLE','SENSOR_RANGE')
ab=KINEM
bc=ROBOT_NO;
cd=INITIAL_CNDITION;
de=VIEW_ANGLE;
ef=SENSOR_RANGE;
fg=ARENA;
gh=OBSTACLES;
hi=TARGET;
ij=handles.cour;
jk=handles.co;
%with_out_kinem1(bc,cd,de,ef)
%%%without kinematics
if (ab==1 | ab==3)&& (adf==1)&&(ajk==1)
    [colliso energe appli]=obstacl_without_kinem(bc,cd,de,ef,hi,arenaName,ij,jk);
    %user_without_kinem2(ab,bc,cd,de,ef,fg,gh,hi,ij,jk)
elseif (ab==1 | ab==3)&& (adf==1)&&(ajk==2)
    [colliso energe appli]=target1_without_kinem(bc,cd,de,ef,hi,arenaName,ij,jk);
elseif (ab==1 | ab==3)&& (adf==1)&&(ajk==3)
    [colliso energe appli]=wanderer_without_kinem(bc,cd,de,ef,hi,arenaName);
%with kinematics
elseif (ab==2 | ab==4)&& (adf==1)&& (ajk==1)
    [colliso energe appli]=obstacle_with_kinem(bc,cd,de,ef,ij,jk,hi,arenaName);
    % user_with_kinem(bc,cd,de,ef,ij,jk,hi,arenaName)
elseif (ab==2 | ab==4)&& (adf==1)&& (ajk==2)
    [colliso energe appli]=targt_with_kinem(bc,cd,de,ef,ij,jk,hi,arenaName);
elseif (ab==2 | ab==4)&& (adf==1)&& (ajk==3)
    [colliso energe appli]=wandrer_with_kinem(bc,cd,de,ef,ij,jk,hi,arenaName);
end
% save(arenaName,'ARENA','OBSTACLES', 'TARGET')
handles.casde=appli;
handles.eere=energe;
handles.consi=colliso;
guidata(hObject, handles);
