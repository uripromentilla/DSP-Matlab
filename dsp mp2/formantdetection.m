ds

% Split/Segment into Frames with Overlapping 
rate = fs; %16000 per second gotten from info
duration = 0.05; %50ms in seconds
overlap = rate * 0.04; %total samples in 40ms
framelen = rate * duration; %=800 SAMPLES of length by 181 FRAMES
N = length(signal);
num_frames = floor(N/framelen);
allframes = buffer(signal,framelen,overlap);
% allframesplot = figure; plot(allframes); 

% Determining Voiced or Unvoiced Segment
[row, col] = size(allframes);
zcrlist = NaN(1, col);
stelist = NaN(1, col);
vuvlist = zeros(1, col);
% for each frame
for i = 1:col
    % get the zero crossing rate
    zcrlist(i) = ZCR(allframes(:, i));
    % get the short time energy
    stelist(i) = sum(buffer(allframes(:, i).^2, 1));
    
    % if ZCR is small and E is high then its Voiced (1)
    if zcrlist(i) < 0.1 & stelist(i) > 1
        vuvlist(i) = 1; % 1 means voiced
    end
end

spectogramplot = figure;
spectrogram(signal);
title('Signal Spectrogram');

[row, col] = size(allframes);

% For each frame, Estimate a Formant VERSION 1
formantlist = zeros(2, col);
for i = 1:col
    if vuvlist(i) == 1 % its a voiced segment
        x1 = allframes(:, i);
        preemph = [1 0.63];
        x1 = filter(1,preemph,x1);
        A = lpc(x1,8);
        rts = roots(A);
        rts = rts(imag(rts)>=0);
        angz = atan2(imag(rts),real(rts));
        [frqs,indices] = sort(angz.*((fs)/(2*pi)));
        bw = -1/2*((fs)/(2*pi))*log(abs(rts(indices)));
        nn = 1;
        for kk = 1:length(frqs)
            if (frqs(kk) > 90 && bw(kk) <400)
                formants(nn) = frqs(kk);
                nn = nn+1;
            end
        end
        formantlist(1:2, i) = formants(1, 1:2);
    end
end
formantplot1 = figure; 
plot(1:181, formantlist);
ylabel('Formant Frequency (Hz)');
xlabel('Frame Number');
title('Formant Estimation Version 1');

% For each frame, Estimate a Formant VERSION 2
formantlist2 = zeros(2, col);
for i = 1:col
    if vuvlist(i) == 1 % its a voiced segment
        x = allframes(:, i);
        % get Linear prediction filter
        ncoeff=2+fs/1000;           % rule of thumb for formant estimation
        a=lpc(x,ncoeff);
        %
        % plot frequency response
    %     [h,f]=freqz(1,a,512,fs);
    %     subplot(2,1,2);
    %     plot(f,20*log10(abs(h)+eps));
    %     legend('LP Filter');
    %     xlabel('Frequency (Hz)');
    %     ylabel('Gain (dB)');

        % find frequencies by root-solving
        r=roots(a);                  % find roots of polynomial a
        r=r(imag(r)>0.01);           % only look for roots >0Hz up to fs/2
        ffreq=sort(atan2(imag(r),real(r))*fs/(2*pi));

                                     % convert to Hz and sort
        formantlist2(1:2, i) = ffreq(1:2, 1);

    %     for i=1:length(ffreq)
    %         fprintf('Formant %d Frequency %.1f\n',i,ffreq(i));
    %     end
    end
end
formantplot2 = figure; 
plot(1:181, formantlist2);
ylabel('Formant Frequency (Hz)');
xlabel('Frame Number');
title('Formant Estimation Version 2');

% Real Formants
% Time_s   F1_Hz   F2_Hz   F3_Hz   F4_Hz
% 0.903937   1517.726308   1945.015472   2937.528480   3098.597158

