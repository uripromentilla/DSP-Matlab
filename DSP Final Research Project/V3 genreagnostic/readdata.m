function [signal, fs, groundkeynum] = readdata(filecode)

% read ground key
% read key
fileID = fopen(strcat(filecode, '.lerch.txt'));
groundkey = fscanf(fileID, '%s');

% parse key to number
switch groundkey
    case '0'
        groundkeynum = 1;
    case '21'
        groundkeynum = 1;
    case '11'
        groundkeynum = 2;
    case '20'
        groundkeynum = 2;
    case '2'
        groundkeynum = 3;
    case '23'
        groundkeynum = 3;
    case '1'
        groundkeynum = 4;
    case '22'
        groundkeynum = 4;
    case '3'
        groundkeynum = 5;
    case '12'
        groundkeynum = 5;
    case '5'
        groundkeynum = 6;
    case '14'
        groundkeynum = 6;
    case '4'
        groundkeynum = 7;
    case '13'
        groundkeynum = 7;
    case '7'
        groundkeynum = 8;
    case '16'
        groundkeynum = 8;
    case '6'
        groundkeynum = 9;
    case '15'
        groundkeynum = 9;
    case '8'
        groundkeynum = 10;
    case '17'
        groundkeynum = 10;
    case '10'
        groundkeynum = 11;
    case '19'
        groundkeynum = 11;
    case '9'
        groundkeynum = 12;
    case '18'
        groundkeynum = 12;
    otherwise
        groundkeynum = -1;
%         disp("PARSING FAILURE");
end
    
% read audio file
[signal,fs] = audioread(strcat(filecode, '.au'));
% signal = downsample(signal,2);

