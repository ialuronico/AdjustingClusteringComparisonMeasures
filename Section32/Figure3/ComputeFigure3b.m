clear all;
close all;
clc;

rs = [2 4 6 8 10];
N = 100;
c = 6;
qs = [0.9 1.2 2];
samples = 100; 


AVIq = zeros(length(qs), length(rs));
ARandIndexToPlot = zeros(1,length(rs));
AMIToPlot = zeros(1,length(rs));
for qi=1:length(qs)
    q = qs(qi);
    disp(q);
    for ri=1:length(rs)
        r = rs(ri);
        VIcollect = zeros(1,samples);
        parfor s=1:samples            
            U = zeros(1,N);
            V = zeros(1,N);
            for ind=1:N
                U(ind) = randi(c);
                V(ind) = randi(r);
            end
            VIcollect(s) = computeAMIq(U,V,q);
            
            if(q == 2)
                [ARI_] = valid_RandIndex(U,V);
                ARIcollect(s) = ARI_; 
                AMIcollect(s) = ami(U,V); 
            end
        end
        AVIq(qi,ri) = mean(VIcollect);
        
        if (q == 2)
            ARandIndexToPlot(ri) = mean(ARIcollect);
            AMIToPlot(ri) = mean(AMIcollect);
        end
    end
end

save('figure3b');
disp('Done.');