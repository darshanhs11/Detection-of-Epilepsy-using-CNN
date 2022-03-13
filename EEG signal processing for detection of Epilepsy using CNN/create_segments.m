%%
clearvars
load sets.mat;
Fs = 173.61;
samples = 4097;
time = samples/Fs;
channels = 100;
k = 1;

%%

for j = 1:channels          
    
    % for each channel
    data_a = a(:,j);       
    data_e = e(:,j);        
    x = 1:ceil(Fs);         
    i = 0;                 
    
    for i = 1:floor(time)
        
        y_a = data_a(x);
        y_e = data_e(x);
        
        s_a(k,:) = stat_feat(y_a);
        s_e(k,:) = stat_feat(y_e);
     
        w_a(k,:) = wav_feat(y_a);
        w_e(k,:) = wav_feat(y_e);
        
        x = x + ceil(Fs);
        
        k = k + 1;
    end
end

statf = [s_a;s_e];
wavf = [w_a;w_e];
label = [zeros(2300,1);ones(2300,1)];

data = [statf wavf label];