function a=plotAllGraphs(cs,mxrat)
%don't try to fit all graphs on one plot as graphs become un readable
st=loadcase(cs);
st1=loadcase(st); 
 m=size(st1.bus); % m is a matrix os 2*1
 p=m(1);
% calculating dimenstions of subplot
 if p==9      % p is the number of buses
    n1=3;n2=3;
elseif p==14
    n1=4;n2=4;
elseif p==5
    n1=3;n2=2;
elseif p==6
    n1=3;n2=2;
elseif p==4
    n1=2;n2=2;
elseif p==24
    n1=5;n2=5;
elseif p==30
    n1=6;n2=5;
elseif p==33
    n1=6;n2=6;
elseif p==39
    n1=7;n2=6;
end
        
 for i=1:p
     subplot(n1,n2,i);       %making a square subplots
     plotGraph(st,i,mxrat);     % plotting all graphs
     xlabel('Reactive Power Injected by SVC MVAr in bus ');
     ylabel('Real Power Loss');
 end 
 hold off;
end
