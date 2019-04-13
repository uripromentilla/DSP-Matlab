function [result, strgroundkey, strpredictedkey] = keyclassification(filecode)

% read data + parse ground keys
[signal, fs, groundkeynum] = readdata(filecode);

% predict key
predictedkey = predictkey(signal, fs);

% check predicted key with ground key
if predictedkey == groundkeynum
    result = true;
else
    result = false;
end

strgroundkey = numtonotes(groundkeynum);
strpredictedkey = numtonotes(predictedkey);





