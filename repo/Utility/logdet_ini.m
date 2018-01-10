function [R]=logdet_ini(C,G,len_start,Cov_z)
 O_k=O_k_gen(C,G,len_start);
  
 %add delta to ensure non-blow of inverse
 delta=0.1;
  
 % matr2inv=inv(O_k*Cov_z*O_k'+sigma^2*eye(size(O_k,1)));

 matr2inv=inv(O_k*Cov_z*O_k'+(delta)*eye(size(O_k,1)));

 matr=Cov_z-Cov_z*O_k'*matr2inv*O_k*Cov_z; %+delta*eye(size(Cov_z))
 R=log(det(matr));
 
 %This is to avoid the infinity as lower extreme for the bissection method
     if isinf(R)
         R=-1000;
     end

end