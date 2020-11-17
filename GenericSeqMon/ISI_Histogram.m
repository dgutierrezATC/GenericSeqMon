function isiHistogram=ISI_Histogram(inaddr,ints)%filename)
% [inaddr,ints]=loadaerdat(sprintf('%s.aedat',filename));
timeStamps=zeros(256,1)-1;
maxISI=5120; %% Spikes more than 1000Hz
stepISI=4;

nISI=maxISI/stepISI;

isiHistogram=zeros(256,nISI+1);


ints=double(ints);
for i=1:length(inaddr)
    if(inaddr(i)~=126 && inaddr(i)~=127 && inaddr(i)~=254 && inaddr(i)~=255)
        if(timeStamps(inaddr(i)+1)==-1)
            timeStamps(inaddr(i)+1)=ints(i);
        else
            dt=abs(ints(i)-timeStamps(inaddr(i)+1));
           if(dt<maxISI)
                isiHistogram(inaddr(i)+1,floor(dt/stepISI)+1)=isiHistogram(inaddr(i)+1,floor(dt/stepISI)+1)+1;
           end
           timeStamps(inaddr(i)+1)=ints(i);
        end
    end
end

isiHistogram(1:128,:)=isiHistogram(1:128,:)/sum(sum(isiHistogram(1:128,:)));
isiHistogram(129:256,:)=isiHistogram(129:256,:)/sum(sum(isiHistogram(129:256,:)));

% figure;
% 
% surf(isiHistogram./sum(sum(isiHistogram)))
% surf(isiHistogram,'EdgeColor','none')
% ylabel('Cochlea Channel')
% xlabel('ISI')

% figure;
% b=sum(isiHistogram);
% b=b./sum(b);
% plot([0:stepISI:maxISI]*0.2e-6,b)
%  xlabel('ISI')
% ylabel('Relative Spikes Count')
end
