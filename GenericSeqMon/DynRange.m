
numPower=100;

Fs=44.1e3;

monitortime=0.5;
eventRate =[];

    tfL=[];
    tfR=[];

 time=[0:1/Fs:monitortime];
 signal_src=rand(numel(time),1);
signal_src=2*(signal_src-mean(signal_src));
if (isempty(usb0))
     usb0=factory.getFirstAvailableInterface;
end

if ~usb0.isOpen()   
        usb0.open     
end


usb0.setOperationMode(1);


for n=1:1:numPower
     
   n

   
    signal=n*signal_src/numPower;
    
    max(signal)
    

    p = audioplayer(signal, Fs); 
    play(p);
        
    inaddr=[];
    ints=[];          
    
    tic
    while toc<0.1
    end
    
    usb0.setEventAcquisitionEnabled(true);
    

    
    tic    
    while toc<monitortime-0.2
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
    
% figure;
% plot(ints,inaddr,'.b')

inaddr=int32(bitand(double(inaddr),hex2dec('00ff'))); %%OJO CON ESTA LINEA, CORREGIR!
%     spikes2discrete
%     figure;  
%     plot(realTime,[totalDiscreteValues(:,:)])

[rL,rR]=cocFreqResponse (inaddr,ints,64);
    tfL=[tfL;rL];
    tfR=[tfR;rR];
%%Análisis de las bandas
   eventRate =[eventRate; numel(inaddr)/(0.2e-6*double(ints(end)-ints(1))) ]; 
%     figure;
%     plot(ints,inaddr,'.b')


   isiHistogram=ISI_Histogram(inaddr,ints);
  
   lISI=isiHistogram(1:128,:);
    rISI=isiHistogram(129:end,:);
   
   channelCorrelation=corISIBand (lISI,rISI);
%    figure;
%    plot(channelCorrelation);
   
end

figure;
plot([1/numPower:1/numPower:1],eventRate)

figure;
plot([1/numPower:1/numPower:1],tfL)

figure;
plot([1/numPower:1/numPower:1],tfR)
