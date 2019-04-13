
% setup
databasefrequencies;
databasekeys;

% read mp3 file
[signal,fs] = audioread('10089.LOFI.mp3');
signal = downsample(signal,2);

f0 = pitch(signal(:, 1), fs, 'Method', 'CEP');
detectednotes = zeros(length(f0), 1);
[row, col] = size(ndball);

% finds the minimum difference between the frequency and the notes database
% and selects the note
for i=1:length(f0)
    ndballmin = abs(ndball - f0(i));
    closest =  min(ndballmin, [], 'all');
    for r=1:row
        for c=1:col
            if closest == ndballmin(r,c)
                detectednotes(i) = c;
                % detectednotes(i) is a list of detected notes
            end
        end
    end
end

% counts the notes that occurred
notecount = zeros(1, 12);
for i = 1:length(detectednotes)
    notecount(detectednotes(i)) = notecount(detectednotes(i)) + 1;
end

% notecount - counts per note
% notelist - counts per note but is tampered

% keep getting the the max occuring note until there is only 1 best match
notelist = notecount;
notesmatcher = zeros(12, 1);
candidates = 1:12;
topn = 1;
matchedkeys = 10;
while matchedkeys > 1
    % get the maximum note
    [noteval, noteloc] = max(notelist);
    notesmatcher(topn) = noteloc;
    notelist(noteloc) = 0;
    
    % get the counts of matched notes
    notesmatched = zeros(1, 12);
    for k=1:length(candidates) %for each candidate keys, match only the candidates
        for n=1:topn %for each (current) topnotes being considered
            for m=1:7 %for each row/harmonic in the kdball
                if notesmatcher(n) == kdball(m, candidates(k)) %if the the top n note matches a note in the candidate key rows then
                    notesmatched(candidates(k)) = notesmatched(candidates(k))+1; %increment number of matches in the candidate
                end
            end
        end
    end
    
    % find the best matches
    [bestmatchval, bestmatchloc] = max(notesmatched);
    
    % only the best candidates will remain, until only 1 remains -> that is
    % the predicted key
    
    % update candidates
    candidates = 1:12;
    candidates = candidates(notesmatched==bestmatchval);
    
    matchedkeys = sum(notesmatched==bestmatchval);
    topn = topn+1;
end

predictedkey = candidates;

strpredictedkey = numtonotes(predictedkey);