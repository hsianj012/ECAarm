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

% Last Modified by GUIDE v2.5 24-Jun-2014 11:56:13

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
handles.input = zeros(1,5);

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

% update text on GUI based on type of input user wants to use
if (hObject == handles.anglesBtn)
    set(handles.text1, 'String', 'Shoulder:');
    set(handles.text2, 'String', 'Slew:');
    set(handles.text3, 'String', 'Elbow:');
    handles.inputType = 'angles';
else
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

% store value of y or slew angle as input(2)
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

% store value of z or elbow angle as input(3)
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


% --- Executes on slider movement.
function jawSlider_Callback(hObject, eventdata, handles)
% hObject    handle to jawSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% Store jaw open percentage
jawValue = get(hObject,'Value');
handles.input(5) = jawValue;

% display current position of slider on GUI
set(handles.jawVal,'String',num2str(jawValue));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function jawSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jawSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in runBtn.
function runBtn_Callback(hObject, eventdata, handles)
% hObject    handle to runBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set demand type to position for shoulder, slew, and elbow
handles.demandType = [5 5 5 0 0];

% check for jaw open/close command and set demand type to position if
% present
if handles.input(5)
    handles.demandType(5) = 5;
end

% update status to 'running' on GUI
if get(handles.runBtn,'Value')
    set(handles.status, 'String', 'RUNNING...');
    set(handles.statusBG, 'BackgroundColor',[1 1 0]);
    set(handles.status,'BackgroundColor',get(handles.statusBG,'BackgroundColor'));
end

% % run function
% inputType = handles.inputType;
% input = handles.input;
% demand_type = handles.demandType;
% [handles.rawData] = runArm(inputType, input, demand_type);
% [handles.posAng,handles.posPt, handles.speed,handles.current,handles.POI, handles.length]...
%     = dataForPlot(handles.rawData);
% handles.cycles = 1:handles.length;


handles.posAng = rand(1,20);
handles.posPt = rand(1,20);
handles.speed = rand(1,20);
handles.current = rand(1,20);
handles.cycles = 1:20;

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

% --- Executes on button press in currentA2.
function currentA2_Callback(hObject, eventdata, handles)
% hObject    handle to currentA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of currentA2
on = get(hObject,'Value');
if on
    handles.A2.current = on;
else
    handles.A2.current = 0;
end
guidata(hObject, handles);

% --- Executes on button press in posPtA2.
function posPtA2_Callback(hObject, eventdata, handles)
% hObject    handle to posPtA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of posPtA2
on = get(hObject,'Value');
if on
    handles.A2.posPt = on;
else
    handles.A2.posPt = 0;
end
guidata(hObject, handles);

% --- Executes on button press in posAngA2.
function posAngA2_Callback(hObject, eventdata, handles)
% hObject    handle to posAngA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of posAngA2
on = get(hObject,'Value');
if on
    handles.A2.posAng = on;
else
    handles.A2.posAng = 0;
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

% --- Executes on button press in speedA2.
function speedA2_Callback(hObject, eventdata, handles)
% hObject    handle to speedA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of speedA2
on = get(hObject,'Value');
if on
    handles.A2.speed = on;
else
    handles.A2.speed = 0;
end
guidata(hObject, handles);

% --- Executes on button press in plotBt.
function plotBt_Callback(hObject, eventdata, handles)
% hObject    handle to plotBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
colors = ['r','g','b','m'];

axes(handles.axes1);
cla
hold on
plotA1 = fieldnames(handles.A1);
disp(plotA1)
plotLegend = [];
for iElement = 1:numel(plotA1)
    if handles.A1.(plotA1{iElement})
        plot(handles.cycles,handles.(plotA1{iElement}),colors(iElement))
        plotLegend = [plotLegend,plotA1(iElement)];
    end
end
legend(plotLegend)

axes(handles.axes2);
cla
hold on
plotA2 = fieldnames(handles.A2)
plotLegend = [];
for iElement = 1:numel(plotA2)
    if handles.A2.(plotA2{iElement})
        plot(handles.cycles,handles.(plotA2{iElement}),colors(iElement))
        plotLegend = [plotLegend,plotA2(iElement)];
    end
end
legend(plotLegend)