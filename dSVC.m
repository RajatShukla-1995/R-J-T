function [ml,rat1,rat2]=dSVC(cs,pos1,pos2,mRat)
%% function for double SVC installation
%Syntax [minloss1,minloss2,rating1,rating2]=(busno1,busno2,mxarating)

st=loadcase(cs);
p=runopf(st);
tL=get_losses(p);        %losses matrix without SVC
TL=real(sum(tL));        %total real losses
st1=loadcase(cs);
ml=TL;
rat1=0;rat2=0;
for i=1:mRat
    st1.bus(pos1,4)=st.bus(pos1,4)-i;
    for j=1:mRat
        st1.bus(pos2,4)=st.bus(pos2,4)-j;
        tL1=real(sum(get_losses(runopf(st1))));   % getting real losses with SVC at pos1 of ith rating 
                                                                        %and at pos2 of jth rating
        if ml>tL1             %  updating minimum value of losses in branches with SVC of i and j rating in line
            ml=tL1;
            rat1=i;
            rat2=j;
        end
    end
end
%fprintf('\n minimal losses of %f MW with SVC of rating %f MVAr and %f MVAr \n',ml,rat1,rat2);
end
        
    