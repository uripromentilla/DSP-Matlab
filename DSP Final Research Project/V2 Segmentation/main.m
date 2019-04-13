
keydir = dir('*.key'); % list of key files
keylen = length(keydir);
classificationresults = cell(keylen, 4);
accuracytable = zeros(keylen, 2);

for i=1:keylen
    filename = strsplit(keydir(i).name,'.');
    filecode = string(filename(1));
    classificationresults(i, 1) = {filecode};
    [result, strgroundkey, strpredictedkey] = keyclassification(filecode);
    classificationresults(i, 2) = {result};
    classificationresults(i, 3) = {strgroundkey};
    classificationresults(i, 4) = {strpredictedkey};
    accuracytable(i, 1) = filecode;
    accuracytable(i, 2) = result;
    disp(num2str(i)+"/"+num2str(keylen));
end

accuracyrate = sum(accuracytable(:, 2))/length(accuracytable)*100;
