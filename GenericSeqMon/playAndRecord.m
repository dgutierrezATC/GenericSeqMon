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
        %ints=[ints; inpacket.getTimestamps()];
        %inaddr=[inaddr; inpacket.getAddresses()];
        indx = indx + 1;
    end
    toc
    
    
    %ints=[ints; inpacket.getTimestamps()];
    %inaddr=[inaddr; inpacket.getAddresses()];

    packet_buffer{indx}=usb0.stopMonitoringSequencing();
    
    
    %inaddr=[inaddr; inpacket.getAddresses()];
    %ints=[ints; inpacket.getTimestamps()];
    
    inaddr = cellfun(@(x) x.getAddresses(), packet_buffer, 'un', 0);
    ints = cellfun(@(x) x.getTimestamps(), packet_buffer, 'un', 0);
    inaddr = vertcat(inaddr{:});
    ints = vertcat(ints{:});
    %ints(1)
    %ints(end)
    inaddr=int32(bitand(double(inaddr),hex2dec('00ff'))); %%OJO CON ESTA LINEA, CORREGIR!

    %tic

    if length(ints) > 0
        saveaerdat(ints(1800:length(ints)),inaddr(1800:length(ints)), char(strcat(fileName, '.aedat')));
        %ints(2000:length(ints)),inaddr(2000:length(ints)
        clear ints
        clear inaddr
        clear inpacket
        clear y

    end
    %toc
end


% function playAndRecord( y, fs, fileName, usb0)
% %PLAYANDRECORD Summary of this function goes here
% %   Detailed explanation goes here
%     inaddr=[];
%     ints=[];
%     TotalTime = length(y)./fs; % time in seconds
%     monitortime=2*TotalTime; 
%    
%     packet_buffer = cell(1, round(monitortime/0.001));
%     
%     inpacket=usb0.acquireAvailableEventsFromDriver.getPrunedCopy();
%     indx = 1;
%     
%     sound([zeros(fs,1); y],fs);    
% %     pause(1)
%     tic
%     
%     while toc<monitortime
%         packet = usb0.acquireAvailableEventsFromDriver.getPrunedCopy();
%         if toc > 1
%             packet_buffer{indx} = packet;
%             indx = indx + 1;
%         end
%         %ints=[ints; inpacket.getTimestamps()];
%         %inaddr=[inaddr; inpacket.getAddresses()];
%     end
%     toc
%     
%     
%     %ints=[ints; inpacket.getTimestamps()];
%     %inaddr=[inaddr; inpacket.getAddresses()];
% 
%     packet_buffer{indx}=usb0.stopMonitoringSequencing();
%     
%     
%     %inaddr=[inaddr; inpacket.getAddresses()];
%     %ints=[ints; inpacket.getTimestamps()];
%     
%     inaddr = cellfun(@(x) x.getAddresses(), packet_buffer, 'un', 0);
%     ints = cellfun(@(x) x.getTimestamps(), packet_buffer, 'un', 0);
%     inaddr = vertcat(inaddr{:});
%     ints = vertcat(ints{:});
%     ints(1)
%     ints(end)
%     inaddr=int32(bitand(double(inaddr),hex2dec('00ff'))); %%OJO CON ESTA LINEA, CORREGIR!
% 
%     tic
% 
%     if length(ints) > 0
%         saveaerdat(ints(1:length(ints)),inaddr(1:length(ints)), char(strcat(fileName, '.aedat')));
%         %ints(2000:length(ints)),inaddr(2000:length(ints)
%         clear ints
%         clear inaddr
%         clear inpacket
%         clear y
% 
%     end
%     toc
% end
