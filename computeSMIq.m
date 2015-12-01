% Script to compute the SMIq between 
% two partitions. 
% --------------------------------------------------------------------------
% INPUT: A contingency table T
%        OR
%        Partition labels in two vectors
%        eg: true_mem=[1 2 4 1 3 5]
%                 mem=[2 1 3 1 4 5]
%        Partition labels are coded using positive integers. 
% OUTPUT: SMIq

function [SMIq_]=computeSMIq(true_mem,mem,q)
  if nargin==2
    T=true_mem; % Contingency table pre-supplied
    q = mem;
  elseif nargin==3
    % Build the contingency table from membership arrays
    r=max(true_mem);
    c=max(mem);

    %identify & removing the missing labels
    list_t=ismember(1:r,true_mem);
    list_m=ismember(1:c,mem);
    T=Contingency(true_mem,mem);
    T=T(list_t,list_m);
  end

  [r c]=size(T);
  if (c == 1 || r == 1)
   error('Clusterings should have at least 2 sets')
   return
  end
  
  N = sum(sum(T)); % total number of records
 
  % update the true dimensions
  a=sum(T,2)';
  b=sum(T);

  % compute useful things
  maxNij = min(max(a),max(b));
  NijQ=(0:maxNij).^q;

  % calculate sum_{ij} n^q
  sum_nq=0;
  for i=1:r
    for j=1:c
      if T(i,j)>0 
          sum_nq = sum_nq + NijQ(T(i,j)+1);
      end;
    end
  end      

  % calculate sum_{ij} E[n_{ij}^q] 
  EP=zeros(r,c);
  for i=1:r
    for j=1:c
      EP(i,j) = E_nq(a(i),b(j),N,NijQ);
    end
  end

  E_sum_nq = sum(sum(EP));

  % calculate E[ ( sum_{ij} n_{ij}^q )^2 ] 

  % transpose the contingecy table (for speed)
  if (c > r)
    T = T';
    [r c]=size(T);
    a=sum(T,2)';
    b=sum(T);
  end  
  
  EP = zeros(r,c);
  for i=1:r    
    for j=1:c
      %fprintf('.'); % just to show it is computing
    
      p = getP(a(i),b(j),N);        
      for nij=max(0,a(i)+b(j)-N):min(a(i), b(j))
        sumP = 0;
        
        % i=i' j=~j' and i=~i' j=~j' 
        N_ = N - b(j);
        a_ = a(i) - nij;
        for jp=(j+1):c  
          b_ = b(jp);                
          p_= getP(a_,b_,N_);

          for nijp=max(0,a_+b_-N_):min(a_, b_);
            sumP_ = 0;
            for ip=[1:i-1 i+1:r]
              sumP_ = sumP_ + E_nq(a(ip), b(jp)-nijp, N-a(i), NijQ);
            end
            
            sumP_ = sumP_ + NijQ(nijp+1); 
            
            sumP = sumP + sumP_*p_;                  
            p_=incrP(p_,a_,b_,nijp,N_);
          end
        end

        % i=~i' j=j' 
        N_ = N - a(i);
        b_ = b(j) - nij;
        for ip=(i+1):r  
          a_ = a(ip);                
          p_= getP(a_,b_,N_);
          for nipj=max(0,a_+b_-N_):min(a_, b_);
            sumP = sumP + NijQ(nipj+1)*p_;
            
            p_=incrP(p_,a_,b_,nipj,N_);
          end
        end            

        % i=i' j=j' 
        sumP = 2*sumP + NijQ(nij+1);
        
        Lpnij = NijQ(nij+1)*p;
        EP(i,j) = EP(i,j) + Lpnij*sumP;            

        p=incrP(p,a(i),b(j),nij,N);                   
      end
    end
  end

  E_sum_nq_2 = sum(sum(EP));    

  SMIq_ = (sum_nq - E_sum_nq)/sqrt(E_sum_nq_2 - E_sum_nq^2);
   
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

% computes E[n^q] when n is 
% distributed as Hyp(a,b,N)

function [e]= E_nq(a,b,N,nq)
  p = getP(a,b,N);
  e = 0;
  for n=max(0,a+b-N):min(a,b);
     e = e + nq(n+1)*p;
     p = incrP(p,a,b,n,N);
  end
end




            