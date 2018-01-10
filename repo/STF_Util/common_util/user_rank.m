function [r]=user_rank(A)

[U,S,V]=svd(A);
[m,n]=size(S);
r=0;
if (m>=n)
    dim=n;
else
    dim=m;

end
    for i=1:dim
        if(S(i,i)>1e-8)
            r=r+1;
        end
    end
end
