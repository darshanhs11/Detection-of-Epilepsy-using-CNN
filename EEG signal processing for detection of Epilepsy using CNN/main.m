%%
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
    data_b = b(:,j);
    data_c = c(:,j);
    data_d = d(:,j);
    data_e = e(:,j);        
    x = 1:ceil(Fs);         
    i = 0;                 % used to access row data
    
    for i = 1:floor(time)
        
        y_a = data_a(x);
        y_b = data_b(x);
        y_c = data_c(x);
        y_d = data_d(x);
        y_e = data_e(x);
        
        % statistical features used are- f1:mean, f2:median, f3:mode, f4:standard deviation, f5:minimum, f6:maximum,
        % f7:skewness, f8:kurtosis, f9:mobility, f10:complexity, f11:hurst exponent
        
        s_a(k,:) = stat_feat(y_a);
        s_b(k,:) = stat_feat(y_b);
        s_c(k,:) = stat_feat(y_c);
        s_d(k,:) = stat_feat(y_d);
        s_e(k,:) = stat_feat(y_e);
        
        % features on 4 level db4 wavelet coefficients(cd1,cd2,cd3,cd4,a4) used are-
        % f12-f16: max, f17-f21: min, f22-f26: mean, f27-f31:standard deviation
        
        w_a(k,:) = wav_feat(y_a);
        w_b(k,:) = wav_feat(y_b);
        w_c(k,:) = wav_feat(y_c);
        w_d(k,:) = wav_feat(y_d);
        w_e(k,:) = wav_feat(y_e);
        
        x = x + ceil(Fs);
        
        k = k + 1;
    end
end

%%
statf = [s_a;s_e;s_c];
wavf = [w_a;w_e;w_c];
label = [zeros(2300,1);ones(4600,1)];

data = [statf wavf label];
[trainedClassifier, validationAccuracy] = trainClassifier1(data)
 validationAccuracy
