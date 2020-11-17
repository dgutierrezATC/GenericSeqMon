numAddrDistintas=max(inaddr)/2;

tempCount=zeros(1,numAddrDistintas);
auxTimeCount=1;

%integrationPeriod=200;      %6710;
integrationPeriod=208*2; %208;  %48.077kHz/2
% integrationPeriod=104*10;  %48.077kHz
% integrationPeriod=104/2;  %48.077kHz

Tsample=integrationPeriod*0.2e-6;
kk=size(inaddr);
max_data=kk(1);
tempValues=0;
ints=ints-ints(1);
nSamples=ints(end)/integrationPeriod
totalDiscreteValues=zeros(nSamples,numAddrDistintas);
realTime=zeros(1,nSamples);


tempIntegratedValues=zeros(1,numAddrDistintas);
timeCount=1;


for i=1:max_data
      if(integrationPeriod*timeCount<ints(i))
          totalDiscreteValues (timeCount,:)=tempIntegratedValues;
          tempIntegratedValues=zeros(1,numAddrDistintas);
          timeCount=timeCount+1;
          realTime(timeCount)=timeCount*Tsample;           
          


      end
      tempAddr=(inaddr(i)/2);
      if(rem(inaddr(i),2)==0)   %positivo
         tempIntegratedValues(tempAddr+1)=tempIntegratedValues(tempAddr+1)+1;
      else                      %negativo
         tempIntegratedValues(tempAddr)=tempIntegratedValues(tempAddr)-1;
      end

end

%%Calculo en frecuencia
% totalDiscreteValues=totalDiscreteValues./Tsample ;
plot(realTime(1:end),totalDiscreteValues)
