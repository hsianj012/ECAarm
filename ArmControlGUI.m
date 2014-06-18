function varargout = ArmControlGUI(varargin)
% ARMCONTROLGUI MATLAB code for ArmControlGUI.fig
%      ARMCONTROLGUI, by itself, creates a new ARMCONTROLGUI or raises the existing
%      singleton*.
%
%      H = ARMCONTROLGUI returns the handle to a new ARMCONTROLGUI or the handle to
%      the existing singleton*.
%
%      ARMCONTROLGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ARMCONTROLGUI.M with the given input arguments.
%
%      ARMCONTROLGUI('Property','Value',...) creates a new ARMCONTROLGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ArmControlGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ArmControlGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ArmControlGUI

% Last Modified by GUIDE v2.5 18-Jun-2014 17:29:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ArmControlGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ArmControlGUI_OutputFcn, ...
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


% --- Executes just before ArmControlGUI is made visible.
function ArmControlGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ArmControlGUI (see VARARGIN)

% Choose default command line output for ArmControlGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.inputTypePanel, 'SelectedObject', handles.anglesBtn);
% initialize_gui(hObject, handles, false);
% UIWAIT makes ArmControlGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ArmControlGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when selected object changed in inputTypePanel.
function inputTypePanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in inputTypePanel 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (hObject == handles.anglesBtn)
    set(handles.text1, 'String', 'Shoulder:');
    set(handles.text2, 'String', 'Slew:');
    set(handles.text3, 'String', 'Elbow:');
else
    set(handles.text1, 'String', 'X:');
    set(handles.text2, 'String', 'Y:');
    set(handles.text3, 'String', 'Z:');
end

function textInput1_Callback(hObject, eventdata, handles)
% hObject    handle to textInput1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textInput1 as text
%        str2double(get(hObject,'String')) returns contents of textInput1 as a double
input1 = str2double(get(hObject, 'String'));
if isnan(input1)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

handles.input(1)= input1;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function textInput1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textInput1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textInput2_Callback(hObject, eventdata, handles)
% hObject    handle to textInput2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textInput2 as text
%        str2double(get(hObject,'String')) returns contents of textInput2 as a double
input2 = str2double(get(hObject, 'String'));
if isnan(input2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

handles.input(2) = input2;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function textInput2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textInput2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textInput3_Callback(hObject, eventdata, handles)
% hObject    handle to textInput3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textInput3 as text
%        str2double(get(hObject,'String')) returns contents of textInput3 as a double
input3 = str2double(get(hObject, 'String'));
if isnan(input3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

handles.input(3)= input3;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function textInput3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textInput3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in runBtn.
function runBtn_Callback(hObject, eventdata, handles)
% hObject    handle to runBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.demandType = [5 5 5 0 0];
handles.input(4:5) = [5 6];
axes(handles.axes2);
cla
set(handles.status, 'String', 'RUNNING...');
set(handles.statusBG, 'BackgroundColor',[1 1 0]);
set(handles.status,'BackgroundColor',get(handles.statusBG,'BackgroundColor'));
pause(5);
plot(handles.input,handles.demandType)
set(handles.status, 'String', 'COMPLETE');
set(handles.statusBG, 'BackgroundColor',[0 1 0]);
set(handles.status,'BackgroundColor',get(handles.statusBG,'BackgroundColor'));


% --- Executes on button press in stopBtn.
function stopBtn_Callback(hObject, eventdata, handles)
% hObject    handle to stopBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.demandType = [0 0 0 0 0];
set(handles.status, 'String', 'STOPPED!')
set(handles.statusBG, 'BackgroundColor',[1 0 0]);
set(handles.status,'BackgroundColor',get(handles.statusBG,'BackgroundColor'));
