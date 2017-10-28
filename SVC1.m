function [minLoss,rat,pos]=SVC1(cs,mxrat)
%% function to find overall best SVC the network
%   syntax  [minLoss,bestRating,position]=SVC1('casefile',max rat. of SVC available)

st=loadcase(cs);
[W,R]=SVC(st,1,mxrat);  
ar(1,1)=W;
ar(1,2)=R;

n=size(st.bus);    % size of bus system
for i=2:n                     % making array of losses of all buses
    [l,r]=SVC(st,i,mxrat);
    ar(i,1)=l;
    ar(i,2)=r;
end

mn=ar(1,1);
pos=1;

for i=2:n                       %finding minimum losses in whole array
    if ar(i,1)<mn
        mn=ar(i,1);
        pos=i;
    end
end
     
    minLoss=mn;           %returning values to function parameters   
    rat=ar(pos,2);
   
   % printing whole loss data array
  fprintf(' Bus no          Line Loss          SVC used')
   for i=1:n
       fprintf('\n   %d           %fMW       %fMvar \n',i,ar(i,1),ar(i,2));
   end
   
    fprintf(' \n best SVC for min branch losses is of %d MVAr at bus %d with line loss %d MW \n',rat,pos,minLoss);
end