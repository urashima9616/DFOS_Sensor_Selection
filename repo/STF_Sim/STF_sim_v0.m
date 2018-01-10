%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation for STF model
% generate the new time series Z
% D(L)X(T)=A(L)*X(T)+E
% Input arguments:
%
%   A(L)       : KxKxp square matrix that encodes the correlation between different
%                time series
%   p          : AR order
%   N          : the length of simulation
%   d          : fractional differencing order vector

% Output arguments: 
%
%   X          : K*N matrix
%
% (c) Yuankun Xue 2015
% University of Southern California
% All copyrights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [X,K]=STF_sim_v0(A,p,N,d,ctrl)
dim=length(A(1,:,1));
err=normrnd(0,1,dim,N);
%err=zeros(dim,N);
infi=10;
X=zeros(dim,N);
K=zeros(dim,N);

for i=1:N % For each time step,
    for j=1:dim % For each time series
        temp_1=0;
        for k=1:p % First incoporate the AR part
            if(i>k) % consider only those observable
                for l=1:dim % j-th row vector of Alpha matrix k x Vector(X(:,i-k))
                temp_1=temp_1+A(j,l,k)*X(l,i-k);
                end
            end
        end
        if(ctrl==0)
        temp_1=temp_1+err(j,i); % merge the white noise
        else
        temp_1=temp_1+err(j,i); % merge the white noise 
        end
        temp_2=0;
        for k=1:infi
           if(i>k)
               %factor=binominal_exp_ceff(d(j),k)
               %X(j,i-k)
               %step=factor.*X(j,i-k)
               temp_2=temp_2+binominal_exp_ceff(d(j),k).*X(j,i-k);
           end
        end
       X(j,i)=temp_1-temp_2;
        
    end
end

end




