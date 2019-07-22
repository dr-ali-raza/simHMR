function varargout = Robot_GUI_2(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Robot configurations
% AI & Robotics Lab
% University of Engineering and Technology, Lahore
% ==========================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROBOT_GUI_2 MATLAB code for Robot_GUI_2.fig
%      ROBOT_GUI_2, by itself, creates a new ROBOT_GUI_2 or raises the existing
%      singleton*.
%
%      H = ROBOT_GUI_2 returns the handle to a new ROBOT_GUI_2 or the handle to
%      the existing singleton*.
%
%      ROBOT_GUI_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOT_GUI_2.M with the given input arguments.
%
%      ROBOT_GUI_2('Property','Value',...) creates a new ROBOT_GUI_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Robot_GUI_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Robot_GUI_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Robot_GUI_2

% Last Modified by GUIDE v2.5 22-Nov-2013 21:39:17

% Begin initialization code - DO NOT EDIT
set(0,'DefaultFigureWindowStyle','docked')
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Robot_GUI_2_OpeningFcn, ...
                   'gui_OutputFcn',  @Robot_GUI_2_OutputFcn, ...
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

% --- Executes just before Robot_GUI_2 is made visible.
function Robot_GUI_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Robot_GUI_2 (see VARARGIN)

% Choose default command line output for Robot_GUI_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Robot_GUI_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Robot_GUI_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in no_of_robot.
function no_of_robot_Callback(hObject, eventdata, handles)
% hObject    handle to no_of_robot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns no_of_robot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from no_of_robot
charlie=get(handles.no_of_robot,'Value');

if charlie==1
    nts= '';
elseif charlie==2
    nts=1;
elseif charlie== 3
    nts=2;
elseif charlie==4
    nts=3;
elseif charlie==5
    nts=4;
end
handles.no_robot=nts;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function no_of_robot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to no_of_robot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in actuatn.
function actuatn_Callback(hObject, eventdata, handles)
% hObject    handle to actuatn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns actuatn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from actuatn
ang=get(handles.actuatn,'Value');%ang==2 without kinematics; ang==3 with kinematics

sale=handles.sel;% user-defined=1; random==2;
if ang==1
    dis= '';
elseif ang==2 && sale==1
    dis=1;
    aaa= handles.no_robot;%without kinematics
    hh=handles.no1_robot;
    if aaa==1
        hh=hh;
        ii=[];
        jj=[];
        kk=[];
    elseif aaa==2
        hh=hh;
        ii=handles.no2_robot;
        jj=[];
        kk=[];
    elseif aaa==3
        hh=hh;
        ii=handles.no2_robot;
        jj=handles.no3_robot;
        kk=[];
    elseif aaa==4
        hh=hh;
        ii=handles.no2_robot;
        jj=handles.no3_robot;
        kk=handles.no4_robot;
    end
    bb=[hh;ii;jj;kk];
    handles.init_cndtn=bb;
    mm= handles.no11_robot;
    if aaa==1
        mm=mm;
        nn=[];
        oo=[];
        pp=[];
    elseif aaa==2
        mm=mm;
        nn= handles.no21_robot;
        oo=[];
        pp=[];
    elseif aaa==3
        mm=mm;
        nn= handles.no21_robot;
        oo= handles.no31_robot;
        pp=[];
    elseif aaa==4
        mm=mm;
        nn= handles.no21_robot;
        oo= handles.no31_robot;
        pp= handles.no41_robot;
    end
    cc=[mm;nn;oo;pp];
    handles.vw_angl=cc;
    ss=handles.no111_robot;
    if aaa==1
        ss=ss;
        tt=[];
        uu=[];
        vv=[];
    elseif aaa==2
        ss=ss;
        tt=handles.no222_robot;
        uu=[];
        vv=[];
    elseif aaa==3
        ss=ss;
        tt=handles.no222_robot;
        uu=handles.no333_robot;
        vv=[];
    elseif aaa==4
        ss=ss;
        tt=handles.no222_robot;
        uu=handles.no333_robot;
        vv=handles.no444_robot;
    end
    dd=[ss;tt;uu;vv];
    handles.sensr_range=dd;
    with_out_kinem(dd,cc,aaa,bb)
elseif ang== 3 && sale==1
    dis=2; %with kinematics
    aaa1= handles.no_robot;%with kinematics
    hh1=handles.no1_robot;
    if aaa1==1
        hh1=hh1;
        ii1=[];
        jj1=[];
        kk1=[];
    elseif aaa1==2
        hh1=hh1;
        ii1=handles.no2_robot;
        jj1=[];
        kk1=[];
    elseif aaa1==3
        hh1=hh1;
        ii1=handles.no2_robot;
        jj1=handles.no3_robot;
        kk1=[];
    elseif aaa1==4
        hh1=hh1;
        ii1=handles.no2_robot;
        jj1=handles.no3_robot;
        kk1=handles.no4_robot;
    end
    bb1=[hh1;ii1;jj1;kk1];
    handles.init_cndtn1=bb1;
    mm1= handles.no11_robot;
    if aaa1==1
        mm1=mm1;
        nn1=[];
        oo1=[];
        pp1=[];
    elseif aaa1==2
        mm1=mm1;
        nn1= handles.no21_robot;
        oo1=[];
        pp1=[];
    elseif aaa1==3
        mm1=mm1;
        nn1= handles.no21_robot;
        oo1= handles.no31_robot;
        pp1=[];
    elseif aaa1==4
        mm1=mm1;
        nn1= handles.no21_robot;
        oo1= handles.no31_robot;
        pp1= handles.no41_robot;
    end
    cc1=[mm1;nn1;oo1;pp1];
    handles.vw_angl1=cc1;
    ss1=handles.no111_robot;
    if aaa1==1
        ss1=ss1;
        tt1=[];
        uu1=[];
        vv1=[];
    elseif aaa1==2
        ss1=ss1;
        tt1=handles.no222_robot;
        uu1=[];
        vv1=[];
    elseif aaa1==3
        ss1=ss1;
        tt1=handles.no222_robot;
        uu1=handles.no333_robot;
        vv1=[];
    elseif aaa1==4
        ss1=ss1;
        tt1=handles.no222_robot;
        uu1=handles.no333_robot;
        vv1=handles.no444_robot;
    end
    dd1=[ss1;tt1;uu1;vv1];
    handles.sensr_range1=dd1;
    with_out_kinem(dd1,cc1,aaa1,bb1)
elseif ang==2 && sale==2
    no_ro=handles.no_robot;
    dis=3;
    CON1=handles.CNd1 ;
    ANG1=handles.ANv1;
    RGE1=handles.RAN1 ;
    with_out_kinem(RGE1,ANG1,no_ro,CON1)
 
    handles.init_CND2=CON1;
    handles.VEW_ANL2=ANG1;
    handles.RNGE2=RGE1;
elseif ang==3 && sale==2
    no_ro3=handles.no_robot;
    dis=4;
    CON3=handles.CNd1 ;
    ANG3=handles.ANv1;
    RGE3=handles.RAN1 ;
    with_out_kinem(RGE3,ANG3,no_ro3,CON3)
    
    handles.init_CND3=CON3;
    handles.VEW_ANL3=ANG3;
    handles.RNGE3=RGE3;
    
end
handles.anct=dis;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function actuatn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to actuatn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in doing.
function doing_Callback(hObject, eventdata, handles)
% hObject    handle to doing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

KINEM=handles.anct;

name = 'S_d';
path1 = pwd;
path2 = strcat(path1,'\saved_figrs\');
fullName = strcat(path2,name);

if KINEM==1
    ROBOT_NO= handles.no_robot;
    INITIAL_CNDITION= handles.init_cndtn;
    VIEW_ANGLE= handles.vw_angl;
    SENSOR_RANGE=handles.sensr_range;
    save(fullName,'KINEM','ROBOT_NO', 'INITIAL_CNDITION','VIEW_ANGLE','SENSOR_RANGE')
elseif KINEM==2
    ROBOT_NO= handles.no_robot;
    INITIAL_CNDITION= handles.init_cndtn1;
    VIEW_ANGLE= handles.vw_angl1;
    SENSOR_RANGE=handles.sensr_range1;
    save(fullName,'KINEM','ROBOT_NO', 'INITIAL_CNDITION','VIEW_ANGLE','SENSOR_RANGE')
elseif KINEM==3
    ROBOT_NO= handles.no_robot;
    INITIAL_CNDITION= handles.init_CND2;
    VIEW_ANGLE =handles.VEW_ANL2;
    SENSOR_RANGE=handles.RNGE2;
    save(fullName,'KINEM','ROBOT_NO', 'INITIAL_CNDITION','VIEW_ANGLE','SENSOR_RANGE')
elseif KINEM==4
    ROBOT_NO= handles.no_robot;
    INITIAL_CNDITION= handles.init_CND3;
    VIEW_ANGLE= handles.VEW_ANL3;
    SENSOR_RANGE=handles.RNGE3;
    save(fullName,'KINEM','ROBOT_NO', 'INITIAL_CNDITION','VIEW_ANGLE','SENSOR_RANGE')
end
% --- Executes on button press in clsng.
function clsng_Callback(hObject, eventdata, handles)
% hObject    handle to clsng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% --- Executes on selection change in viw1_angl.
function viw1_angl_Callback(hObject, eventdata, handles)
% hObject    handle to viw1_angl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns viw1_angl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from viw1_angl
delta1=get(handles.viw1_angl,'Value');
colg1=handles.no_robot;

if delta1==1
    acs= '';
elseif delta1==2 && colg1==1
    acs=pi;
elseif delta1==3 && colg1==1
    acs=5*pi/6;
elseif delta1==4 && colg1==1
    acs=2*pi/3;
elseif delta1==5 && colg1==1
    acs=pi/2;
elseif delta1==2 && colg1==2
    acs=pi;
elseif delta1==3 && colg1==2
    acs=5*pi/6;
elseif delta1==4 && colg1==2
    acs=2*pi/3;
elseif delta1==5 && colg1==2
    acs=pi/2;
elseif delta1==2 && colg1==3
    acs=pi;
elseif delta1==3 && colg1==3
    acs=5*pi/6;
elseif delta1==4 && colg1==3
    acs=2*pi/3;
elseif delta1==5 && colg1==3
    acs=pi/2;
elseif delta1==2 && colg1==4
    acs=pi;
elseif delta1==3 && colg1==4
    acs=5*pi/6;
elseif delta1==4 && colg1==4
    acs=2*pi/3;
elseif delta1==5 && colg1==4
    acs=pi/2;
end
handles.no11_robot=acs;

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function viw1_angl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viw1_angl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in initia1_condition.
function initia1_condition_Callback(hObject, eventdata, handles)
% hObject    handle to initia1_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns initia1_condition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from initia1_condition

sgma1=get(handles.initia1_condition,'Value');

etta1=handles.no_robot;
if sgma1==1
    pcs= '';
elseif sgma1==2 && etta1==1
    pcs=[700 500 pi];
elseif sgma1==3 && etta1==1
    pcs=[400 100 pi/2];
elseif sgma1==4 && etta1==1
    pcs=[100 100 pi/2];
elseif sgma1==5 && etta1==1
    pcs=[100 300 pi/2];
elseif sgma1==2 && etta1==2
    pcs=[700 500 pi];
elseif sgma1==3 && etta1==2
    pcs=[400 100 pi/2];
elseif sgma1==4 && etta1==2
    pcs=[100 100 pi/2];
elseif sgma1==5 && etta1==2
    pcs=[100 300 pi/2];
elseif sgma1==2 && etta1==3
    pcs=[700 500 pi];
elseif sgma1==3 && etta1==3
    pcs=[400 100 pi/2];
elseif sgma1==4 && etta1==3
    pcs=[100 100 pi/2];
elseif sgma1==5 && etta1==3
    pcs=[100 300 pi/2];
elseif sgma1==2 && etta1==4
    pcs=[700 500 pi];
elseif sgma1==3 && etta1==4
    pcs=[400 100 pi/2];
elseif sgma1==4 && etta1==4
    pcs=[100 100 pi/2];
elseif sgma1==5 && etta1==4
    pcs=[100 300 pi/2];
end
    handles.no1_robot=pcs;
      
    guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function initia1_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initia1_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in sensr1_rng.
function sensr1_rng_Callback(hObject, eventdata, handles)
% hObject    handle to sensr1_rng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sensr1_rng contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sensr1_rng
ants1=get(handles.sensr1_rng,'Value');
lemma1=handles.no_robot;
    if ants1==1 && lemma1==1
    dep1= '';   
    elseif ants1==2 && lemma1==1
     dep1=150;
    elseif ants1== 3 && lemma1==1
     dep1=250; 
    elseif ants1==4 && lemma1==1
     dep1=350;
    elseif ants1==5 && lemma1==1
     dep1=450;
     elseif ants1==2 && lemma1==2
     dep1=150;
    elseif ants1== 3 && lemma1==2
     dep1=250; 
    elseif ants1==4 && lemma1==2
     dep1=350;
    elseif ants1==5 && lemma1==2
     dep1=450;
    elseif ants1==2 && lemma1==3
     dep1=150;
    elseif ants1== 3 && lemma1==3
     dep1=250; 
    elseif ants1==4 && lemma1==3
     dep1=350;
    elseif ants1==5 && lemma1==3
     dep1=450; 
    elseif ants1==2 && lemma1==4
     dep1=150;
    elseif ants1== 3 && lemma1==4
     dep1=250; 
    elseif ants1==4 && lemma1==4
     dep1=350;
    elseif ants1==5 && lemma1==4
     dep1=450; 
    end
    handles.no111_robot=dep1;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function sensr1_rng_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensr1_rng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in initia2_condition.
function initia2_condition_Callback(hObject, eventdata, handles)
% hObject    handle to initia2_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns initia2_condition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from initia2_condition

sgma2=get(handles.initia2_condition,'Value');

    etta2=handles.no_robot;
     if sgma2==1 
    chs= '';  
   elseif sgma2==2 && etta2==1
     chs=[700 500 pi];
    elseif sgma2==3 && etta2==1
     chs=[400 100 pi/2];
    elseif sgma2==4 && etta2==1
     chs=[100 100 pi/2]; 
    elseif sgma2==5 && etta2==1
     chs=[100 300 pi/2];
    elseif sgma2==2 && etta2==2
     chs=[700 500 pi];
    elseif sgma2==3 && etta2==2
     chs=[400 100 pi/2];
    elseif sgma2==4 && etta2==2
     chs=[700 100 pi/2]; 
    elseif sgma2==5 && etta2==2
     chs=[100 300 pi/2]; 
    elseif sgma2==2 && etta2==3
     chs=[100 500 pi];
    elseif sgma2==3 && etta2==3
     chs=[400 100 pi/2];
    elseif sgma2==4 && etta2==3
     chs=[100 100 pi/2]; 
    elseif sgma2==5 && etta2==3
     chs=[100 300 pi/2];
    elseif sgma2==2 && etta2==4
     chs=[700 500 pi];
    elseif sgma2==3 && etta2==4
     chs=[400 100 pi/2];
    elseif sgma2==4 && etta2==4
     chs=[100 100 pi/2]; 
    elseif sgma2==5 && etta2==4
     chs=[100 300 pi/2];
    end 
  
 handles.no2_robot=chs;
 guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function initia2_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initia2_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in initia3_condition.
function initia3_condition_Callback(hObject, eventdata, handles)
% hObject    handle to initia3_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns initia3_condition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from initia3_condition
sgma3=get(handles.initia3_condition,'Value');

    etta3=handles.no_robot;
     if sgma3==1 
    tcs= '';  
     elseif sgma3==2 && etta3==1
     tcs=[700 500 pi];
    elseif sgma3==3 && etta3==1
     tcs=[400 100 pi/2];
    elseif sgma3==4 && etta3==1
     tcs=[100 100 pi/2]; 
    elseif sgma3==5 && etta3==1
     tcs=[100 300 pi/2];
    elseif sgma3==2 && etta3==2
     tcs=[700 500 pi];
    elseif sgma3==3 && etta3==2
     tcs=[400 100 pi/2];
    elseif sgma3==4 && etta3==2
     tcs=[100 100 pi/2]; 
    elseif sgma3==5 && etta3==2
     tcs=[100 300 pi/2];
    elseif sgma3==2 && etta3==3
     tcs=[700 500 pi];
    elseif sgma3==3 && etta3==3
     tcs=[400 100 pi/2];
    elseif sgma3==4 && etta3==3
     tcs=[100 100 pi/2]; 
    elseif sgma3==5 && etta3==3
     tcs=[100 300 pi/2];
    elseif sgma3==2 && etta3==4
     tcs=[700 500 pi];
    elseif sgma3==3 && etta3==4
     tcs=[400 100 pi/2];
    elseif sgma3==4 && etta3==4
     tcs=[100 100 pi/2]; 
    elseif sgma3==5 && etta3==4
     tcs=[100 300 pi/2];
    end 
 handles.no3_robot=tcs;
 guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function initia3_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initia3_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in initia4_condition.
function initia4_condition_Callback(hObject, eventdata, handles)
% hObject    handle to initia4_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns initia4_condition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from initia4_condition
sgma4=get(handles.initia4_condition,'Value');

    etta4=handles.no_robot;
     if sgma4==1 
    qhs= ''; 
    elseif sgma4==2 && etta4==1
     qhs=[700 500 pi];
    elseif sgma4==3 && etta4==1
     qhs=[400 100 pi/2];
    elseif sgma4==4 && etta4==1
     qhs=[100 100 pi/2]; 
    elseif sgma4==5 && etta4==1
     qhs=[100 300 pi/2];
    elseif sgma4==2 && etta4==2
     qhs=[700 500 pi];
    elseif sgma4==3 && etta4==2
     qhs=[400 100 pi/2];
    elseif sgma4==4 && etta4==2
     qhs=[100 100 pi/2]; 
    elseif sgma4==5 && etta4==2
     qhs=[100 300 pi/2];
    elseif sgma4==2 && etta4==3
     qhs=[700 500 pi];
    elseif sgma4==3 && etta4==3
     qhs=[400 100 pi/2];
    elseif sgma4==4 && etta4==3
     qhs=[100 100 pi/2]; 
    elseif sgma4==5 && etta4==3
     qhs=[100 300 pi/2];
    elseif sgma4==2 && etta4==4
     qhs=[700 500 pi];
    elseif sgma4==3 && etta4==4
     qhs=[400 100 pi/2];
    elseif sgma4==4 && etta4==4
     qhs=[100 100 pi/2]; 
    elseif sgma4==5 && etta4==4
     qhs=[100 300 pi/2];
    end 
 handles.no4_robot=qhs;
  guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function initia4_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initia4_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in sensr2_rng.
function sensr2_rng_Callback(hObject, eventdata, handles)
% hObject    handle to sensr2_rng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sensr2_rng contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sensr2_rng
ants2=get(handles.sensr2_rng,'Value');
lemma2=handles.no_robot;
    if ants2==1 && lemma2==1
    dep2= '';   
    elseif ants2==2 && lemma2==1
     dep2=150;
    elseif ants2== 3 && lemma2==1
     dep2=250; 
    elseif ants2==4 && lemma2==1
     dep2=350;
    elseif ants2==5 && lemma2==1
     dep2=450;
    elseif ants2==2 && lemma2==2
     dep2=150;
    elseif ants2== 3 && lemma2==2
     dep2=250; 
    elseif ants2==4 && lemma2==2
     dep2=350;
    elseif ants2==5 && lemma2==2
     dep2=450;
    elseif ants2==2 && lemma2==3
     dep2=150;
    elseif ants2== 3 && lemma2==3
     dep2=250; 
    elseif ants2==4 && lemma2==3
     dep2=350;
    elseif ants2==5 && lemma2==3
     dep2=450; 
    elseif ants2==2 && lemma2==4
     dep2=150;
    elseif ants2== 3 && lemma2==4
     dep2=250; 
    elseif ants2==4 && lemma2==4
     dep2=350;
    elseif ants2==5 && lemma2==4
     dep2=450; 
    end
    handles.no222_robot=dep2;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function sensr2_rng_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensr2_rng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in snsr3_rng.
function snsr3_rng_Callback(hObject, eventdata, handles)
% hObject    handle to snsr3_rng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns snsr3_rng contents as cell array
%        contents{get(hObject,'Value')} returns selected item from snsr3_rng
ants3=get(handles.snsr3_rng,'Value');
lemma3=handles.no_robot;
    if ants3==1 && lemma3==1
    dep3= '';   
    elseif ants3==2 && lemma3==1
     dep3=150;
    elseif ants3== 3 && lemma3==1
     dep3=250; 
    elseif ants3==4 && lemma3==1
     dep3=350;
    elseif ants3==5 && lemma3==1
     dep3=450;
    elseif ants3==2 && lemma3==2
     dep3=150;
    elseif ants3== 3 && lemma3==2
     dep3=250; 
    elseif ants3==4 && lemma3==2
     dep3=350;
    elseif ants3==5 && lemma3==2
     dep3=450;
    elseif ants3==2 && lemma3==3
     dep3=150;
    elseif ants3== 3 && lemma3==3
     dep3=250; 
    elseif ants3==4 && lemma3==3
     dep3=350;
    elseif ants3==5 && lemma3==3
     dep3=450;
      elseif ants3==2 && lemma3==4
     dep3=150;
    elseif ants3== 3 && lemma3==4
     dep3=250; 
    elseif ants3==4 && lemma3==4
     dep3=350;
    elseif ants3==5 && lemma3==4
     dep3=450; 
    end
    handles.no333_robot=dep3;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function snsr3_rng_CreateFcn(hObject, eventdata, handles)
% hObject    handle to snsr3_rng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in viw2_angl.
function viw2_angl_Callback(hObject, eventdata, handles)
% hObject    handle to viw2_angl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns viw2_angl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from viw2_angl
delta2=get(handles.viw2_angl,'Value');
colg2=handles.no_robot;
 
if delta2==1
    bcs= '';
elseif delta2==2 && colg2==1
    bcs=pi;
elseif delta2==3 && colg2==1
    bcs=5*pi/6;
elseif delta2==4 && colg2==1
    bcs=2*pi/3;
elseif delta2==5 && colg2==1
    bcs=pi/2;
elseif delta2==2 && colg2==2
    bcs=pi;
elseif delta2==3 && colg2==2
    bcs=5*pi/6;
elseif delta2==4 && colg2==2
    bcs=2*pi/3;
elseif delta2==5 && colg2==2
    bcs=pi/2;
elseif delta2==2 && colg2==3
    bcs=pi;
elseif delta2==3 && colg2==3
    bcs=5*pi/6;
elseif delta2==4 && colg2==3
    bcs=2*pi/3;
elseif delta2==5 && colg2==3
    bcs=pi/2;
elseif delta2==2 && colg2==4
    bcs=pi;
elseif delta2==3 && colg2==4
    bcs=5*pi/6;
elseif delta2==4 && colg2==4
    bcs=2*pi/3;
elseif delta2==5 && colg2==4
    bcs=pi/2;
end
handles.no21_robot=bcs;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function viw2_angl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viw2_angl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in viw3_angl.
function viw3_angl_Callback(hObject, eventdata, handles)
% hObject    handle to viw3_angl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns viw3_angl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from viw3_angl
delta3=get(handles.viw3_angl,'Value');
colg3=handles.no_robot;

if delta3==1
    dcs= '';
elseif delta3==2 && colg3==1
    dcs=pi;
elseif delta3==3 && colg3==1
    dcs=5*pi/6;
elseif delta3==4 && colg3==1
    dcs=2*pi/3;
elseif delta3==5 && colg3==1
    dcs=pi/2;
elseif delta3==2 && colg3==2
    dcs=pi;
elseif delta3==3 && colg3==2
    dcs=5*pi/6;
elseif delta3==4 && colg3==2
    dcs=2*pi/3;
elseif delta3==5 && colg3==2
    dcs=pi/2;
elseif delta3==2 && colg3==3
    dcs=pi;
elseif delta3==3 && colg3==3
    dcs=5*pi/6;
elseif delta3==4 && colg3==3
    dcs=2*pi/3;
elseif delta3==5 && colg3==3
    dcs=pi/2;
elseif delta3==2 && colg3==4
    dcs=pi;
elseif delta3==3 && colg3==4
    dcs=5*pi/6;
elseif delta3==4 && colg3==4
    dcs=2*pi/3;
elseif delta3==5 && colg3==4
    dcs=pi/2;
end
handles.no31_robot=dcs;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function viw3_angl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viw3_angl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in viw4_angl.
function viw4_angl_Callback(hObject, eventdata, handles)
% hObject    handle to viw4_angl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns viw4_angl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from viw4_angl
delta4=get(handles.viw4_angl,'Value');
colg4=handles.no_robot;

if delta4==1
    mcs= '';
elseif delta4==2 && colg4==1
    mcs=pi;
elseif delta4==3 && colg4==1
    mcs=5*pi/6;
elseif delta4==4 && colg4==1
    mcs=2*pi/3;
elseif delta4==5 && colg4==1
    mcs=pi/2;
elseif delta4==2 && colg4==2
    mcs=pi;
elseif delta4==3 && colg4==2
    mcs=5*pi/6;
elseif delta4==4 && colg4==2
    mcs=2*pi/3;
elseif delta4==5 && colg4==2
    mcs=pi/2;
elseif delta4==2 && colg4==3
    mcs=pi;
elseif delta4==3 && colg4==3
    mcs=5*pi/6;
elseif delta4==4 && colg4==3
    mcs=2*pi/3;
elseif delta4==5 && colg4==3
    mcs=pi/2;
elseif delta4==2 && colg4==4
    mcs=pi;
elseif delta4==3 && colg4==4
    mcs=5*pi/6;
elseif delta4==4 && colg4==4
    mcs=2*pi/3;
elseif delta4==5 && colg4==4
    mcs=pi/2;
end
handles.no41_robot=mcs;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function viw4_angl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viw4_angl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in snsr4_rng.
function snsr4_rng_Callback(hObject, eventdata, handles)
% hObject    handle to snsr4_rng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns snsr4_rng contents as cell array
%        contents{get(hObject,'Value')} returns selected item from snsr4_rng
ants4=get(handles.snsr4_rng,'Value');
lemma4=handles.no_robot;
if ants4==1 && lemma4==1
    dep4= '';
elseif ants4==2 && lemma4==1
    dep4=150;
elseif ants4== 3 && lemma4==1
    dep4=250;
elseif ants4==4 && lemma4==1
    dep4=350;
elseif ants4==5 && lemma4==1
    dep4=450;
elseif ants4==2 && lemma4==2
    dep4=150;
elseif ants4== 3 && lemma4==2
    dep4=250;
elseif ants4==4 && lemma4==2
    dep4=350;
elseif ants4==5 && lemma4==2
    dep4=450;
elseif ants4==2 && lemma4==3
    dep4=150;
elseif ants4== 3 && lemma4==3
    dep4=250;
elseif ants4==4 && lemma4==3
    dep4=350;
elseif ants4==5 && lemma4==3
    dep4=450;
elseif ants4==2 && lemma4==4
    dep4=150;
elseif ants4== 3 && lemma4==4
    dep4=250;
elseif ants4==4 && lemma4==4
    dep4=350;
elseif ants4==5 && lemma4==4
    dep4=450;
end
    handles.no444_robot=dep4;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function snsr4_rng_CreateFcn(hObject, eventdata, handles)
% hObject    handle to snsr4_rng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in clring.
function clring_Callback(hObject, eventdata, handles)
% hObject    handle to clring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arrayfun(@cla,findall(0,'type','axes'))

% --- Executes on button press in usr_dfn.
%function usr_dfn_Callback(hObject, eventdata, handles)
% hObject    handle to usr_dfn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of usr_dfn
%andfi=get(handles.usr_dfn,'Value');

    %if andfi==0
   %sandfi=1;
    %elseif andfi==1
     % sandfi=2; 
    %end
   %handles.usf=sandfi;
  %  guidata(hObject,handles);

% --- Executes on button press in cndition2.

% --- Executes on button press in cndition4.

% --- Executes on button press in cnditon3.

% --- Executes on button press in cndition1.
function cndition1_Callback(hObject, eventdata, handles)
% hObject    handle to cndition1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cndition1
cn1=get(handles.cndition1,'Value');
aaa11= handles.no_robot;%without kinematics

   SEL111=handles.sel; 
   
   if cn1==0 && SEL111==2
       sandfil1=1;
   elseif cn1==1 && aaa11==1 && SEL111==2
       sandfil1=2;
       ic14         = [400 100 pi/2];
       ic15         =[];
       ic16         =[];
       ic17         =[];
   elseif  cn1==1 && aaa11==2 && SEL111==2
       ic14         = [400 100 pi/2];
       ic15         = [100 100 pi/2];
       ic16         =[];
       ic17         =[];
   elseif cn1==1 && aaa11==3 && SEL111==2
       ic14         = [400 100 pi/2];
       ic15         = [100 100 pi/2];
       ic16         = [400 500 0];
       ic17=[];
   elseif cn1==1 && aaa11==4 && SEL111==2
       
       ic14         = [400 100 pi/2];
       ic15         = [100 100 pi/2];
       ic16        = [400 500 0];
       ic17        = [700 500 pi];
   end
   
   Cnd1=[ic14;ic15;ic16;ic17];
   
   handles.CNd1=Cnd1;
   guidata(hObject,handles);

% --- Executes on button press in an_val1.
function an_val1_Callback(hObject, eventdata, handles)
% hObject    handle to an_val1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of an_val1
an1=get(handles.an_val1,'Value');
aaa21= handles.no_robot;%without kinematics
SEL11=handles.sel;
    if an1==0 && SEL11==2
   sandfil1=1;
    elseif an1==1 && aaa21==1 && SEL11==2
      sandfil1=2; 
        sSpan1 = pi/2;
        sSpan2=[];
        sSpan3=[];
        sSpan4=[];
    elseif an1==1 && aaa21==2 && SEL11==2
        sSpan1 = pi/2;
        sSpan2=5*pi/6;
        sSpan3=[];
        sSpan4=[];
    elseif an1==1 && aaa21==3 && SEL11==2
        sSpan1 = pi/2;
        sSpan2=5*pi/6;
        sSpan3=2*pi/3;
        sSpan4=[];
     elseif an1==1 && aaa21==4 && SEL11==2
        sSpan1 = pi/2;
        sSpan2=5*pi/6;
        sSpan3=2*pi/3;
        sSpan4=pi;
    end
    Anv1=[sSpan1;sSpan2;sSpan3;sSpan4];
   handles.ANv1=Anv1;
   guidata(hObject,handles);  

% --- Executes on button press in an_val3.

% --- Executes on button press in an_val4.

% --- Executes on button press in an_val2.

% --- Executes on button press in rngs_2.
 
% --- Executes on button press in rngs_4.

% --- Executes on button press in rngs_3.

% --- Executes on button press in rngs_1.
function rngs_1_Callback(hObject, eventdata, handles)
% hObject    handle to rngs_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rngs_1
rn1=get(handles.rngs_1,'Value');
ran1= handles.no_robot;%without kinematics
SEL1=handles.sel;
if rn1==0 && SEL1==2
    sandfill1=1;
elseif rn1==1 && ran1==1 && SEL1==2
    sandfill1=2;
    sDep14=150;
    sDep15=250;
    sDep16=350;
    sDep17=[];
elseif rn1==1 && ran1==2 && SEL1==2
    sDep14=150;
    sDep15=250;
    sDep16=[];
    sDep17=[];
elseif rn1==1 && ran1==3 && SEL1==2
    sDep14=150;
    sDep15=250;
    sDep16=350;
    sDep17=[];
elseif rn1==1 && ran1==4 && SEL1==2
    sDep14=150;
    sDep15=250;
    sDep16=350;
    sDep17=450;
end
Rn1=[sDep14;sDep15;sDep16;sDep17];

handles.RAN1=Rn1;
guidata(hObject,handles);

% --- Executes on selection change in ran_use.
function ran_use_Callback(hObject, eventdata, handles)
% hObject    handle to ran_use (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ran_use contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ran_use
chan=get(handles.ran_use,'Value');

    if chan==1 
    ns= '';   
    elseif chan==2
     ns=1;
    elseif chan== 3
     ns=2; 
    end
    handles.sel=ns;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ran_use_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ran_use (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
