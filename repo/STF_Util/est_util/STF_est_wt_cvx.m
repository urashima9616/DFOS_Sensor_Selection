%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Linear regression estimation for STF model: (D(L)^a)X=AX+E
% 
%
% Input arguments:
%
%   X          : M by N matrix of time series
% Output arguments: 
%
%   ZZZ        : dependency matrix cell
%  order       : Fractal differencing order
%
% Estimation applicatin example
% [ZZZ order]=STF_est_wt(X);
%
%
% Yuankun Xue 2015
% University of Southern California
% All copyrights reserved
function [ZZZ,order]=STF_est_wt_cvx(X,p)
[Num_chn,N]=size(X);
order=zeros(1,Num_chn);

%------------------Estimation part---------------------------------------->

for i=1:Num_chn
order(1,i)=WT_estimator_v3(X(i,:),1);
end
ZZZ=cvx_estimator(X,p,order);
end
