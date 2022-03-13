function Hd = lpfilter
Fs = 173.61;  % Sampling Frequency

N    = 10;         % Order
Fc   = 40;         % Cutoff Frequency
flag = 'noscale';  % Sampling Flag
Beta = 0.5;        % Window Parameter

win = kaiser(N+1, Beta);

b  = fir1(N, Fc/(Fs/2), 'low', win, flag);
Hd = dfilt.dffir(b);
