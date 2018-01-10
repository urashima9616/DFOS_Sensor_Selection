function [R_2]=u_gof(SAMPLE,Predict,p)
%%Method 1 R^2
[dim,len]=size(SAMPLE);
residual=SAMPLE-Predict;
for i=1:dim
    var_res(i,1)=norm(residual(i,:))^2;
    mean_sample(i,1)=mean(SAMPLE(i,:));
    temp=norm(SAMPLE(i,:)-mean_sample(i,1))^2;
    R_2(i,1)=1-(var_res(i,1)./temp);
end

%%Method 2 NRMSE
end