% create TCPIP object - tcpip('rhost',rport)
% 'rhost': ip address of remote host
% rport: (optional) remote port value
loadcell = tcpip('rhost',rport);

% open connection
fopen(loadcell);

if 0 < loadcell.BytesAvailable
    data = fread(loadcell,loadcell.BytesAvailablt,'uint8');
end

fclose(loadcell);
delete(loadcell);