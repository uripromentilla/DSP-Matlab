
% Read the file
filename = 'speech_MP1.wav';
[signal,Fs] = audioread(filename);
info = audioinfo(filename);
% plot(signal);

% Split/Segment into Frames with overlapping 
rate = 16000; %16000 per second gotten from info
duration = 0.03; %30ms in seconds
overlap = rate * 0.015; %total samples in 15ms
framelen = rate * duration; %=480 of length by 155 frames
N = length(signal);
num_frames = floor(N/framelen);
allframes = buffer(signal,framelen,overlap);
% plot(allframes);

% Count zero crossings per frame
zcd = dsp.ZeroCrossingDetector;
numZeroCross = zcd(allframes);
% plot(numZeroCross);

% Plot graphs
f1 = figure;
subplot(3,1,1);
plot(signal);
title('Signal Graph');
subplot(3,1,2);
plot(allframes);
title('Each Frame Signal Graph');
subplot(3,1,3);
plot(numZeroCross);
title('Each Frame Zero Crossing Graph');

% Adjust zero crossings to superimpose zero crossing graph to signal graph 
[zcRow, zcCol] = size(numZeroCross);
numOfSpaces = floor(N / zcCol); %divide the entire audio into frames
imposedZC = NaN(N, 1);
ctr = 1;
for i = 1:numOfSpaces:N
    if i <= N && ctr <= zcCol 
        imposedZC(i) = numZeroCross(ctr);
    end
    ctr = ctr+1;
end
imposedZC = fillmissing(imposedZC,'nearest');
% stairs(imposedZC);

% Plot superimpose of zero crossing to signal
f2 = figure;
yyaxis left;
stairs(imposedZC);
yyaxis right;
plot(signal);
title('Zero Crossing per Frame with Signal Graph');




