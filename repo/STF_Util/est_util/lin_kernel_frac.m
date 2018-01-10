%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Blind linear regression estimation for STF
% Estimation applicatin example
%
% Input arguments:
%
%   p          : the autoregression order
%
%   X          : M by N matrix of time series
% Output arguments: 
%
%   T          : dependency vector cell
% 
%
% (c) Yuankun Xue 2015
% University of Southern California
% All copyrights reserved
function [T]=lin_kernel_frac(X,p)
%Length of expansion for fractal terms
infi=20;
[M, N]=size(X);
X_msr=X_gen(X,p,N); % correlation matrix
for i=1:M
	Z{i}=zeros(infi-p,1);
    T{i}=zeros(infi,1);
end
X_temp=zeros(N,(M-1)*p+infi);
for m=1:M
temp=X(m,:);
X_temp=X_gen_frac(X,p,N,m,infi);
temp_coeff=user_regress(temp',X_temp);
T{m}=temp_coeff;
end





