
% Read the file
filename = 'speech_MP1.wav';
[signal,Fs] = audioread(filename);
info = audioinfo(filename);
% plot(signal);

% Split/Segment into Frames with overlapping 
rate = 16000; %16000 per second
duration = 0.03; %30ms in seconds
overlap = 16000 * 0.015; %total samples in 15ms
framelen = rate * duration; %=480 of length by 155 frames
N = length(signal);
num_frames = floor(N/framelen);
allframes = buffer(signal,framelen,overlap);
% plot(allframes);

% Get peaks of each frame
[row, col] = size(allframes);
peaksperframe = zeros(1, col);
for i=1:col
    peaksperframe(i) = max(findpeaks(allframes(:,i)));
end
% plot(peaksperframe)

% Get peaks per FFT Frame
% 1. FFT each frame
% 2. Get peak of each FFT
[row, col] = size(allframes);
fftperframe = zeros(1, col);
for i=1:col
    fftperframe(i) = max(findpeaks( abs(fft(allframes(:,i) - mean(allframes(:,i)))/length(allframes(:,i))) ) );
end
% plot(fftperframe)

% Plot graphs
f1 = figure;
subplot(2,1,1);
plot(signal);
title('Signal Graph');
subplot(2,1,2);
plot(peaksperframe);
title('Peaks Per Frame Graph');

% Adjust FFT per frame to superimpose on the signal graph
[fftRow, fftCol] = size(fftperframe);
numOfSpaces = floor(N / fftCol);
imposedFT = NaN(N, 1);
ctr = 1;
for i = 1:numOfSpaces:N
    if i <= N & ctr <= fftCol 
        imposedFT(i) = fftperframe(ctr);
    end
    ctr = ctr+1;
end
imposedFT = fillmissing(imposedFT,'nearest');
% stairs(imposedFT);

% Plot superimpose of FFT to signal graph
f2 = figure;
yyaxis left;
stairs(imposedFT);
yyaxis right;
plot(signal);
title('Peak FFT Per Frame with Signal Graph');

% Get entire signal FFT and adjust to single-sided amplitude
f3 = figure;
Fs = rate;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = N;             % Length of signal
t = (0:L-1)*T;        % Time vector
Y = fft(signal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% entire signal FFT 2
% entirefft = abs(fft(signal - mean(signal))/length(signal));
% plot(entirefft);




