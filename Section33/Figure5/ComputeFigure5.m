clear all;
close all;
clc;

rs = [2 4 6 8 10];
N = 1000;
c = 6;
qs = [0.8 1.1 1.5];
samples = 1000;


EHqUV = zeros(length(qs), length(rs));
HqUVlimit = zeros(1,length(rs));
for qi=1:length(qs)
    q = qs(qi);
    disp(q);
    for ri=1:length(rs)
        r = rs(ri);
        EHUVcollect = zeros(1,samples);
        HUVlimitCollect = zeros(1,samples);
        parfor s=1:samples            
            U = zeros(1,N);
            V = zeros(1,N);
            for ind=1:N
                U(ind) = randi(c);
                V(ind) = randi(r);
            end
            EHUVcollect(s) = expHUV(U,V,q);           
            HUVlimitCollect(s) = HUVlimit(U,V,q);           
        end
        EHqUV(qi,ri) = mean(EHUVcollect);        
        HqUVlimit(qi,ri) = mean(HUVlimitCollect);        
    end
end

save('figure5');
disp('Done.');