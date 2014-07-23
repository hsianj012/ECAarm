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

% Last Modified by GUIDE v2.5 23-Jul-2014 11:32:49

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
% handles.input = zeros(1,5);

% Update handles structure
guidata(hObject, handles);

% Initiate axes plot handles
handles.A1.posAng = 0;
handles.A1.posPt = 0;
handles.A1.speed = 0;
handles.A1.current = 0;

% Initial selection for button panels
handles.jawVal = 10;
handles.inputType = 'angles';

guidata(hObject, handles);
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

% update text on GUI based on type of input user wants to use
switch get(eventdata.NewValue,'Tag')
    case 'anglesBtn'
        set(handles.text1, 'String', 'Shoulder:');
        set(handles.text2, 'String', 'Slew:');
        set(handles.text3, 'String', 'Elbow:');
        handles.inputType = 'angles';
    case 'pointBtn'
        set(handles.text1, 'String', 'X:');
        set(handles.text2, 'String', 'Y:');
        set(handles.text3, 'String', 'Z:');
        handles.inputType = 'point';
end
guidata(hObject, handles);

function textInput1_Callback(hObject, eventdata, handles)
% hObject    handle to textInput1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textInput1 as text
%        str2double(get(hObject,'String')) returns contents of textInput1 as a double

% store value of x or shoulder angle as input(1)
input1 = eval(get(hObject, 'String'));
if isnan(input1)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

handles.input(1,:)= input1;
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

% store value of y or slew angle as input(2)
input2 = eval(get(hObject, 'String'));
if isnan(input2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

handles.input(2,:) = input2;
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

% store value of z or elbow angle as input(3)
input3 = eval(get(hObject, 'String'));
if isnan(input3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

handles.input(3,:)= input3;
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

% set demand type to position for shoulder, slew, and elbow
handles.demandType = [5 5 5 0 5];

% % check for jaw open/close command and set demand type to position if
% % present
% if handles.input(5)
%     handles.demandType(5) = 5;
% end

% update status to 'running' on GUI
if get(handles.runBtn,'Value')
    set(handles.status, 'String', 'RUNNING...');
    set(handles.statusBG, 'BackgroundColor',[1 1 0]);
    set(handles.status,'BackgroundColor',get(handles.statusBG,'BackgroundColor'));
end

%% run function
% get input values
input = handles.input;
% get number of waypoints
numWP = size(input,2);
% if inputType == point, convert point to angles
if strcmp(handles.inputType,'point')
    for i = 1:numWP
        [input(1,i),input(2,i),input(3,i)] = pointToAngle(handles.input(1,i),handles.input(2,i),handles.input(3,i));
    end
end
% make jawValue same for all waypoints
input(5,:)=handles.jawVal*ones(1,numWP);

% check that waypoint are valid
input = makeWaypoint(input);
input
[handles.rawData] = runArm(input, handles.demandType);

% update status to 'complete' on GUI
set(handles.status, 'String', 'COMPLETE');
set(handles.statusBG, 'BackgroundColor',[0 1 0]);
set(handles.status,'BackgroundColor',get(handles.statusBG,'BackgroundColor'));

guidata(hObject, handles);
% end


% --- Executes on button press in posAngA1.
function posAngA1_Callback(hObject, eventdata, handles)
% hObject    handle to posAngA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of posAngA1
on = get(hObject,'Value');
if on
    handles.A1.posAng = on;
else
    handles.A1.posAng = 0;
end
guidata(hObject, handles);


% --- Executes on button press in posPtA1.
function posPtA1_Callback(hObject, eventdata, handles)
% hObject    handle to posPtA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of posPtA1
on = get(hObject,'Value');
if on
    handles.A1.posPt = on;
else
    handles.A1.posPt = 0;
end
guidata(hObject, handles);

% --- Executes on button press in currentA1.
function currentA1_Callback(hObject, eventdata, handles)
% hObject    handle to currentA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of currentA1
on = get(hObject,'Value');
if on
    handles.A1.current = on;
else
    handles.A1.current = 0;
end
guidata(hObject, handles);


% --- Executes on button press in speedA1.
function speedA1_Callback(hObject, eventdata, handles)
% hObject    handle to speedA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of speedA1
on = get(hObject,'Value');
if on
    handles.A1.speed = on;
else
    handles.A1.speed = 0;
end
guidata(hObject, handles);

% --- Executes on button press in tempA1.
function tempA1_Callback(hObject, eventdata, handles)
% hObject    handle to tempA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tempA1
on = get(hObject,'Value');
if on
    handles.A1.temp = on;
else
    handles.A1.temp = 0;
end
guidata(hObject, handles);


% --- Executes on button press in plotBt.
function plotBt_Callback(hObject, eventdata, handles)
% hObject    handle to plotBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.posAng, handles.posPt, handles.speed, handles.current, handles.temp handles.length]...
    = dataForPlot(handles.rawData);
handles.cycles = 1:handles.length;

% checks/plots desired plots in separate figures
plotA1 = fieldnames(handles.A1);
for iElement = 1:numel(plotA1)
    if handles.A1.(plotA1{iElement})
        figure(iElement)%-- 7/23/2014 9:31 AM --%
        switch plotA1{iElement}
            case 'posPt'
                points = handles.(plotA1{iElement});
                hold on
                view(3)
                plot3(points(1,:),points(2,:),points(3,:))
                plot3(points(1,1),points(2,1),points(3,1),'go')
                plot3(points(1,end),points(2,end),points(3,end),'rs')
                xlabel('X (in.)')
                ylabel('Y (in.)')
                zlabel('Z (in.)')
                title('Cartesian Position of End-effector')
            case 'posAng'
                axes = plotyy(handles.cycles,handles.(plotA1{iElement})(1:3,:),handles.cycles,handles.(plotA1{iElement})(4,:));
                legend('shoulder','slew','elbow','jaw');
                xlabel('Cycle')
                ylabel(axes(1),'Angle (^\circ)')
                ylabel(axes(2),'Open %')
                title('Joint Positions')
            case 'speed'
                plot(handles.cycles,handles.(plotA1{iElement}))
                legend('shoulder','slew','elbow','wrist','jaw');
                xlabel('Cycle')
                ylabel('Speed (RPM)')
                title('Motor Speeds')
            case 'current'
                plot(handles.cycles,handles.(plotA1{iElement}))
                legend('shoulder','slew','elbow','wrist','jaw');
                xlabel('Cycle')
                ylabel('Current')
                title('Motor Currents')
            case 'temp'
                plot(handles.cycles,handles.(plotA1{iElement}))
                legend('shoulder','slew','elbow','wrist','jaw');
                xlabel('Cycle')
                ylabel('Temperature (^\circC')
                title('Motor Temperature')
        end
    end
end


% --- Executes on button press in resetBt.
function resetBt_Callback(hObject, eventdata, handles)
% hObject    handle to resetBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes when selected object is changed in jawPosition.
function jawPosition_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in jawPosition 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
% --- Executes when selected object changed in jawPanel.

switch get(eventdata.NewValue,'Tag')
    case 'jawOpen'
        handles.jawVal = 100;
    case 'jawClose'
        handles.jawVal = 10;
end
guidata(hObject, handles);


