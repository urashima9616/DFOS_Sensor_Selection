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
function [X_k]=VARFIMA_predct_step_v3(A,d,X,step)
%dimension of vector
[tt,dim]=size(A);
[tt,len]=size(X(1,:));
%err=zeros(dim,N);
X_k=zeros(dim,len);
X_aux=zeros(dim,len);
infi=20;
%steps=ceil((len-1)./step);
steps=ceil(len./step);
resd=mod(len,step);
%Initial condition
X_k(:,1:step)=X(:,1:step);


for t=2:steps
   X_aux(:,1:(t-1)*step)=X(:,1:(t-1)*step);    
    for kk=1:step
        
        for i=1:dim
            temp_2=0;
            temp_1=A(i,:)*X_aux(:,(t-1)*step+kk-1);
            
            for j=1:infi
                if((t-1)*step+kk>j)
                    temp_2=temp_2+X_aux(i, (t-1)*step+kk-j ).*binominal_exp_ceff(d(i),j);
                end
                
                
            end
            
             X_aux(i,(t-1)*step+kk)=temp_1-temp_2;
        end
        
    end
    
    X_k(:,(t-1)*step+1:(t-1)*step+kk)=X_aux(:,(t-1)*step+1:(t-1)*step+kk);
    
end

       X_k=X_k(:,1:len); 
    end












