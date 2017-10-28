function ar=plotGraph(cs,busno,mxrat)
%% plotting graph
st=loadcase(cs);
 st1=loadcase(st); 
 m=size(st1.bus);
for j=1:mxrat                              %SVC rated upto mxrat MVAr.
    st1.bus(busno,4)=st.bus(busno,4)-j;     % changing reactive power supplied at bus due to SVC
                                                                %of rating j
    r=runopf(st1);
    loss=get_losses(r);                     % loss is a matrix of losses
    tLoss=0;
    for i=1:m           %adding total real losses with SVC of j rating
        tLoss=tLoss+real(loss(i));
    end
    ar(j)=tLoss;
end
%plotting graph
plot(ar);
grid;
xlabel('Reactive Power Injected by SVC MVAr');
ylabel('Real Power Loss');
end