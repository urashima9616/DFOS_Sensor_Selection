%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Linear regression estimation for vector ARFIMA model
% Estimation applicatin example
%
% Input arguments:
%
%   N          : length of time series
%
%   p          : the autoregression order
%
%   M          : Dimension of time series
%
%   d          : fractional differencing order vector
%
%   X          : M by N matrix of time series
% Output arguments: 
%
%   Z          : correlation matrix cell
% 
%
% (c) Yuankun Xue 2015
% University of Southern California
% All copyrights reserved
function Z=cvx_estimator(X,p,d,lambda)
[M N]=size(X);
X_msr=X_gen(X,p,N); % correlation matrix
for i=1:p
	Z{i}=zeros(M,M);
end



for i=1:M
temp=Frac_bin_expansion(X(i,:),d(i),10);  % Get the Z series for one of the time series 
%X_msr==X
%temp_coeff=y
%||Xa-Y||_2+||a||_1
cvx_begin quiet
    variable temp_coeff(M*p)
   minimize(norm(X_msr*temp_coeff-temp',2)+ lambda*norm(temp_coeff,1))
%    minimize(norm(X_msr*temp_coeff-temp',2)+ 1*norm(temp_coeff,1))
    % minimize(norm(X_msr*temp_coeff-temp',2))
cvx_end
%temp_coeff=regress(temp',X_msr);
for j=1:p
	index=zeros(1,M);
	for k=1:M
		index(k)=(k-1)*p+j;
	end
	Z{j}(i,:)=temp_coeff(index)';
end

end


end


