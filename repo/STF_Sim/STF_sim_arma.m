
function [X_k]=STF_sim_arma(Z,p,len,SAMPLE)

dim=length(Z{1}(:,1));
X_k=zeros(dim,len);
X_k(:,1)=SAMPLE(:,1);
C=zeros(dim,dim,p);
err=normrnd(0,1,dim,len);

for i=1:p
   C(:,:,i)=squeeze(Z{i}(:,:));
end

for t=2:len
% for each of component
    temp=zeros(dim,1);
    for j=1:p
        if(t>j)
            temp=temp+C(:,:,j)*X_k(:,t-j);
        end
    end
    X_k(:,t)=temp+err(:,i);
    
end

end



