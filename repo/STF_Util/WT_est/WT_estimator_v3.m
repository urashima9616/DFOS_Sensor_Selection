% Saul Rodriguez�?Yuankun Xue
% Reference: (1) Wavelet Analysis of Fractional Brownian Motion
%            
% To functionalize the code to accept arguments for estimation of
% fractional differencing orders individually for each time series.
%

% Test script for Fractal Estimator

%% Generate our test signals
function [d1]=WT_estimator_v3(series,series_num)

Wt = HaarWaveletTransform;

N = length(series);           % Number of sample points
K = series_num;              % Number of time series
X = zeros(K,N);

for i = 1 : K
    X(i,:) = series(i,:);
    mean = Wt.Mean(X(i,:));
    X(i,:) = X(i,:) - mean;
end


NumScales = floor(log2(N));
log_wavelet_scales = zeros (1, NumScales);

%subplot(2,1,1);
%plot ( X(1,:));
%title('Input series','Fontsize',20);
%xlabel('Record ID','Fontsize',20);


%subplot(4,1,3);
%plot ( X(2,:));
%title('Input series','Fontsize',20);
%xlabel('Record ID','Fontsize',20);

%% Wavelet analysis
scale = zeros(1, NumScales);
for i = 1 : NumScales
    scale(i) = i;
end


% To keep uniform with 'R'.
% V = Scales Coefficients.
% W = Wavelet Coefficients.
[V, W] = Wt.Transform(X(1,:));
j = floor(N / 2);                  % Represents the num coefficients
for i = 1: (NumScales - 1)          % The last scale has one coeff.only.
    y = W(i,1:j);
    %variance = Wt.varianceEst(y);
    variance = var(y);
    log_wavelet_scales(i) = log2(variance); 
    j = floor(j/2);
end
%subplot(2,1,2);
%plot(scale(1:(NumScales - 1)),log_wavelet_scales(1:(NumScales - 1)),'o');

% Linear Fit to get the slope
% of the Log2-Log2 relation
% "Wavelet Analysis and Synthesis
% of Fractional Brownian Motion"
p = polyfit(scale(1:(NumScales - 1)), log_wavelet_scales(1:(NumScales - 1)), 1);

%d1 = ( p(1) + 1 ) / 2;
d1=p(1)./2;

% Use coefficients from ployfit to estimate
% a new set of "Y" values
Y = polyval(p, scale(1:(NumScales - 1)));
%hold on;
%plot(scale(1:(NumScales - 1)), Y);
% title('Estimated fractional orders@All channels','Fontsize',24);
% xlabel('Wavelet Scale number','Fontsize',24);
% ylabel('Log(Var(Wave-coeffs))')
end