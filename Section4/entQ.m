function [ hq ] = entQ( ps,q )
%ENTQ Summary of this function goes here
%   Detailed explanation goes here

hq = 1;
for i=1:length(ps)
  hq = hq - ps(i)^q;
end
hq = hq/(q-1);

