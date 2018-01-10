function O_k=O_k_gen(C,G_matrix,len_start)

[n,n]=size(G_matrix(:,:,1));
%Generate L 
for  i=1:len_start
    for j=1:i
        if(j==1)
            L_temp=G_matrix(:,:,i-j+1);  
        else
            L_temp=[L_temp,G_matrix(:,:,i-j+1)];
        end
    end
    if(i<len_start)
     zero=zeros(n,(len_start-i)*n);
     L_temp=[L_temp,zero];
    end
    L_temp=C*L_temp;
    if(i==1)
        O_k=L_temp;
    else
        O_k=[O_k;L_temp];
    end
end

end