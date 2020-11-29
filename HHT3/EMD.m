% Empirical Mode Decomposition
function [IMF]=EMD(yi,st);
% Input:
%     yi :Input data (1xN)
%     st :Sifting times (suggestion: 100 to 500)
% Output:
%     IMF : IMFs

% Sun Yang-Yi
% Institute of Space Science, National Central University, TAIWAN
% Jan./26/2009

[I,J]=size(yi);
if I > J;
    l_yi=I;
    yi=yi';
else
    l_yi=J;
    yi=yi;
end
xi=1:l_yi;
imfn=ceil(log2(l_yi));
IMF=zeros(imfn,l_yi);
b=0;
c=0;

ex_min_x=1;

while  length(ex_min_x) > 0;
%for k=1:imfn-1;
    c=c+1;
    r_yi=yi;
%    if k==1;[yi]=csift(yi);end
    for j=1:st;
        [ex_min_x,ex_min_y]=locomi(yi);
        [ex_max_x,ex_max_y]=locoma(yi);
        if length(ex_min_x)<=1 & length(ex_max_x)<=1 | isempty(ex_min_x) | isempty(ex_max_x);b=1;break;end
       % if isempty(ex_min_x) | isempty(ex_max_x) ;b=1;break;end
        [max_x, max_y, min_x, min_y] = mypredict(xi, yi, ex_max_x, ex_max_y, ex_min_x, ex_min_y);
        Eyi_u=spline(max_x,max_y,xi);
        Eyi_d=spline(min_x,min_y,xi);
        locomean=(Eyi_u+Eyi_d)/2;
%         close all
%         hold all
%         plot(yi,'-r');
%         plot(max_x,max_y,'.g');
%         plot(min_x,min_y,'.b');
% %         plot(Eyi_u,'-g');
% %         plot(Eyi_d,'-b');
% %         plot(ex_max_x,ex_max_y,'.g')
% %         plot(ex_min_x,ex_min_y,'.b')
%         plot(locomean,'-r');
%         plot(yi,'-k');
%         hold off
%         pause
        yi=yi-locomean;
    end
    
    IMF(c,:)=yi;
    
%     hold all
%    % plot(locomean,'-r')
%     plot(r_yi,'-k');
%     plot(IMF(c,:),'-b');
%     
%     hold off
%      disp(num2str(c,'%02u'))
%     pause
%     close all
    if b==1;break;end
    yi=r_yi-yi;
%     plot(yi)
%     pause
%     close all
end

% if k==imfn-1;
%     IMF(imfn,:)=yi;
% end
if ~isempty(ex_min_x) | ~isempty(ex_max_x) | yi(1)~=yi(2);
    IMF(c,:)=yi-nanmedian(yi);
    c=c+1;
    IMF(c,:)=ones(1,l_yi)*nanmedian(yi);
else
    IMF(c,:)=yi;
end

IMF=IMF(1:c,:);
