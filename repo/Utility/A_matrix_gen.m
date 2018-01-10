function [AA]=A_matrix_gen(d,K,A)
[m,n]=size(A);
AA=zeros(n,n,K);

for j=1:K
    if(j==1)
        for i=1:n
            AA(i,i)=-1*binominal_exp_ceff(d(i),j);
        end
        % AA=A;
        
        AA(:,:,j)=AA(:,:,j)+A;
    else
        for i=1:n
            AA(i,i,j)=-1*binominal_exp_ceff(d(i),j);
        end
    end
end
end
