%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Linear regression estimation for vector ARFIMA model
% Data preprocess--Matrix X generation
% generate the new time series Z
% Z(t)=X*W+E
%
% Input arguments:
%
%   Y          : the K-element time series vector
%
%   p          : the autoregression order
%
%   N          : the length of observations
%   m          : the m-th time series of interest
% Output arguments: 
%
%   X          : KP*N matrix
% 
%
% (c) Yuankun Xue 2015
% University of Southern California
% All copyrights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [X]= X_gen_frac(Y,p,N,m,infi)

K=length(Y(:,1)');
X=zeros(N,(K-1)*p+infi);
for i=1:N
	for j=1:K
        if(j>m)
		for t=1:p
			if(i>t)
				X(i,(j-2)*p+infi+t)=Y(j,i-t);
			end
        end
        elseif(j<m)
        for t=1:p
			if(i>t)
				X(i,(j-1)*p+t)=Y(j,i-t);
			end
        end
        
            else
              for t=1:infi
                if(i>t)
                 X(i,(j-1)*p+t)=Y(j,i-t);
                end
              end
        end
    end
end
end




