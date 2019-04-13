function notename = numtonotes(num)

switch num
    case 1
        notename = 'Amajor/Gbminor';
    case 2
        notename = 'Abmajor/Fminor';
    case 3
        notename = 'Bmajor/Abminor';
    case 4 
        notename = 'Bbmajor/Gminor';
    case 5
        notename = 'Cmajor/Aminor';
    case 6
        notename = 'Dmajor/Bminor';
    case 7
        notename = 'Dbmajor/Bbminor';
    case 8 
        notename = 'Emajor/Dbminor';
    case 9
        notename = 'Ebmajor/Cminor';
    case 10
        notename = 'Fmajor/Dminor';
    case 11
        notename = 'Gmajor/Eminor';
    case 12
        notename = 'Gbmajor/Ebminor';
    otherwise
%         disp("PARSING FAILURE"); 
        notename = 'F';
end