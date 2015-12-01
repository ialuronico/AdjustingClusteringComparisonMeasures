% Script to compute NMI_q for 
% two partitions. 
% --------------------------------------------------------------------------
% INPUT: A contingency table T and q
%        OR
%        Partition labels in two vectors and q
%        eg: true_mem=[1 2 4 1 3 5]
%                 mem=[2 1 3 1 4 5]
%        Labels are coded using positive integers. 
% OUTPUT: NMI_q

function [NMIq_]=computeNMIq(true_mem,mem,q)
    if nargin==2
        T=true_mem; % Contingency table pre-supplied
        q = mem; % q becomes the second argument
        n = sum(sum(T)); N=n;
    elseif nargin==3
        % Build the contingency table from membership arrays
        r=max(true_mem);
        c=max(mem);
        n=length(mem);N=n;

        %identify & removing the missing labels
        list_t=ismember(1:r,true_mem);
        list_m=ismember(1:c,mem);
        T=Contingency(true_mem,mem);
        T=T(list_t,list_m);
    end

    %update the true dimensions
    [r c]=size(T);
    if c>1 u=sum(T');else u=T';end;
    if r>1 v=sum(T);else v=T;end;

    HU = 0;
    
    for i=1:r
        HU = HU + (u(i)/n)^q;
    end
    
    HU = (1 - HU)/(q-1);
    
    HV = 0;
    
    for j=1:c
        HV = HV + (v(j)/n)^q;
    end
    
    HV = (1 - HV)/(q-1);
    
    HUV = 0;
    for i=1:r
        for j=1:c
            HUV = HUV + (T(i,j)/n)^q;
        end
    end
    
    HUV = (1 - HUV)/(q-1);
    
    NMIq_ = (HU + HV - HUV)/0.5/(HU + HV);
    

%---------------------auxiliary functions---------------------
function Cont=Contingency(Mem1,Mem2)

if nargin < 2 || min(size(Mem1)) > 1 || min(size(Mem2)) > 1
   error('Contingency: Requires two vector arguments')
   return
end

Cont=zeros(max(Mem1),max(Mem2));

for i = 1:length(Mem1);
   Cont(Mem1(i),Mem2(i))=Cont(Mem1(i),Mem2(i))+1;
end

            