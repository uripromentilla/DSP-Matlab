% Read the file
% filename = 'piano-c_C_major.wav';
filename = 'c1.wav';
[signal,fs] = audioread(filename);
info = audioinfo(filename);

[f0,idx] = pitch(signal,fs);

figure('Name','Signal','NumberTitle','off');
subplot(2,1,1)
plot(signal)
ylabel('Amplitude')

subplot(2,1,2)
plot(idx,f0)
ylabel('Pitch (Hz)')
xlabel('Sample Number')