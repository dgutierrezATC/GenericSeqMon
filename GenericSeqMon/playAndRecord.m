%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Angel Jimenez-Fernandez
% Adapted by Juan Pedro Dominguez-Morales & Daniel Gutierrez-Galan
% University of Seville 2020
% Last modification: 17/nov/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function playAndRecord( y, fs, fileName, usb0)
%PLAYANDRECORD Summary of this function goes here
%   Detailed explanation goes here
    inaddr=[];
    ints=[];
    TotalTime = length(y)./fs; % time in seconds
    monitortime=TotalTime; 
   
    packet_buffer = cell(1, round(monitortime/0.001));
    
    
    indx = 1;
    
    sound(y, fs);    
    pause(0.25)
    
    inpacket=usb0.acquireAvailableEventsFromDriver.getPrunedCopy();
    tic
    while toc<monitortime
        packet_buffer{indx} = usb0.acquireAvailableEventsFromDriver.getPrunedCopy();
        indx = indx + 1;
    end
    toc

    packet_buffer{indx}=usb0.stopMonitoringSequencing();
    
    inaddr = cellfun(@(x) x.getAddresses(), packet_buffer, 'un', 0);
    ints = cellfun(@(x) x.getTimestamps(), packet_buffer, 'un', 0);
    inaddr = vertcat(inaddr{:});
    ints = vertcat(ints{:});
    inaddr=int32(bitand(double(inaddr),hex2dec('00ff')));

    if length(ints) > 0
        saveaerdat(ints(1800:length(ints)),inaddr(1800:length(ints)), char(strcat(fileName, '.aedat')));
        clear ints
        clear inaddr
        clear inpacket
        clear y

    end
end