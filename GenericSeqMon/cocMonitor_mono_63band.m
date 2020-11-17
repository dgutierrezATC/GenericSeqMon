
numberOfBands=64;
% monitorBand=logspace(1.302,4.301,numberOfBands);
 monitorBand=logspace(1,3.28,numberOfBands);

% monitorBand=linspace(10^2.301,10^4.301,numberOfBands);
% monitorBand=monitorBand(end:-1:1);

  
% Fs=48e3;
Fs=44.1e3;

GAIN=1;

tfL=[];
tfR=[];

eventRate =[];
eventRateL =[];
eventRateR =[];

channelCorrelation=[];

if (isempty(usb0))
     usb0=factory.getFirstAvailableInterface;
end

if ~usb0.isOpen()   
        usb0.open     
end


usb0.setOperationMode(1);


for nBand=1:1:numel(monitorBand)
        
    f1=monitorBand(nBand)  
    monitortime=0.5;
    
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
    
% figure;
% plot(ints,inaddr,'.b')

inaddr=int32(bitand(double(inaddr),hex2dec('00ff'))); %%OJO CON ESTA LINEA, CORREGIR!
%     spikes2discrete
%     figure;  
%     plot(realTime,[totalDiscreteValues(:,:)])

    
%%Análisis de las bandas
    
    [rL,rR]=cocFreqResponse (inaddr,ints,64);

    
    tfL=[tfL;rL];
    tfR=[tfR;rR];
    
    %%Calculo de las tasas de eventos 
    eventRate=[eventRate (5e6*numel(ints))/double(ints(end))];    
      
%     filename=sprintf('Coc14_2ch_%d.mat', f1);
%     save (filename, 'inaddr', 'ints', 'totalDiscreteValues','f1','eventRateL','eventRateR');
       
  isiHistogram=ISI_Histogram(inaddr,ints);
  
   lISI=isiHistogram(1:128,:);
    rISI=isiHistogram(129:end,:);
   
    correlation=[];
    
   channelCorrelation=[channelCorrelation corISIBand(lISI,rISI)'];
   
end

tfL2=tfL;
tfR2=tfR;
for i=1:1:numberOfBands
    for j=1:1:64
%       tfL2(i,j)=20*log10(tfL(i,j)/tfL(i,end));        
        tfL2(i,j)=(tfL(i,j)/tfL(i,end));                
        tfR2(i,j)=(tfR(i,j)/tfR(i,end));                        
    end
end
% 


figure;
semilogx(monitorBand,tfL2)
title('Left Cochlea');

figure;
semilogx(monitorBand,tfR2)
title('Rigth Cochlea');

figure;
semilogx(monitorBand,eventRate)
title('Rate Event');

figure;
surf([1:63],monitorBand,tfL(:,1:end-1),'EdgeColor','none')
% 
% figure;
% semilogx(monitorBand, [tfL(:,end) tfR(:,end)])


figure
surf(monitorBand,[1:128],channelCorrelation,'EdgeColor','none')

