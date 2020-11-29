function [data,a]=splinenormalize(data)
 
% The function SPLINENORMALIZE normalizes with splines,
% the data(n,m) where n specifies the number of time points, 
% and m is the number of IMF components.
% The normalization is carried out with both maxima and minima; hence emax
% is taken as the absolute sign.
%
% Calling sequence-
% [data,a]=splinenormalize(data)
%
% Input-
%	data	- 2-D matrix data(n,m) that specifies the IMF components 
% Output-
%	data	- normalized data
%	a	    - splined envelope
%
% Used by-
%	FA
 
% K. Arnold (for NASA GSFC)	    Jan. 28 2004 Modified
%				(fixed a bug where a "random" point 
%				could get thrown somewhere in the middle
%				of the dataset and the endpoints 
%				were not controlled).
%  Modified Karin Blank March 22, 2005
%----- Get the dimension
[n,m] = size(data);

%----- Initialize and flip data if needed 
flipped=0;
if (n<m)
    flipped=1;
    data=data';
    [n,m]=size(data);
end

te=(1:n)';
%----- Process each IMF component
for c=1:m
    %----- Extract the set of max points and their coordinates
   % [mx, tx]=emax(abs(data(:,c)));
    [tx,mx]=locoma(abs(data(:,c)));
    tx=tx';
    mx=mx';
    %----- Fix the end to prevent wide swaying in spline 
    %----- by assigning the te(1) and te(n) 
    %----- the same values as the first and last tx and mx.
    nExtrema=length(mx);
    if nExtrema > 1
        tx=[1;tx;n];
        %----- Fix the ends at the same as the next point
        mx=[mx(1);mx;mx(nExtrema)];    
        a(:,c)=spline(tx,mx,te);
        
        %***linear interpolation backup in case spline error. Added by KBB.
        %Experimental
        if(any(a(:, c) < data(:,c)))
            a2 = interp1(tx, mx, te);
            
            mask_sp = ones(length(a), 1);
            
            for(i=1:length(tx)-1)
                if(any(a(tx(i):tx(i+1),c) < data(tx(i):tx(i+1),c)))
                    mask_sp(tx(i):tx(i+1)) = 0;
                end
            end
            
    %        mask_sp = (a(:,c) >= data(:, c)); 
        
            a(:, c) = (a(:,c) .* mask_sp) + (a2 .* ~mask_sp);
        end      
        %end KBB
        
        %----- %  Normalize the data by splined envelope
        data(:,c)=data(:,c)./a(:,c);

    else
        %----- Leave data unchanged
        a(:,c)=ones(n,1);
    end
end

%----- Flip data back if needed
if (flipped)
    data=data';
    a=a';
end

