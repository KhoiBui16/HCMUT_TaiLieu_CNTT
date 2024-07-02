function varargout = myOpenManipulator(varargin)
% MYOPENMANIPULATOR MATLAB code for myOpenManipulator.fig
%      MYOPENMANIPULATOR, by itself, creates a new MYOPENMANIPULATOR or raises the existing
%      singleton*.
%
%      H = MYOPENMANIPULATOR returns the handle to a new MYOPENMANIPULATOR or the handle to
%      the existing singleton*.
%
%      MYOPENMANIPULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYOPENMANIPULATOR.M with the given input arguments.
%
%      MYOPENMANIPULATOR('Property','Value',...) creates a new MYOPENMANIPULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before myOpenManipulator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to myOpenManipulator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help myOpenManipulator

% Last Modified by GUIDE v2.5 03-Dec-2022 17:00:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myOpenManipulator_OpeningFcn, ...
                   'gui_OutputFcn',  @myOpenManipulator_OutputFcn, ...
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


% --- Executes just before myOpenManipulator is made visible.
function myOpenManipulator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to myOpenManipulator (see VARARGIN)

% Choose default command line output for myOpenManipulator
handles.output = hObject;
rotate3d(handles.RobotView, 'on');
axis equal;
% Global Parameter
global theta1 theta2 theta3 theta4;
global old_theta_1 old_theta_2 old_theta_3 old_theta_4
set(handles.opacity,'Value',1);
ResetValue(handles);
theta1 = 0; theta2 = 0; theta3 = 0; theta4 =0;
old_theta_1 = 0; old_theta_2 = 0; old_theta_3 = 0; old_theta_4 = 0;
DrawRobot(theta1, theta2, theta3, theta4,handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes myOpenManipulator wait for user response (see UIRESUME)
% uiwait(handles.figure1);





% --- Outputs from this function are returned to the command line.
function varargout = myOpenManipulator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta1 = get(hObject,'Value');
set(handles.edit_theta1,'String', num2str(round(theta1,2)));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta2 = get(hObject,'Value');
set(handles.edit_theta2,'String', num2str(round(theta2,2)));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_theta3_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta3 = get(hObject,'Value');
set(handles.edit_theta3,'String', num2str(round(theta3,2)));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider_theta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta1 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta1 as a double


% --- Executes during object creation, after setting all properties.
function edit_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta2 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta2 as a double


% --- Executes during object creation, after setting all properties.
function edit_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta3 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta3 as a double


% --- Executes during object creation, after setting all properties.
function edit_theta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in btn_foward.
function btn_foward_Callback(hObject, eventdata, handles)
% hObject    handle to btn_foward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global theta1 theta2 theta3 theta4
theta1 = str2double(handles.edit_theta1.String);
theta_1_s = theta1;
set(handles.slider_theta1,'Value', theta_1_s);
theta2 = str2double(handles.edit_theta2.String);
theta_2_s = theta2;
set(handles.slider_theta2,'Value',theta_2_s);
theta3 = str2double(handles.edit_theta3.String);
theta_3_s = theta3;
set(handles.slider_theta3,'Value',theta_3_s);
theta4 = str2double(handles.edit_theta4.String);
theta_4_s = theta4;
set(handles.slider_theta4,'Value',theta_4_s);
global old_theta_1 old_theta_2 old_theta_3 old_theta_4
oldtheta1 = old_theta_1;
oldtheta2 = old_theta_2;
oldtheta3 = old_theta_3;
oldtheta4 = old_theta_4;
for k = 1:30
    theta1_temp = old_theta_1 + (theta1 - oldtheta1)*k/30;
    theta2_temp = old_theta_2 + (theta2 - oldtheta2)*k/30;
    theta3_temp = old_theta_3 + (theta3 - oldtheta3)*k/30;
    theta4_temp = old_theta_4 + (theta4 - oldtheta4)*k/30;
    DrawRobot(theta1_temp, theta2_temp, theta3_temp, theta4_temp, handles);

    
   set(handles.btn_foward,'Enable','off','String', 'Not Push');
   pause(0.2);
end
set(handles.btn_foward,'Enable','on','String', 'Foward');

% --- Executes on slider movement.
function slider_theta4_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta4 = get(hObject,'Value');
set(handles.edit_theta4,'String', num2str(round(theta4,2)));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider_theta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_theta4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta4 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta4 as a double


% --- Executes during object creation, after setting all properties.
function edit_theta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_c1.
%function check_c1_Callback(hObject, eventdata, handles)
% hObject    handle to check_c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_c1
%global old_theta_1 old_theta_2 old_theta_3 old_theta_4
%DrawRobot(old_theta_1, old_theta_2, old_theta_3, old_theta_4, handles);

% --- Executes on button press in check_c2.
% function check_c2_Callback(hObject, eventdata, handles)
% % hObject    handle to check_c2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of check_c2
% global old_theta_1 old_theta_2 old_theta_3 old_theta_4
% DrawRobot(old_theta_1, old_theta_2, old_theta_3, old_theta_4, handles);

% --- Executes on button press in check_c3.
% function check_c3_Callback(hObject, eventdata, handles)
% % hObject    handle to check_c3 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of check_c3
% global old_theta_1 old_theta_2 old_theta_3 old_theta_4
% DrawRobot(old_theta_1, old_theta_2, old_theta_3, old_theta_4, handles);

% --- Executes on button press in check_c4.
% function check_c4_Callback(hObject, eventdata, handles)
% % hObject    handle to check_c4 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of check_c4
% global old_theta_1 old_theta_2 old_theta_3 old_theta_4
% DrawRobot(old_theta_1, old_theta_2, old_theta_3, old_theta_4, handles);

% --- Executes on button press in check_end_effector.
% function check_end_effector_Callback(hObject, eventdata, handles)
% % hObject    handle to check_end_effector (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of check_end_effector
% global old_theta_1 old_theta_2 old_theta_3 old_theta_4
% DrawRobot(old_theta_1, old_theta_2, old_theta_3, old_theta_4, handles);

% --- Executes on button press in check_all.
function check_all_Callback(hObject, eventdata, handles)
% hObject    handle to check_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_all
global old_theta_1 old_theta_2 old_theta_3 old_theta_4
DrawRobot(old_theta_1, old_theta_2, old_theta_3, old_theta_4, handles);



function edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_x as a double


% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y as text
%        str2double(get(hObject,'String')) returns contents of edit_y as a double


% --- Executes during object creation, after setting all properties.
function edit_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z as text
%        str2double(get(hObject,'String')) returns contents of edit_z as a double


% --- Executes during object creation, after setting all properties.
function edit_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_roll_Callback(hObject, eventdata, handles)
% hObject    handle to edit_roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_roll as text
%        str2double(get(hObject,'String')) returns contents of edit_roll as a double


% --- Executes during object creation, after setting all properties.
function edit_roll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pitch_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pitch as text
%        str2double(get(hObject,'String')) returns contents of edit_pitch as a double


% --- Executes during object creation, after setting all properties.
function edit_pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yaw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaw as text
%        str2double(get(hObject,'String')) returns contents of edit_yaw as a double


% --- Executes during object creation, after setting all properties.
function edit_yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_X_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_X as text
%        str2double(get(hObject,'String')) returns contents of Pos_X as a double


% --- Executes during object creation, after setting all properties.
function Pos_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_Y_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_Y as text
%        str2double(get(hObject,'String')) returns contents of Pos_Y as a double


% --- Executes during object creation, after setting all properties.
function Pos_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_Z_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_Z as text
%        str2double(get(hObject,'String')) returns contents of Pos_Z as a double


% --- Executes during object creation, after setting all properties.
function Pos_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pitch_Callback(hObject, eventdata, handles)
% hObject    handle to Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pitch as text
%        str2double(get(hObject,'String')) returns contents of Pitch as a double


% --- Executes during object creation, after setting all properties.
function Pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_inverse.
function btn_inverse_Callback(hObject, eventdata, handles)
% hObject    handle to btn_inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global old_theta_1 old_theta_2 old_theta_3 old_theta_4
[flag,theta_inv] = Check_Inverse(handles, old_theta_2, old_theta_3);

if(flag)
    msgbox('Out of workspace','Info','error');
else
    theta_1_inv = theta_inv(1,1)*180/pi;
    theta_2_inv = theta_inv(2,1)*180/pi;
    theta_3_inv = theta_inv(3,1)*180/pi;
    theta_4_inv = theta_inv(4,1)*180/pi;
    oldtheta1 = old_theta_1;
    oldtheta2 = old_theta_2;
    oldtheta3 = old_theta_3;
    oldtheta4 = old_theta_4;
    for k = 1:30
        theta1_temp = old_theta_1 + (theta_1_inv - oldtheta1)*k/30;
        theta2_temp = old_theta_2 + (theta_2_inv - oldtheta2)*k/30;
        theta3_temp = old_theta_3 + (theta_3_inv - oldtheta3)*k/30;
        theta4_temp = old_theta_4 + (theta_4_inv - oldtheta4)*k/30;
        set(handles.slider_theta1,'Value', theta1_temp);
        set(handles.edit_theta1,'String', num2str(round(theta1_temp,2)));
        set(handles.slider_theta2,'Value', theta2_temp);
        set(handles.edit_theta2,'String', num2str(round(theta2_temp,2)));
        set(handles.slider_theta3,'Value', theta3_temp);
        set(handles.edit_theta3,'String', num2str(round(theta3_temp,2)));
        set(handles.slider_theta3,'Value', theta3_temp);
        set(handles.edit_theta3,'String', num2str(round(theta3_temp,2)));
        set(handles.slider_theta4,'Value', theta4_temp);
        set(handles.edit_theta4,'String', num2str(round(theta4_temp,2)));
        DrawRobot(theta1_temp, theta2_temp, theta3_temp, theta4_temp, handles);
%         old_theta_1 = theta1_temp;
%         old_theta_2 = theta2_temp;
%         old_theta_3 = theta3_temp;
%         old_theta_4 = theta4_temp;
%         oldtheta1 = old_theta_1;
%         oldtheta2 = old_theta_2;
%         oldtheta3 = old_theta_3;
%         oldtheta4 = old_theta_4;

       set(handles.btn_inverse,'Enable','off','String', 'Not Push');
       pause(0.2);
    end
    set(handles.btn_inverse,'Enable','on','String', 'Inverse');
    
end

    


% --- Executes on button press in check_workspace.
function check_workspace_Callback(hObject, eventdata, handles)
% hObject    handle to check_workspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_workspace
global old_theta_1 old_theta_2 old_theta_3 old_theta_4
DrawRobot(old_theta_1, old_theta_2, old_theta_3, old_theta_4, handles);



function edit_x_cur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x_cur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x_cur as text
%        str2double(get(hObject,'String')) returns contents of edit_x_cur as a double


% --- Executes during object creation, after setting all properties.
function edit_x_cur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x_cur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_cur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_cur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y_cur as text
%        str2double(get(hObject,'String')) returns contents of edit_y_cur as a double


% --- Executes during object creation, after setting all properties.
function edit_y_cur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y_cur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_z_cur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z_cur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z_cur as text
%        str2double(get(hObject,'String')) returns contents of edit_z_cur as a double


% --- Executes during object creation, after setting all properties.
function edit_z_cur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z_cur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pitch_cur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pitch_cur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pitch_cur as text
%        str2double(get(hObject,'String')) returns contents of edit_pitch_cur as a double


% --- Executes during object creation, after setting all properties.
function edit_pitch_cur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pitch_cur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_next_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x_next as text
%        str2double(get(hObject,'String')) returns contents of edit_x_next as a double


% --- Executes during object creation, after setting all properties.
function edit_x_next_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_next_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y_next as text
%        str2double(get(hObject,'String')) returns contents of edit_y_next as a double


% --- Executes during object creation, after setting all properties.
function edit_y_next_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_z_next_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z_next as text
%        str2double(get(hObject,'String')) returns contents of edit_z_next as a double


% --- Executes during object creation, after setting all properties.
function edit_z_next_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pitch_next_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pitch_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pitch_next as text
%        str2double(get(hObject,'String')) returns contents of edit_pitch_next as a double


% --- Executes during object creation, after setting all properties.
function edit_pitch_next_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pitch_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_linear.
function btn_linear_Callback(hObject, eventdata, handles)
% hObject    handle to btn_linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btn_linear
global theta1 theta2 theta3 theta4 old_theta_1 old_theta_2 old_theta_3 old_theta_4;
old_theta_1 = theta1;
old_theta_2 = theta2;
old_theta_3 = theta3;
old_theta_4 = theta4;
X = [];
Y = [];
Z = [];

Pitch = [];
X_dot = [];
Y_dot = [];
Z_dot = [];
Pitch_dot = [];

x_0 = str2double(handles.edit_x_cur.String);

y_0 = str2double(handles.edit_y_cur.String);

z_0 = str2double(handles.edit_z_cur.String);

x_1 = str2double(handles.edit_x_next.String);

y_1 = str2double(handles.edit_y_next.String);

z_1 = str2double(handles.edit_z_next.String);

vmax = str2double(handles.v_max.String);
amax = str2double(handles.a_max.String);

pitch_0 = str2double(handles.edit_pitch_cur.String);

pitch_1 = str2double(handles.edit_pitch_next.String);

x_pre = x_0;
y_pre = y_0;
z_pre = z_0;
pitch_pre = pitch_0;
[flag1, ~] = Check_Inverse_Jaco_new(x_0,y_0,z_0,pitch_0,old_theta_2,old_theta_3);
if flag1 == 0
   [flag2, ~] = Check_Inverse_Jaco_new(x_1,y_1,z_1,pitch_1,old_theta_2,old_theta_3);
   if flag2
       set(handles.edit_x_next,'String','');
       set(handles.edit_y_next,'String','');
       set(handles.edit_z_next,'String','');
       set(handles.edit_pitch_next,'String','');
   end
else
    set(handles.edit_x_cur,'String','');
   set(handles.edit_y_cur,'String','');
   set(handles.edit_z_cur,'String','');
   set(handles.edit_pitch_cur,'String','');
end

qmax = sqrt((x_1-x_0)^2 + (y_1-y_0)^2 + (z_1-z_0)^2);
set(handles.v_possible,'String',num2str(round(sqrt(qmax*amax),2)));
if vmax > round(sqrt(qmax*amax),2)
    set(handles.v_max,'String','');
    msgbox('Cannot apply the entried vmax value!','info','error');
elseif(flag1 == 1)
    msgbox('Point Current Out of Workspace','info','error');
elseif(flag2 == 1)
    msgbox('Point Destination Out of Workspace','info','error');
else
    t1 = vmax/amax;
    tm=(qmax-amax*t1^2)/vmax;
    t2 = t1+tm;
    tmax = t1+t2;
    %tmax=t1+t2+tm;
    
%     tb = vmax/amax;
%     qc = 1/2*amax*tb^2;
%     t_m = (qmax-2*qc)/vmax;
%     tmax2 = 2*tb+t_m;
    set(handles.t_max,'string',num2str(tmax));
%     set(handles.t_max_2,'string',num2str(tmax2));
    t = linspace(0,tmax,70);
    K = length(t);
    q = zeros(size(t));
    v = zeros(size(t));
    a = zeros(size(t));
    th_1 = zeros(size(t));
    th_2 = zeros(size(t));
    th_3 = zeros(size(t));
    th_4 = zeros(size(t));
    v_th1 = zeros(size(t));
    v_th2 = zeros(size(t));
    v_th3 = zeros(size(t));
    v_th4 = zeros(size(t));
    
    for k = 1:K
        if t(k) <t1
            q(k) = amax*(t(k))^2/2;
            v(k)=amax*t(k);
            a(k)=amax;
        elseif t(k) <t2
            q(k)=vmax*t(k)+ amax*t1^2/2 - vmax*t1;
            v(k)=vmax;
            a(k)=0;
        elseif t(k)<=tmax
            q(k) = -1/2*amax*(t(k))^2+amax*t(k)*tmax+qmax-1/2*amax*tmax^2;
            v(k) = amax*(tmax-t(k));
           % v(k) = amax*t1-amax*(t(k)-t2);
            a(k) = -amax;
        end
        x = x_0+(q(k)/qmax)*(x_1-x_0);
        y = y_0+(q(k)/qmax)*(y_1-y_0);
        z = z_0+(q(k)/qmax)*(z_1-z_0);
        pitch = pitch_0 + (q(k)/qmax)*(pitch_1-pitch_0);
        X=[X, x];
        Y=[Y, y];
        Z=[Z, z];
        Pitch = [Pitch, pitch];
%         x_dot = (v(k)/qmax)*(x_1 - x_0);
%         y_dot =  (v(k)/qmax)*(y_1 - y_0);
%         z_dot = (v(k)/qmax)*(z_1 - z_0);
%         pitch_dot =  (v(k)/qmax)*(pitch_1-pitch_0);
        if k ==1
            x_dot = (x-x_pre)/t(1);
            y_dot = (y-y_pre)/t(1);
            z_dot = (z-z_pre)/t(1);
            pitch_dot = (pitch-pitch_pre)/t(1);
        else
            x_dot = (x - x_pre)/(t(k)-t(k-1));
            y_dot = (y - y_pre)/(t(k)-t(k-1));
            z_dot = (z - z_pre)/(t(k)-t(k-1));
            pitch_dot = (pitch - pitch_pre)/(t(k)-t(k-1));
        end
        X_dot = [X_dot, x_dot];
        Y_dot = [Y_dot,y_dot];
        Z_dot = [Z_dot,z_dot];
        Pitch_dot = [Pitch_dot,pitch_dot]; 
        x_pre = x;
        y_pre = y;
        z_pre = z;
        pitch_pre = pitch;
    end
    
    for k = 1:K 
         old_theta_1 = theta1;
         old_theta_2 = theta2;
         old_theta_3 = theta3;
         old_theta_4 = theta4;
         
         v_end = [X_dot(1,k); Y_dot(1,k);Z_dot(1,k);(Pitch_dot(1,k)*pi/180)];
        [flag3 , theta_inv] = Check_Inverse_Jaco_new(X(1,k),Y(1,k),Z(1,k),Pitch(1,k),old_theta_2, old_theta_3);
        if flag3 == 0
            theta1 = theta_inv(1,1)*180/pi;
            th_1(1,k) = theta1;
            old_theta_1 = theta1;
            theta2 = theta_inv(2,1)*180/pi;
            th_2(1,k) = theta2;
            old_theta_2 = theta2;
            theta3 = theta_inv(3,1)*180/pi;
            th_3(1,k) = theta3;
            old_theta_3 = theta3;
            theta4 = theta_inv(4,1)*180/pi;
            th_4(1,k) = theta4;
            old_theta_4 = theta4;
%             J_Matrix = Jacobian_Matrix(theta_inv(1,1), theta_inv(2,1), theta_inv(3,1), theta_inv(4,1));
            yaw = Foward_Kinematics(deg2rad(theta1), deg2rad(theta2), deg2rad(theta3), deg2rad(theta4));
            v_end(4,1) = v_end(4,1)*cos(yaw);
            J_Matrix = Jacobian_Matrix(deg2rad(theta1), deg2rad(theta2), deg2rad(theta3), deg2rad(theta4));
            v_joint = J_Matrix\v_end;
            v_th1(1,k) = v_joint(1,1);
            v_th2(1,k) = v_joint(2,1);
            v_th3(1,k) = v_joint(3,1);
            v_th4(1,k) = v_joint(4,1);
            
        else
            msgbox('Out of Workspace','info','error');
            break
        end
    end
    if flag3 == 0
    for k = 1:K 
       
        DrawRobot(th_1(1,k), th_2(1,k),th_3(1,k),th_4(1,k),handles);
%         set(handles.edit_test,'string',num2str(round(-th_2(1,k)-th_3(1,k)-th_4(1,k),2)));
        hold on;
        plot3(X(1,1:k),Y(1,1:k),Z(1,1:k),'--','linewidth',2,'color','black');
        hold off;
        set(handles.slider_theta1,'Value', th_1(1,k));
        set(handles.edit_theta1,'String', num2str(round( th_1(1,k),2)));
        set(handles.slider_theta2,'Value', th_2(1,k));
        set(handles.edit_theta2,'String', num2str(round(th_2(1,k),2)));
        set(handles.slider_theta3,'Value', th_3(1,k));
        set(handles.edit_theta3,'String', num2str(round(th_3(1,k),2)));
        set(handles.slider_theta4,'Value', th_4(1,k));
        set(handles.edit_theta4,'String', num2str(round(th_4(1,k),2)));
       
        plot(handles.axesq,t(1:k),q(1:k));
%         axis(handles.axesq,[0 tmax, 0 qmax])
        xlabel(handles.axesq,'Time(s)')
        ylabel(handles.axesq,'Positon(mm)')
        grid (handles.axesq, 'on')
        
        plot(handles.axesv,t(1:k), v(1:k));
%          axis(handles.axesv,[0 tmax, 0 vmax])
         xlabel(handles.axesv,'Time(s)')
        ylabel(handles.axesv,'Velocity(mm/s)')
        grid (handles.axesv, 'on')
       
        plot(handles.axesa,t(1:k), a(1:k));
%          axis(handles.axesa,[0 tmax, -amax amax])
         xlabel(handles.axesa,'Time(s)')
        ylabel(handles.axesa,'Acceleration(mm/s^2)')
        grid (handles.axesa, 'on')
        
%         plot(handles.axes_th1,t(1:k), th_1(1,1:k));
% %         axis(handles.axes_th1,[0 tmax, -180 180]);
%          xlabel(handles.axes_th1,'Time(s)')
%         ylabel(handles.axes_th1,'Theta1(deg)')
%         grid (handles.axes_th1, 'on')
        
%         plot(handles.axes_th2,t(1:k), th_2(1,1:k));
% %         axis(handles.axes_th2,[0 tmax, -90 90]);
%          xlabel(handles.axes_th2,'Time(s)')
%         ylabel(handles.axes_th2,'Theta2(deg)')
%         grid (handles.axes_th2, 'on')
        
%         plot(handles.axes_th3,t(1:k), th_3(1,1:k));
% %         axis(handles.axes_th3,[0 tmax, -90 90]);
%         xlabel(handles.axes_th3,'Time(s)')
%         ylabel(handles.axes_th3,'Theta3(deg)')
%          grid (handles.axes_th3, 'on')
%         
%         plot(handles.axes_th4,t(1:k), th_4(1,1:k));
% %         axis(handles.axes_th4,[0 tmax, -90 90]);
%         xlabel(handles.axes_th4,'Time(s)')
%         ylabel(handles.axes_th4,'Theta4(deg)')
%          grid (handles.axes_th4, 'on')
        
        plot(handles.axes_th1_dot,t(1:k), v_th1(1,1:k));
        xlabel(handles.axes_th1_dot,'Time(s)')
        ylabel(handles.axes_th1_dot,'Th1dot(rad/s)')
        grid (handles.axes_th1_dot, 'on')
       
        plot(handles.axes_th2_dot,t(1:k), v_th2(1,1:k));
        xlabel(handles.axes_th2_dot,'Time(s)')
        ylabel(handles.axes_th2_dot,'Th2dot(rad/s)')
         grid (handles.axes_th2_dot, 'on')
        
        plot(handles.axes_th3_dot,t(1:k), v_th3(1,1:k));
        xlabel(handles.axes_th3_dot,'Time(s)')
        ylabel(handles.axes_th3_dot,'Th3dot(rad/s)')
        grid (handles.axes_th3_dot, 'on')
        
        plot(handles.axes_th4_dot,t(1:k), v_th4(1,1:k));
        xlabel(handles.axes_th4_dot,'Time(s)')
        ylabel(handles.axes_th4_dot,'Th4dot(rad/s)')
         grid (handles.axes_th4_dot, 'on')
        pause(tmax/K);
        
    end
    x = x_1;
    y = y_1;
    z = z_1;
    pitch = pitch_1;
    [~, theta_inv_final] = Check_Inverse_Jaco_new(x,y,z,pitch,old_theta_2,old_theta_3);
    theta1 = theta_inv_final(1,1)*180/pi;
    old_theta_1 = theta1;
    theta2 = theta_inv_final(2,1)*180/pi;
    old_theta_2 = theta2;
    theta3 = theta_inv_final(3,1)*180/pi;
    old_theta_3 = theta3;
    theta4 = theta_inv_final(4,1)*180/pi;
    old_theta_4 = theta4;
%     pause(0.001);
   DrawRobot(theta1, theta2,theta3,theta4,handles);
    hold on;
    plot3(X,Y,Z,'linewidth',2,'color','black');
    hold off;
    set(handles.slider_theta1,'Value', theta1);
    set(handles.edit_theta1,'String', num2str(round(theta1,2)));
    set(handles.slider_theta2,'Value', theta2);
    set(handles.edit_theta2,'String', num2str(round(theta2,2)));
    set(handles.slider_theta3,'Value', theta3);
    set(handles.edit_theta3,'String', num2str(round(theta3,2)));
    set(handles.slider_theta4,'Value', theta4);
    set(handles.edit_theta4,'String', num2str(round(theta4,2)));
      plot(handles.axesq,t,q);
        axis(handles.axesq,[0 tmax, 0 qmax])
        xlabel(handles.axesq,'Time(s)')
        ylabel(handles.axesq,'Positon(mm)')
        grid (handles.axesq, 'on')
        
       % plot(handles.axesv,t, v);
         axis(handles.axesv,[0 tmax, 0 vmax+5])
         xlabel(handles.axesv,'Time(s)')
        ylabel(handles.axesv,'Velocity(mm/s)')
        grid (handles.axesv, 'on')
       
        plot(handles.axesa,t, a);
         axis(handles.axesa,[0 tmax, -amax amax])
         xlabel(handles.axesa,'Time(s)')
        ylabel(handles.axesa,'Acceleration(mm/s^2)')
        grid (handles.axesa, 'on')
        
%        % plot(handles.axes_th1,t, th_1);
%         axis(handles.axes_th1,[0 tmax, -180 180]);
%          xlabel(handles.axes_th1,'Time(s)')
%         ylabel(handles.axes_th1,'Theta1(deg)')
%         grid (handles.axes_th1, 'on')
        
%         plot(handles.axes_th2,t, th_2);
%         axis(handles.axes_th2,[0 tmax, -90 90]);
%          xlabel(handles.axes_th2,'Time(s)')
%         ylabel(handles.axes_th2,'Theta2(deg)')
%         grid (handles.axes_th2, 'on')
        
%         plot(handles.axes_th3,t, th_3);
%         axis(handles.axes_th3,[0 tmax, -90 90]);
%         xlabel(handles.axes_th3,'Time(s)')
%         ylabel(handles.axes_th3,'Theta3(deg)')
%          grid (handles.axes_th3, 'on')
%         
%         plot(handles.axes_th4,t, th_4);
%         axis(handles.axes_th4,[0 tmax, -90 90]);
%         xlabel(handles.axes_th4,'Time(s)')
%         ylabel(handles.axes_th4,'Theta4(deg)')
%          grid (handles.axes_th4, 'on')
        
        plot(handles.axes_th1_dot,t, v_th1);
        xlabel(handles.axes_th1_dot,'Time(s)')
        ylabel(handles.axes_th1_dot,'Th1dot(rad/s)')
        grid (handles.axes_th1_dot, 'on')
       
        plot(handles.axes_th2_dot,t, v_th2);
        xlabel(handles.axes_th2_dot,'Time(s)')
        ylabel(handles.axes_th2_dot,'Th2dot(rad/s)')
         grid (handles.axes_th2_dot, 'on')
        
        plot(handles.axes_th3_dot,t, v_th3);
        xlabel(handles.axes_th3_dot,'Time(s)')
        ylabel(handles.axes_th3_dot,'Th3dot(rad/s)')
        grid (handles.axes_th3_dot, 'on')
        
        plot(handles.axes_th4_dot,t, v_th4);
        xlabel(handles.axes_th4_dot,'Time(s)')
        ylabel(handles.axes_th4_dot,'Th4dot(rad/s)')
         grid (handles.axes_th4_dot, 'on')
    end
end



function v_possible_Callback(hObject, eventdata, handles)
% hObject    handle to v_possible (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_possible as text
%        str2double(get(hObject,'String')) returns contents of v_possible as a double


% --- Executes during object creation, after setting all properties.
function v_possible_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_possible (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_max_Callback(hObject, eventdata, handles)
% hObject    handle to v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_max as text
%        str2double(get(hObject,'String')) returns contents of v_max as a double


% --- Executes during object creation, after setting all properties.
function v_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_max_Callback(hObject, eventdata, handles)
% hObject    handle to a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_max as text
%        str2double(get(hObject,'String')) returns contents of a_max as a double


% --- Executes during object creation, after setting all properties.
function a_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function count_Callback(hObject, eventdata, handles)
% hObject    handle to count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of count as text
%        str2double(get(hObject,'String')) returns contents of count as a double


% --- Executes during object creation, after setting all properties.
function count_CreateFcn(hObject, eventdata, handles)
% hObject    handle to count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t_max_Callback(hObject, eventdata, handles)
% hObject    handle to t_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_max as text
%        str2double(get(hObject,'String')) returns contents of t_max as a double


% --- Executes during object creation, after setting all properties.
function t_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t_max_2_Callback(hObject, eventdata, handles)
% hObject    handle to t_max_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_max_2 as text
%        str2double(get(hObject,'String')) returns contents of t_max_2 as a double


% --- Executes during object creation, after setting all properties.
function t_max_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_max_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit56_Callback(hObject, eventdata, handles)
% hObject    handle to v_possible (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_possible as text
%        str2double(get(hObject,'String')) returns contents of v_possible as a double


% --- Executes during object creation, after setting all properties.
function edit56_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_possible (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit57_Callback(hObject, eventdata, handles)
% hObject    handle to t_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_max as text
%        str2double(get(hObject,'String')) returns contents of t_max as a double


% --- Executes during object creation, after setting all properties.
function edit57_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function opacity_Callback(hObject, eventdata, handles)
% hObject    handle to opacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global old_theta_1 old_theta_2 old_theta_3 old_theta_4
DrawRobot(old_theta_1, old_theta_2, old_theta_3, old_theta_4, handles);

% --- Executes during object creation, after setting all properties.
function opacity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to opacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_opacity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_opacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_opacity as text
%        str2double(get(hObject,'String')) returns contents of edit_opacity as a double


% --- Executes during object creation, after setting all properties.
function edit_opacity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_opacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_test_Callback(hObject, eventdata, handles)
% hObject    handle to edit_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_test as text
%        str2double(get(hObject,'String')) returns contents of edit_test as a double


% --- Executes during object creation, after setting all properties.
function edit_test_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
%function axes_th1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes_th1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
%function axes_th2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes_th2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
%function axes_th2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_th2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_th2


% --- Executes on mouse press over axes background.
function RobotView_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to RobotView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
