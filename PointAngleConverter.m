function varargout = PointAngleConverter(varargin)
% POINTANGLECONVERTER MATLAB code for PointAngleConverter.fig
%      POINTANGLECONVERTER, by itself, creates a new POINTANGLECONVERTER or raises the existing
%      singleton*.
%
%      H = POINTANGLECONVERTER returns the handle to a new POINTANGLECONVERTER or the handle to
%      the existing singleton*.
%
%      POINTANGLECONVERTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POINTANGLECONVERTER.M with the given input arguments.
%
%      POINTANGLECONVERTER('Property','Value',...) creates a new POINTANGLECONVERTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PointAngleConverter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PointAngleConverter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PointAngleConverter

% Last Modified by GUIDE v2.5 17-Jun-2014 17:32:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PointAngleConverter_OpeningFcn, ...
                   'gui_OutputFcn',  @PointAngleConverter_OutputFcn, ...
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


% --- Executes just before PointAngleConverter is made visible.
function PointAngleConverter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PointAngleConverter (see VARARGIN)

% Choose default command line output for PointAngleConverter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PointAngleConverter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PointAngleConverter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function xpos_Callback(hObject, eventdata, handles)
% hObject    handle to xpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xpos as text
%        str2double(get(hObject,'String')) returns contents of xpos as a double
xpos = str2double(get(hObject,'String'));
handles.pos.x = xpos;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function xpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ypos_Callback(hObject, eventdata, handles)
% hObject    handle to ypos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ypos as text
%        str2double(get(hObject,'String')) returns contents of ypos as a double
ypos = str2double(get(hObject,'String'));
handles.pos.y = ypos;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function ypos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ypos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zpos_Callback(hObject, eventdata, handles)
% hObject    handle to zpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zpos as text
%        str2double(get(hObject,'String')) returns contents of zpos as a double
zpos = str2double(get(hObject,'String'));
handles.pos.z = zpos;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function zpos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zpos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in toAngle.
function toAngle_Callback(hObject, eventdata, handles)
% hObject    handle to toAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.angles.shoulder,handles.angles.slew,handles.angles.elbow,handles.POI] = ...
    pointToAngle(handles.pos.x,handles.pos.y,handles.pos.z)
set(handles.slewAngle, 'String',handles.angles.slew);
set(handles.shoulderAngle, 'String', handles.angles.shoulder);
set(handles.elbowAngle, 'String', handles.angles.elbow);

% --- Executes on button press in toPoint.
function toPoint_Callback(hObject, eventdata, handles)
% hObject    handle to toPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.pos.x,handles.pos.y,handles.pos.z,handles.POI] = ...
    angleToPoint(handles.angles.shoulder,handles.angles.slew,handles.angles.elbow);
set(handles.xpos,'String',handles.pos.x);
set(handles.ypos,'String',handles.pos.y);
set(handles.zpos,'String',handles.pos.z);


function slewAngle_Callback(hObject, eventdata, handles)
% hObject    handle to slewAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slewAngle as text
%        str2double(get(hObject,'String')) returns contents of slewAngle as a double
slew = str2double(get(hObject,'String'));
handles.angles.slew = slew;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slewAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slewAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function shoulderAngle_Callback(hObject, eventdata, handles)
% hObject    handle to shoulderAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shoulderAngle as text
%        str2double(get(hObject,'String')) returns contents of shoulderAngle as a double
shoulder = str2double(get(hObject,'String'));
handles.angles.shoulder = shoulder;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function shoulderAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shoulderAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elbowAngle_Callback(hObject, eventdata, handles)
% hObject    handle to elbowAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elbowAngle as text
%        str2double(get(hObject,'String')) returns contents of elbowAngle as a double
elbow = str2double(get(hObject,'String'));
handles.angles.elbow = elbow;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function elbowAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elbowAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
