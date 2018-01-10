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
% [ZZZ order]=STF_est(X);
%
%
% Yuankun Xue 2015
% University of Southern California
% All copyrights reserved
function [ZZZ,order]=STF_est(X)
i=1;
[M,N]=size(X);
order=zeros(1,M);
infi=20;
p=1;% TODO:Assume p=1 in this version, can do p>=1
p_filter=2; % How many steps to look into past for estimation of fractal order
start=-0.5;
over=0.5;
step=0.01;
steps=(over-start)./step+1;
orders=start:step:over;
err=zeros(M,steps);
c_err=zeros(M,steps);
%------------------Estimation part---------------------------------------->

%Blind estimation for dependency matrix A(L) considering the effect of fractional differencing terms
%[T]=lin_kernel_frac_cvx(X,p);

[T]=lin_kernel_frac(X,p);
TT=zeros(infi,M);
for m=1:M
	TT(:,m)=T{m}((m-1)*p+1:(m-1)*p+infi,1);
end
%Search for convergence
d_vector=zeros(1,M);
for dd=start:step:over;
	ceff=binominal_exp_ceff(dd,2);
	for kk=1:M
		d_vector(kk)=dd;
	end
	ZZ=lin_kernel(X,p_filter,d_vector);
	%ZZ=cvx_estimator(X,p_filter,d_vector);
	for m=1:M
		err(m,i)=abs((ZZ{1}(m,m)+dd)-TT(1,m));
		c_err(m,i)=abs(ceff+TT(2,m));
	end
	i=i+1;
end

% for m=1:M
% 	err(m,i)=abs((ZZ{1}(m,m)+dd)-TT(1,m));
% 	c_err(m,i)=abs(ceff+TT(2,m));
% end



overall_err=0.4*c_err+err;

for m=1:M
	index=find(overall_err(m,:)==min(overall_err(m,:)));
	order(m)=orders(index);
end

ZZZ=lin_kernel(X,p,order);
%ZZZ=cvx_estimator(X,p,order);
end
