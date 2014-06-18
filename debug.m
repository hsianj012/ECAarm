clc
clear all

s = serial('/dev/tty.usbserial-FTFK1K5Z');
set(s,'BaudRate',115200)
set(s,'ByteOrder','bigEndian')
get(s)

fopen(s);

command =uint8(hex2dec([   'E7';'00';'00';'00';...
                            '00';'00';'00';'00';'00';'00';'00';'00';'00';...
                            '00';'05';'79';'7a';'0F';'FF';'0F';'FF';'00';...
                            '00';'00';'00';'00';'00';'00';'00';'00';'00';...
                            '00';'00';'00';'00';'00';'00';'00';'00';'00';...
                            '00';'00';'00';'00';'00';'00';'00';'00';'00';...
                            '00';'E5']));
command(50) = mod(sum(command(1:49)),255)-floor(sum(command(1:49))/255);

data=[];

for i=1:50
    fwrite(s, command);
    pause(0.05);
   
%     s.BytesAvailable
   
    if 0 < s.BytesAvailable
        a = fread(s,s.BytesAvailable,'uint8');
        256*uint16(a(16)) + uint16(a(15))
        %a(15:16,:)
        data = [data, uint8(a)];
    end
end
while(s.BytesAvailable >0)
    data = [data, fread(s,s.BytesAvailable,'uint8')]
    pause(0.05);
end

fclose(s);
delete(s);
clear s