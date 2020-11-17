function [genAdd, genTs]= AEGen (inData,Ts)

    inDataSize=numel (inData);
    genTime=inDataSize*Ts;

    genAdd=[];
    genTs=[];
    
    cycle=0;
    nCycle=0;

    actualTime=0;
    nData=1;
    seqTick=0.2e-6;
%     seqTick=1e-6;
    
    while(actualTime<genTime)
    
        %%Disparamos el evento
        if( rem((cycle) * abs(inData(nData)) , 2^15) < abs(inData(nData)) )

          if(inData(nData)>=0)
               newAdd = 0;
          else
               newAdd = 1;
          end
          
          genAdd=[genAdd ; uint16(newAdd)];
          genTs=[genTs ; uint16(cycle)];
           
        end

        %%Actualizamos el ciclo
        cycle = cycle+1;

        if(cycle == 2^15)
             cycle = 0;
             nCycle=nCycle+1;
        end
        
        %El tiempo actual
        actualTime=(nCycle*2^15+ cycle)*seqTick;
        
        %Vemos si hay que avanzar una muestra
        if(nData*Ts<actualTime)
            nData=nData+1;
        end
        

    end

