function [freqL,freqR]= cocFreqResponse(inaddr, ints, n_ch)
    
    inaddr=double(inaddr);

    freqTotal=zeros(1,(n_ch)*2);
    monitorTime=double(ints(end)-ints(1));
    for i=1:1:length(inaddr)
%        if(mod(inaddr(i),2)==1)
             freqTotal(floor(inaddr(i)/2)+1)=freqTotal(floor(inaddr(i)/2)+1)+1;
%        end
    end

   freqL=(5e6*freqTotal(1:1:n_ch))/monitorTime;
   freqR=(5e6*freqTotal(n_ch+1:1:end))/monitorTime;
   
    for i=1:numel(freqL)
        if(freqL(i)==0)
            freqL(i)=10;
        end
        if(freqR(i)==0)
            freqR(i)=10;
        end
    end
end