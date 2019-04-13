% blues.00000.au
% blues.00000.lerch.txt

keydir = dir('*.txt'); % list of key files
keylen = length(keydir);
classificationresults = cell(keylen, 4);
accuracytable = zeros(keylen, 2);

% get filecodes
filename = strsplit(keydir(1).name,'.'); %i
filecode = string(strcat(filename(1), '.', filename(2)));

% read audio file
[signal,fs] = audioread(strcat(filecode, '.au'));
signal = downsample(signal,2);

% read ground key
% read key
fileID = fopen(strcat(filecode, '.lerch.txt'));
groundkey = fscanf(fileID, '%s');




