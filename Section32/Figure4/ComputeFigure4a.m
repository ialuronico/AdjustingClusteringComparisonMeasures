clear all;
close all;
clc;

Allperc = [50 60 70 80 90]/100;
N = 100;
c = 6;
qs = [0.8 0.9 1.2 1.5 2 2.5];
samples = 1000; 


VIq = zeros(length(qs), length(Allperc));
RandIndexToPlot = zeros(1,length(Allperc));
for qi=1:length(qs)
    q = qs(qi);
    disp(q);
    for nperc=1:length(Allperc)
        perc = Allperc(nperc);
        parfor s=1:samples            
            U = zeros(1,N);
            V = zeros(1,N);
            for ind=1:N
                U(ind) = randi(c);
                p = rand();
                if ( p < perc)
                    V(ind) = 1;
                else
                    V(ind) = 2;
                end
            end
            VIcollect(s) = computeNMIq(U,V,q);
            
            if(q == 2)
                [~, RI_] = valid_RandIndex(U,V);
                RIcollect(s) = (N-1)/N*(1 - RI_);       
            end
        end
        VIq(qi,nperc) = mean(VIcollect);
        
        if (q == 2)
            RandIndexToPlot(nperc) = mean(RIcollect);
        end
    end
end

save('figure4a');
disp('Done.');