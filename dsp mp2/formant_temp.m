filename = 'speech_MP2.wav';
[x,fs] = audioread(filename);

x1 = x.*hamming(length(x));
preemph = [1 0.63];
x1 = filter(1,preemph,x1);
A = lpc(x1,8);
rts = roots(A);
rts = rts(imag(rts)>=0);
angz = atan2(imag(rts),real(rts));
[frqs,indices] = sort(angz.*(fs/(2*pi)));
bw = -1/2*(fs/(2*pi))*log(abs(rts(indices)));
nn = 1;
for kk = 1:length(frqs)
    if (frqs(kk) > 90 && bw(kk) <400)
        formants(nn) = frqs(kk);
        nn = nn+1;
    end
end
formants


% #####% #####% #####% #####% #####% #####% #####% #####

% x = allframes(:, 15);
% 
% % get Linear prediction filter
% ncoeff=2+fs/1000;           % rule of thumb for formant estimation
% a=lpc(x,ncoeff);
% %
% % plot frequency response
% [h,f]=freqz(1,a,512,fs);
% subplot(2,1,2);
% plot(f,20*log10(abs(h)+eps));
% legend('LP Filter');
% xlabel('Frequency (Hz)');
% ylabel('Gain (dB)');
% 
% % find frequencies by root-solving
% r=roots(a);                  % find roots of polynomial a
% r=r(imag(r)>0.01);           % only look for roots >0Hz up to fs/2
% ffreq=sort(atan2(imag(r),real(r))*fs/(2*pi));
% 
%                              % convert to Hz and sort
% 
% for i=1:length(ffreq)
%     fprintf('Formant %d Frequency %.1f\n',i,ffreq(i));
% end