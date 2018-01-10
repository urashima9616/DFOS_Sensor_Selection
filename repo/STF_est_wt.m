%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wavelet estimator for STF model: (D(L)^a)X=AX+E
% 
%
% Input arguments:
%
%   X          : M by N matrix of time series
% Output arguments: 
%
%   A        :   dependency matrix cell
%  order       : Fractional  order
%
% Estimation applicatin example
% [A order]=STF_est_wt(X);
%
%
% Yuankun Xue 2015
% University of Southern California
% All copyrights reserved
function [A,order]=STF_est_wt(X,p)
[Num_chn,N]=size(X);
order=zeros(1,Num_chn);

%------------------Estimation part---------------------------------------->

for i=1:Num_chn
order(1,i)=WT_estimator_v3(X(i,:),1);
end
ZZZ=lin_kernel(X,p,order);
end
