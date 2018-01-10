%This function calculates the covariance of X_i and X_j

function R = Cov_ij(i, j, G, Cov_w, Cov_x)
part_1 = G(:,:,i)*Cov_x*G(:,:,j)';

part_2 = zeros(size(part_1));

if i == 1 || j == 1
   R = part_1;
   return
end



if i>j
   for kk=1:j-1
      part_2 = part_2 + G(:, :, i-kk)*Cov_w*G(:, :, j-kk)'; 
   end
 
else
   for kk=1:i-1
      part_2 = part_2 + G(:, :, i-kk)*Cov_w*G(:, :, j-kk)';
   end
end

R = part_1 + part_2;

end