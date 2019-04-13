function convimg = myconv(img, fil)

[row, col] = size(img);

% newimg = zeros(row+2, col+2);
% for r=1:row
%     for c=1:col
%         newimg(r+1,c+1) = img(r,c);
%     end
% end

filen = length(fil);
p = double(idivide(int32(filen), int32(2), 'floor'));
fil = double(fil);
% if filen == 3
%     p = 1;
% end
% if filen == 5
%     p = 2;
% end
% if fillen == 27
%     p = 13;

newimg = double(padarray(img, [p,p]));
[nr, nc] = size(newimg);
convimg = zeros(nr, nc);
for r=1+p:row+p
    for c=1+p:col+p
        tobeconv = newimg(r-p:r+p, c-p:c+p);
        convimg(r,c) = sum(tobeconv.*fil, 'all');
    end
end

convimg = uint8(convimg);
