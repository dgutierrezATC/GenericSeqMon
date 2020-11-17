
Fs=44.1e3;

GAIN=1;

tfL=[];


eventRate =[];

if (isempty(usb0))
     usb0=factory.getFirstAvailableInterface;
end

if ~usb0.isOpen()   
        usb0.open     
end


usb0.setOperationMode(1);



        
    f1=500;  
    monitortime=1;
    
    senos=GAIN*sin(2*pi*f1*(0:1/Fs:monitortime+0.5));



    p = audioplayer(senos, Fs); 
    play(p);
        
    inaddr=[];
    ints=[];          
    
    tic
    while toc<0.2
    end
    
    usb0.setEventAcquisitionEnabled(true);
    

    
    tic    
    while toc<monitortime
        inpacket=usb0.acquireAvailableEventsFromDriver.getPrunedCopy();
        ints=[ints; inpacket.getTimestamps()];
        inaddr=[inaddr; inpacket.getAddresses()];

    end
   
    inpacket=usb0.stopMonitoringSequencing();
    inaddr=[inaddr; inpacket.getAddresses()];
    ints=[ints; inpacket.getTimestamps()];
        
    tic
    while toc<0.3
    end
    


inaddr=int32(bitand(double(inaddr),hex2dec('00ff'))); %%OJO CON ESTA LINEA, CORREGIR!

figure;
plot(ints,inaddr,'.b')
figure;

spikes2discrete;
