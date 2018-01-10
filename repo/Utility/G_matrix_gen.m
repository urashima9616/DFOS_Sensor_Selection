%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generation of matrix G(k)
% 
% G(k)=    In   k=0
%
%     =   Sum(Aj*G(k-1-j)   k>=1
% Input arguments:
%
%   A       : KxK square matrix that encodes the correlation between different
%                time series
%   k          : k-th ternm k>0
%   d          : fractional differencing order vector

% Output arguments: 
%
%   X          : K*N matrix
%
% (c) Yuankun Xue 2015
% University of Southern California
% All copyrights reserved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [G]=G_matrix_gen_v2(K,A_matrix)
%Get the size of A
[m,n]=size(A_matrix(:,:,1));
G=zeros(m,m,K);
G(:,:,1)=eye(n);
for i=2:K   
    for j=1:i-1
        G(:,:,i)=G(:,:,i)+A_matrix(:,:,i-1-j+1)*G(:,:,j);
    end
end

end