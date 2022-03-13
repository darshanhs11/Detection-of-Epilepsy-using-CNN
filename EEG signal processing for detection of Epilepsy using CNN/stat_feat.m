function statf = stat_feat(y)

% calculate statistical features of each epoch
Mean = mean(y);
Median = median(y);
Mode = mode(y);
StdDev = std(y);
Min = min(y);
Max = max(y);
Skew = skewness(y);
Kurt = kurtosis(y);
[Mobility,Complexity] = Hjorth_Parameters(y); %,Complexity
%Hurst = hurst_exp(y');

statf = [Mean,Median,Mode,StdDev,Min,Max,Skew,Kurt,Mobility,Complexity]; %,Complexity,Hurst
end

function [mobility,complexity] = Hjorth_Parameters(y)

% HJORTHPARAMETERS computes the Hjorth parameters mobility and complexity.
n = length(y);
dy = diff([0;y]);
ddy = diff([0;dy]);
mx2 = mean(y.^2);
mdx2 = mean(dy.^2);
mddx2 = mean(ddy.^2);

mob = mdx2 / mx2;
complexity = sqrt(mddx2 / mdx2 - mob);
mobility = sqrt(mob);
end
