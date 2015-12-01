% Script to compute the expected value of Hq(U,V) for 
% two partitions. 

function [EHUV_]=expHUV(true_mem,mem,q)
    if nargin==2
        T=true_mem; % Contingency table pre-supplied
        q = mem; % q becomes the second argument
        n = sum(sum(T));N=n;
    elseif nargin==3
        % Build the contingency table from membership arrays
        r=max(true_mem);
        c=max(mem);
        n=length(mem);N=n;

        % Identify & removing the missing labels
        list_t=ismember(1:r,true_mem);
        list_m=ismember(1:c,mem);
        T=Contingency(true_mem,mem);
        T=T(list_t,list_m);
    end

    %update the true dimensions
    [r c]=size(T);
    if c>1 u=sum(T');else u=T';end;
    if r>1 v=sum(T);else v=T;end;
    
    % Compute the expected value

    % calculate E[n_ij^\q] 
    EP=zeros(r,c);
    for i=1:r
        for j=1:c
          EP(i,j) = E_nijq(u(i),v(j),N,q);
        end
    end

    enij = sum(sum(EP));    
    EHUV_ = (1 - enij/N^q)/(q-1);
end
%---------------------auxiliary functions---------------------

% create a contingecy table

function Cont=Contingency(Mem1,Mem2)
  if nargin < 2 || min(size(Mem1)) > 1 || min(size(Mem2)) > 1
     error('Contingency: Requires two vector arguments')
     return
  end

  Cont=zeros(max(Mem1),max(Mem2));

  for i = 1:length(Mem1);
     Cont(Mem1(i),Mem2(i))=Cont(Mem1(i),Mem2(i))+1;
  end
end

% gets the the probability of the smallest number
% of success for a r.v. Hyp(a,b,N)

function p = getP(a,b,N)
    nij=max(0,a+b-N);
    X=sort([nij N-a-b+nij]);
    if N-b>X(2)
      nom=[[a-nij+1:a] [b-nij+1:b] [X(2)+1:N-b]];
      dem=[[N-a+1:N] [1:X(1)]];
    else
      nom=[[a-nij+1:a] [b-nij+1:b]];       
      dem=[[N-a+1:N] [N-b+1:X(2)] [1:X(1)]];
    end
    p = prod(nom./dem);        
end

% given the probability of n successes for a Hyp(a,b,N)
% computes the probability of n+1 successes

function p = incrP( p,a,b,n,N)
  p = p*(a-n)*(b-n)/(n+1)/(N-a-b+n+1);  
end

% computes E[n_{ij}\q] when n is 
% distributed as Hyp(a,b,N)

function [e]= E_nijq(a,b,N,q)
  p = getP(a,b,N);
  e = 0;
  for n=max(0,a+b-N):min(a,b);
     e = e + n^q * p;
     p = incrP(p,a,b,n,N);
  end
end




            