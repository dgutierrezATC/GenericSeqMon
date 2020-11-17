if (isempty(usb0))
     usb0=factory.getFirstAvailableInterface;
end

if ~usb0.isOpen()   
        usb0.open     
end

file='pdm.aedat';

usb0.setOperationMode(1);

  inaddr=[];
    ints=[];          
    
    usb0.setEventAcquisitionEnabled(true);
    
     monitortime=2;


        tic    
        while toc<monitortime
            inpacket=usb0.acquireAvailableEventsFromDriver.getPrunedCopy();
            ints=[ints; inpacket.getTimestamps()];
            inaddr=[inaddr; inpacket.getAddresses()];

        end

        inpacket=usb0.stopMonitoringSequencing();
        inaddr=[inaddr; inpacket.getAddresses()];
        ints=[ints; inpacket.getTimestamps()];




     inaddr=int32(bitand(double(inaddr),hex2dec('00ff'))); %%OJO CON ESTA LINEA, CORREGIR!

    figure;
    plot(double(ints)*0.2e-6,inaddr,'.b')


    spikes2discrete
        figure;  
        plot(realTime,[totalDiscreteValues(:,:)])

    % figure    
    % surf(realTime,[1:1:64],totalDiscreteValues','EdgeColor','none')
tic

    saveaerdat(ints,inaddr,file)
toc