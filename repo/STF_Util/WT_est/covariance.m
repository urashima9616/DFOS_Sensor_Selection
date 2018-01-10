% Assumes time series are zero-mean
% x1 and x2 are two column vectors
% vectors assumed to be of same size.
% Saul Rodriguez, 7/24/2015.

function cov = covariance(x1, x2, Lag)
    L = Lag;
    N = length(x1);
    
    % The lag cannot exceed the size of the
    % vector.
    if (L > N)
        L = N;
    end
    Lagged_x2 = zeros(N,1);
    Lagged_x2(1:N-L) = x2(L+1:N);
    aux1 = x1.*Lagged_x2;
    aux2 = ones(N, 1);
    cov = 1/N*(aux2'*aux1);  
end
