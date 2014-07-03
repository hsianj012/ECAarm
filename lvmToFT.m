function [Fx, Fy, Fz, Tx, Ty, Tz] = lvmToFT(filename,header,numFiles)
%lvmToFT this function takes in labview lvm file formatted as a (two-column csv)
% and returns the force and torque data
% numFiles can be 'single' or 'series'

%% Initialize variables.
delimiter = ',';

switch header
    case {true, 'T'}
        % % If file has headers
        startRow = 23;
    case {false, 'F'}
        % % if no headers
        startRow = 1; 
end

% Set to 'inf' to read until end of file regardless of # of lines
endRow = inf; 

%% Format string for each line of text:
%   column2: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    dataArray{1} = [dataArray{1};dataArrayBlock{1}];
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
FTData = dataArray{:, 1};
dataLength = size(FTData,1)/6;

% initiate vectors
Fx = zeros(1,dataLength);
Fy = zeros(1,dataLength);
Fz = zeros(1,dataLength);
Tx = zeros(1,dataLength);
Ty = zeros(1,dataLength);
Tz = zeros(1,dataLength);



% fill with data from file
for i = 1:(dataLength-1)
    Fx(i)=FTData(6*(i-1)+1);
    Fy(i)=FTData(6*(i-1)+2);
    Fz(i)=FTData(6*(i-1)+3);
    Tx(i)=FTData(6*(i-1)+4);
    Ty(i)=FTData(6*(i-1)+5);
    Tz(i)=FTData(6*(i-1)+6);
end

switch numFiles
    case 'single'
        return
    case 'series'
        %% Comment this section out if you want each pt instead of average values
        % Return average force/torques
        Fx = mean(Fx);
        Fy = mean(Fy);
        Fz = mean(Fz);
        Tx = mean(Tx);
        Ty = mean(Ty);
        Tz = mean(Tz);
end
