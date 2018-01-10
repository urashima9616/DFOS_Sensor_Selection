function [Ot]=Observ_gen_v3(K,G,C)
%Ot=zeros(n*K,n);
for i=1:K
    if(i==1)
      Ot=C*G(:,:,i);   
    else
      Ot=[Ot;C*G(:,:,i)];
    end
end