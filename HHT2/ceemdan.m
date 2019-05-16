function [modes its]=ceemdan(x,Nstd,NR,MaxIter)

% WARNING: for this code works it is necessary to include in the same
%directoy the file emd.m developed by Rilling and Flandrin.
%This file is available at %http://perso.ens-lyon.fr/patrick.flandrin/emd.html
%We use the default stopping criterion.
%We use the last modification: 3.2007
% 
% This version was run on Matlab 7.10.0 (R2010a)
%----------------------------------------------------------------------
%   INPUTs
%   x: signal to decompose
%   Nstd: noise standard deviation
%   NR: number of realizations
%   MaxIter: maximum number of sifting iterations allowed.
%
%  OUTPUTs
%  modes: contain the obtained modes in a matrix with the rows being the modes        
%   its: contain the sifting iterations needed for each mode for each realization (one row for each realization)
% -------------------------------------------------------------------------
%  Syntax
%
%  modes=ceemdan(x,Nstd,NR,MaxIter)
%  [modes its]=ceemdan(x,Nstd,NR,MaxIter)
%
%--------------------------------------------------------------------------
% This algorithm was presented at ICASSP 2011, Prague, Czech Republic
% Plese, if you use this code in your work, please cite the paper where the
% algorithm was first presented. 
% If you use this code, please cite:
%
% M.E.TORRES, M.A. COLOMINAS, G. SCHLOTTHAUER, P. FLANDRIN,
%  "A complete Ensemble Empirical Mode decomposition with adaptive noise," 
%  IEEE Int. Conf. on Acoust., Speech and Signal Proc. ICASSP-11, pp. 4144-4147, Prague (CZ)
%
% -------------------------------------------------------------------------
% Date: June 06,2011
% Authors:  Torres ME, Colominas MA, Schlotthauer G, Flandrin P.
% For problems with the code, please contact the authors:   
% To:  macolominas(AT)bioingenieria.edu.ar 
% CC:  metorres(AT)santafe-conicet.gov.ar
% -------------------------------------------------------------------------

x=x(:)';
desvio_x=std(x);
x=x/desvio_x;

modes=zeros(size(x));
temp=zeros(size(x));
aux=zeros(size(x));
acum=zeros(size(x));
iter=zeros(NR,round(log2(length(x))+5));

for i=1:NR
    white_noise{i}=randn(size(x));%creates the noise realizations
end;

for i=1:NR
    modes_white_noise{i}=emd(white_noise{i});%calculates the modes of white gaussian noise
end;

for i=1:NR %calculates the first mode
    temp=x+Nstd*white_noise{i};
    [temp, o, it]=emd(temp,'MAXMODES',1,'MAXITERATIONS',MaxIter);
    temp=temp(1,:);
    aux=aux+temp/NR;
    iter(i,1)=it;
end;

modes=aux; %saves the first mode
k=1;
aux=zeros(size(x));
acum=sum(modes,1);

while  nnz(diff(sign(diff(x-acum))))>2 %calculates the rest of the modes
    for i=1:NR
        tamanio=size(modes_white_noise{i});
        if tamanio(1)>=k+1
            noise=modes_white_noise{i}(k,:);
            noise=noise/std(noise);
            noise=Nstd*noise;
            try
                [temp, o, it]=emd(x-acum+std(x-acum)*noise,'MAXMODES',1,'MAXITERATIONS',MaxIter);
                temp=temp(1,:);
            catch
                it=0;
                temp=x-acum;
            end;
        else
            [temp, o, it]=emd(x-acum,'MAXMODES',1,'MAXITERATIONS',MaxIter);
            temp=temp(1,:);
        end;
        aux=aux+temp/NR;
    iter(i,k+1)=it;    
    end;
    modes=[modes;aux];
    aux=zeros(size(x));
    acum=zeros(size(x));
    acum=sum(modes,1);
    k=k+1;
end;
modes=[modes;(x-acum)];
[a b]=size(modes);
iter=iter(:,1:a);
modes=modes*desvio_x;
its=iter;


   