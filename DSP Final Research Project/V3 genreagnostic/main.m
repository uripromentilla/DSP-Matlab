
keydir = dir('*.txt'); % list of key files
keylen = length(keydir);
classificationresults = cell(keylen, 4);
accuracytable = zeros(keylen, 2);
invalid = 0;
for i=1:keylen
    filename = strsplit(keydir(i).name,'.'); %i
    filecode = string(strcat(filename(1), '.', filename(2)));
    classificationresults(i, 1) = {filecode};
    [result, strgroundkey, strpredictedkey] = keyclassification(filecode);
    
    classificationresults(i, 2) = {result};
    classificationresults(i, 3) = {strgroundkey};
    classificationresults(i, 4) = {strpredictedkey};
    if strgroundkey == 'F'
        invalid = invalid+1;
    end
    accuracytable(i, 1) = filecode;
    accuracytable(i, 2) = result;
    disp(num2str(i)+"/"+num2str(keylen));
end

accuracyrate = sum(accuracytable(:, 2))/(length(accuracytable)-invalid)*100;

% invalid = 0;
% for i=1:keylen
%     if strcmp(cellstr(classificationresults(i, 3)), 'PARSING FAILURE')
%         invalid = invalid +1;
%     end
% end

