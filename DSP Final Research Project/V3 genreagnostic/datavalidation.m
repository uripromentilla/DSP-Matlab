% cd ~; cd 'Documents/MATLAB/dsp-final-project';

% get all keys and all mp3
cd 'Datasets/giantsteps-key-dataset-master/key';
% list of key files
keydir = dir('*.key'); 
for i=1:length(keydir)
    filecode = strsplit(keydir(i).name,'.');
    filecode(1)
end
cd ..; cd ..; cd ..;
cd 'Datasets/giantsteps-key-dataset-master/audio';
cd ..; cd ..; cd ..;

filename = '10089.LOFI.key';
fileID = fopen(filename);
A = fscanf(fileID, '%s');

