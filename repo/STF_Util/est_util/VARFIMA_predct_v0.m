%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1-step prediction for vector ARFIMA model
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
%   X_k          : K*1 vector , 1-step ahead
%
% (c) Yuankun Xue 2015
% University of Southern California
% All copyrights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [X_k]=VARFIMA_predct_v0(A,d,X)
%dimension of vector
dim=length(A(1,:));
len=length(X(1,:));
%err=zeros(dim,N);
X_k=zeros(dim,len);
infi=170;
X_k(:,1)=X(:,1);

for t=1:len
% for each of component
for i=1:dim
    % for each of the autoregressive terms
    temp_2=0; 
    temp_1=A(i,:)*X(:,t);
    for j=1:infi
        if(t+1>j)
            temp_2=temp_2+X(i,t+1-j).*binominal_exp_ceff(d(i),j);
        end
    end
    
    X_k(i,t+1)=temp_1-temp_2;
        
end
    
end











