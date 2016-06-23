clear all;
close all;
clc;

rs = [2 4 6 8 10];
N = 100;
c = 6;
qs = [0.9 1.2 2];
samples = 100; 


VIq = zeros(length(qs), length(rs));
RandIndexToPlot = zeros(1,length(rs));
for qi=1:length(qs)
    q = qs(qi);
    disp(q);
    for ri=1:length(rs)
        Scollect = zeros(1,samples);
        r = rs(ri);
        parfor s=1:samples            
            U = zeros(1,N);
            V = zeros(1,N);
            for ind=1:N
                U(ind) = randi(c);
                V(ind) = randi(r);
            end
            VIcollect(s) = computeNMIq(U,V,q);
            
            if(q == 2)
                [~, RI_] = valid_RandIndex(U,V);
                RIcollect(s) = (N-1)/N*(1 - RI_);          
            end
        end
        VIq(qi,ri) = mean(VIcollect);
        
        if (q == 2)
            RandIndexToPlot(ri) = mean(RIcollect);
        end
    end
end

save('figure3a');
disp('Done.');