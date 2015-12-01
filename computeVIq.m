% Script to compute VI_q for 
% two partitions. 
% --------------------------------------------------------------------------
% INPUT: A contingency table T and q
%        OR
%        Partition labels in two vectors and q
%        eg: true_mem=[1 2 4 1 3 5]
%                 mem=[2 1 3 1 4 5]
%        Labels are coded using positive integers. 
% OUTPUT: VI_q

function [VIq_]=computeVIq(true_mem,mem,q)
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

    marginal = 0;
    
    for i=1:r
        marginal = marginal + u(i)^q;
    end
    
    for j=1:c
        marginal = marginal + v(j)^q;
    end
    
    joint = 0;
    for i=1:r
        for j=1:c
            joint = joint + T(i,j)^q;
        end
    end
    
    VIq_ = (marginal - 2*joint)/ N^q / (q - 1);
    

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

            