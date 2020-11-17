

monitortime=5e-1;

if (isempty(usb0))
    usb0=factory.getFirstAvailableInterface;
end

if ~usb0.isOpen()   
        usb0.open     
end

usb0.setOperationMode(1);

inaddr=[];
ints=[];
  
t=[0:1e-5:monitortime];
sineWave=80*sin(2*pi*1e2*t);

[genAdd, genTs]= AEGen (sineWave,1e-5);

figure
plot(genTs,genAdd,'.b');

genTs=diff(genTs);
genTs=[ 0 ; genTs];

%%%%%%%%

genAdd=[genAdd; (genAdd+2)];
genTs=[genTs; genTs];


outpacket = net.sf.jaer.aemonitor.AEPacketRaw(genAdd,genTs);


usb0.startMonitoringSequencing(outpacket);

tic

while toc<monitortime*2
    inpacket=usb0.acquireAvailableEventsFromDriver.getPrunedCopy();

    ints=[ints; inpacket.getTimestamps()];
    inaddr=[inaddr; inpacket.getAddresses()];


end
               
inpacket=usb0.stopMonitoringSequencing();
inaddr=[inaddr; inpacket.getAddresses()];
ints=[ints; inpacket.getTimestamps()];

%%Data analisys
figure
plot(ints,inaddr,'.b')

spikes2Discrete
figure
plot(realTime,totalDiscreteValues)
hold on
plot(t,sineWave*(1/((0.2e-6)*2^15)),'--')
hold off
