% Read the file
filename = 'speech_MP2.wav';
[signal,fs] = audioread(filename);
info = audioinfo(filename);
signalplot = figure; plot(signal); 

% Split/Segment into Frames with Overlapping 
rate = fs; %16000 per second gotten from info
duration = 0.05; %50ms in seconds
overlap = rate * 0.04; %total samples in 40ms
framelen = rate * duration; %=800 SAMPLES of length by 181 FRAMES
N = length(signal);
num_frames = floor(N/framelen);
allframes = buffer(signal,framelen,overlap);
% allframesplot = figure; plot(allframes); 

[row, col] = size(allframes);

% Determining Voiced or Unvoiced Segment
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


% Setting Unvoiced Segments to 0
for i = 1:col
    if vuvlist(i) == 0 %if unvoiced
        allframes(:, i) = 0;
    end
end

% [audioIn,fs] = audioread('speech_MP2.wav');
[f0,idx] = pitch(signal,fs, 'Range',[10,700],'Method','CEP'); 
%the fs range is like a window, the bigger the less segments
%CEP range is from 7.8~399 
% [f0frame,idxframe] = pitch(allframes(:, 104),fs-1000, 'Range',[10,399],'Method','CEP');
f0list = zeros(col, 1);
idxlist = zeros(col, 1);
% Cepstrum Pitch Detection Per Frame
for i = 1:col
    if vuvlist(i) == 1 %if voiced
        f0list(i) = pitch(allframes(:, i),fs-1000, 'Range',[10,700],'Method','CEP');
    end
end

% PLOTTING

ampliplot = figure;
subplot(2,1,1)
plot(signal)
ylabel('Amplitude')
title('Signal')

t = idx/fs;
subplot(2,1,2)
plot(t,f0)
ylabel('Pitch (Hz)')
xlabel('Time (s)')
title('Original Pitch Contour')

modsignal = figure
subplot(2,1,1)
subplot(2,1,1)
plot(signal)
ylabel('Amplitude')
title('Signal')

newsignal = [];
for i = 1:col
    newsignal = cat(1, newsignal, allframes(1:160, i));
end
subplot(2,1,2)
plot(newsignal)
ylabel('Amplitude')
title('Modified Signal')

pitchcontourplot = figure;
subplot(2,1,1)
plot(idx,f0)
ylabel('Pitch (Hz)')
xlabel('Sample Number')
title('Original Pitch Contour')

subplot(2,1,2)
plot((1:181).*framelen,f0list)
ylabel('Pitch (Hz)')
xlabel('Sample Number')
title('Modified Pitch Contour')

