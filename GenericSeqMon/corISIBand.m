 function resul=corISIBand (lISI, rISI)

kk= size(lISI);

nBands=kk(1);


resul=zeros(1,nBands);
for i=1:nBands
    resul(i)=sum(abs(lISI(i,:)-rISI(i,:)));
end