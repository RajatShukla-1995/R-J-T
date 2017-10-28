function [minLoss,rat]=SVC(cs,busno,mxrat)
%% function to automate best SVC rating for min losses at particular bus
%syntax [minLoss,rat]=SVC('case file',busno,maximum rating of SVC available)

st=loadcase(cs);
r=runopf(st);         
loss=get_losses(r);         %losses with no SVC
m=size(loss);
tLoss=0;
p=0;

for i=1:m                 %adding total real losses with no SVC
    tLoss=tLoss+real(loss(i));  
end
W=tLoss;
st1=loadcase(st);
for j=1:mxrat                              %SVC rated upto mxrat MVAr.
    st1.bus(busno,4)=st.bus(busno,4)-j;     % changing reactive power supplied at bus due to SVC
                                                                %of rating j
    r=runopf(st1);
    loss=get_losses(r);                     % loss is a matrix of losses
    tLoss=0;
    for i=1:m           %adding total real losses with SVC of j rating
        tLoss=tLoss+real(loss(i));
    end
    if W>tLoss                                            % comparing to get value of minimal losses
        W=tLoss;
        p=j;
    end
end
minLoss=W;
rat=p;
%fprintf('\n w=%f     rating=%d \n',W,p);
end