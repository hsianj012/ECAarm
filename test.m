clc
clear all

close all

s = serial('COM4');
set(s,'BaudRate',115200)
set(s,'ByteOrder','bigEndian')
get(s)

disp('running fopen...')
fopen(s);
disp('success!')

disp('running fread...')
fread(s,s.BytesAvailable,'uint8')
disp('check!')


command0 =uint8(hex2dec(['E7';...
    '00';'00';'00';...
    '00';'00';'00';'00';'0F';'FF';'00';'32';'00';...
    '00';'00';'00';'01';'0F';'FF';'00';'32';'00';...
    '00';'00';'00';'00';'0F';'FF';'00';'32';'00';...
    '00';'00';'00';'01';'0F';'FF';'00';'32';'00';...
    '00';'00';'00';'00';'0F';'FF';'00';'32';'00';...
    '34';'E5']));
command0(50) = mod(sum(command0(1:49)),255)-floor(sum(command0(1:49))/255);
disp('command created')

disp('sending command...')
fwrite(s,command0);
disp('sent!')

fclose(s)