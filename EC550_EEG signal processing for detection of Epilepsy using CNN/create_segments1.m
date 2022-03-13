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
    
    %% for each channel
    
    data_a = a(:,j);        
    filt_a = filter(lpfilter,data_a);
    suptitle(sprintf('Channel:%d',j));
    % representation
    subplot(3,1,1);
    plot(data_a); hold on
    plot (filt_a)
    legend ('Original EEG','Filtered EEG'); hold off
    
    [~,locs] = findpeaks(filt_a,'MinPeakProminence',50);
    [~,locs_inv] = findpeaks(-filt_a,'MinPeakProminence',50);
    locus = sort([locs' locs_inv']);
    segments = filt_a(locus)';
    
    subplot(3,1,2);
    plot(filt_a); hold on
    plot(locus,segments)
    legend('Filtered EEG','Representation by Sequence'); hold off
    
    % epoch
    x = 1:ceil(Fs);        
    i = 0;                  
    for i = 1:ceil(time)
        loc_ep = locus((locus >= x(1) & locus <= x(end)));
        y_ep = segments(locus >= x(1) & locus <= x(end));
        subplot(3,1,3);
        plot(locus,segments); hold on
        plot(loc_ep,y_ep);
      %  xlim([x(1) x(end)])
        legend('Representation by Sequence','Epoch'); hold off
        
        % features
        s_a(k,:) = stat_feat(y_ep');
     
        w_a(k,:) = wav_feat(y_ep');
        
        
        x = x + ceil(Fs);
        k = k + 1;
    end
end

for j = 1:channels          
    
    %% for each channel
    
    data_e = e(:,j);        
    filt_e = filter(lpfilter,data_e);
    
    % representation
    suptitle(sprintf('Channel:%d',j));
    subplot(3,1,1);
    plot(data_e); hold on
    plot (filt_e)
    legend ('Original EEG','Filtered EEG'); hold off
    
    [~,locs] = findpeaks(filt_e,'MinPeakProminence',50);
    [~,locs_inv] = findpeaks(-filt_e,'MinPeakProminence',50);
    locus = sort([locs' locs_inv']);
    segments = filt_e(locus)';
    
    subplot(3,1,2);
    plot(filt_e); hold on
    plot(locus,segments)
    legend('Filtered EEG','Representation by Sequence'); hold off
    
    % epoch
    x = 1:ceil(Fs);         
    i = 0;                 
    for i = 1:ceil(time)
        loc_ep = locus((locus >= x(1) & locus <= x(end)));
        y_ep = segments(locus >= x(1) & locus <= x(end));
        subplot(3,1,3);
        plot(locus,segments); hold on
        plot(loc_ep,y_ep);
   
        legend('Representation by Sequence','Epoch'); hold off
        
        % features
        s_e(k,:) = stat_feat(y_ep');
        
        w_e(k,:) = wav_feat(y_ep');
        
        
        x = x + ceil(Fs);
        k = k + 1;
    end
end

statf = [s_a;s_e];
wavf = [w_a;w_e];
label = [zeros(2400,1);ones(4800,1)];

data = [statf wavf label];