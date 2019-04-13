function [signal, fs, groundkeynum] = readdata(filecode)

% read key
fileID = fopen(strcat(filecode, '.LOFI.key'));
groundkey = fscanf(fileID, '%s');

% parse key to number
switch groundkey
    case 'Amajor'
        groundkeynum = 1;
    case 'Gbminor'
        groundkeynum = 1;
    case 'Abmajor'
        groundkeynum = 2;
    case 'Fminor'
        groundkeynum = 2;
    case 'Bmajor'
        groundkeynum = 3;
    case 'Abminor'
        groundkeynum = 3;
    case 'Bbmajor'
        groundkeynum = 4;
    case 'Gminor'
        groundkeynum = 4;
    case 'Cmajor'
        groundkeynum = 5;
    case 'Aminor'
        groundkeynum = 5;
    case 'Dmajor'
        groundkeynum = 6;
    case 'Bminor'
        groundkeynum = 6;
    case 'Dbmajor'
        groundkeynum = 7;
    case 'Bbminor'
        groundkeynum = 7;
    case 'Emajor'
        groundkeynum = 8;
    case 'Dbminor'
        groundkeynum = 8;
    case 'Ebmajor'
        groundkeynum = 9;
    case 'Cminor'
        groundkeynum = 9;
    case 'Fmajor'
        groundkeynum = 10;
    case 'Dminor'
        groundkeynum = 10;
    case 'Gmajor'
        groundkeynum = 11;
    case 'Eminor'
        groundkeynum = 11;
    case 'Gbmajor'
        groundkeynum = 12;
    case 'Ebminor'
        groundkeynum = 12;
    otherwise
        disp("PARSING FAILURE");
end
    
% read mp3 file
[signal,fs] = audioread(strcat(filecode, '.LOFI.mp3'));
signal = downsample(signal,2);
% signalplot = figure; plot(signal); 

