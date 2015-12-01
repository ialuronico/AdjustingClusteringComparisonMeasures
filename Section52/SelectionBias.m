clear all;
close all;
clc;

tic;

%
% Experiment in Section 5.2 of the paper.
%
% Start Matlab parallel environment with the command matlabpool. 
% It takes around 10 minutes on my machine.
%

samples = 500; % 5000 in the paper

q = 3;

rs = [2:1:10]; 

N = 100; % Number of records
c = 4; % number of clusters for the reference partition

AVIqFreq = zeros(1,length(rs));
VIqFreq = zeros(1,length(rs));
SVIqFreq = zeros(1,length(rs));

AVIvec = [];
VIvec = [];
SVIvec = [];
parfor s=1:samples
    disp(['sample ' num2str(s)]);          
    scores = zeros(3,length(rs)); % collects the values for VIq, AVIq, SVIq here
        
    % Generate reference partition V
    V = zeros(1,N);        
    for j=1:N
        V(j) = randi(c);
    end            
    
    for ri=1:length(rs)
        r = rs(ri);
        % Generate partition U with r sets
        U = zeros(1,N);        
        for j=1:N
            U(j) = randi(r);
        end    
        
        % Compute measures
        scores(1,ri) = computeNMIq(U,V,q); 
        scores(2,ri) = computeAMIq(U,V,q); 
        scores(3,ri) = computeSMIq(U,V,q); 
    end

    win = zeros(1,3);
    
    % Compute which partition is the best
    [~, win(1)] = max(scores(1,:)); % min for VIq
    [~, win(2)] = max(scores(2,:)); % max for AVIq
    [~, win(3)] = max(scores(3,:)); % max for SVIq
    
    VIvec = [VIvec win(1)];
    AVIvec = [AVIvec win(2)];
    SVIvec = [SVIvec win(3)];
end

% Compute the frequencies of selection

for u=VIvec
    VIqFreq(u) = VIqFreq(u) + 1;
end
for u=AVIvec
    AVIqFreq(u) = AVIqFreq(u) + 1;
end
for u=SVIvec
    SVIqFreq(u) = SVIqFreq(u) + 1;
end

save('selBias');
disp('Done.');
toc
