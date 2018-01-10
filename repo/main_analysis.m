%
%Greedy algorithm developed for CDC extension for TMBMC
%
clear all;
addpath('Task_measurement');
%%--------------Data loading----------------------------------------------
header = sprintf('T4');
ordername = sprintf('%s_ORDER.mat', header);
cplname = sprintf('%s_CPL.mat', header);
senreq_name = sprintf('%s_senreq.mat', header);
sendeploy_name = sprintf('%s_sendeploy.mat', header);
load(ordername);
load(cplname);
len=1024;
[A_matrix]=A_matrix_gen(order,len,A);
len_start=10;
G=G_matrix_gen(len_start,A_matrix);
Num_chn=64;
[m,n]=size(A);

 %--------Part II Greedy algorithm to find optimal sensor placement--------

 %--------Calculate the covariance for z_k-1-------
Cov_w=eye(Num_chn);%Provide the initial covariance of the disturbance 'w'
Cov_x=A*Cov_w*A';%Provide the initial error covariance 'x_0'
sigma=0.001; %Provide the initial measurement covariance

Cov_z=zeros(n*len_start,n*len_start);
for i=1:len_start
    %this cycle puts matrices associated with the initial error covariance
    %and the disturbance in a block diagonal matrix that describes the
    %overall covariance, that is the first block describes the initial
    %error covariance, the second the disturbance at the first time step,
    %the third the disturbance at the second time step, and so forth...
    if(i==1)
        Cov_z((i-1)*Num_chn+1:(i-1)*Num_chn+Num_chn, (i-1)*Num_chn+1:(i-1)*Num_chn+Num_chn)=Cov_x;
    else
        Cov_z((i-1)*Num_chn+1:(i-1)*Num_chn+Num_chn, (i-1)*Num_chn+1:(i-1)*Num_chn+Num_chn)=Cov_w;
    end
    
end

Id=eye(Num_chn);
iter=1;
%----------------Solve Prob 1----------------------------------------------
R_start=-100;
R_end=0;
step_r=10;
R_step=-1040:step_r:-150;
steps_r=length(R_step);
R_var_all=zeros(steps_r,Num_chn);
Sensor_set_all=zeros(steps_r,Num_chn);
Sensor_num_all=zeros(steps_r,Num_chn);
Set=zeros(1,Num_chn);
R_var=zeros(1,Num_chn);

for j=1:steps_r
    tic
    j
    R_err=1e3;
    flag=0;
    Set=zeros(1,Num_chn);
R_var=zeros(1,Num_chn);
Sensor_num=zeros(1,Num_chn);
 while(R_err>R_step(j))
        r_delta=0;
        max_index=Num_chn+1;
        for i=1:Num_chn      %Search for the sensor with highest gain
            if(find(Set==i)) %Skip this sensor if already chosen
                continue;
            end
            
            if(flag==0)
                C_temp=Id(i,:);
            else
                C_temp=C;
                C_temp=[C_temp;Id(i,:)];
            end
            R_new=logdet_ini(C_temp,G,len_start,Cov_z); %Calc log det
            if(R_new==inf)
                r_temp=0;
            else     
            r_temp=R_err-R_new;
            end
            cur_index=i;
            if(r_temp>r_delta)
                r_delta=r_temp;
                max_index=i;
            end
        end
        %Set records the index of sensor added at each step
        if(max_index==Num_chn+1) % Infeasible round, just add one sensor to see how it works
            if(flag==0)
                C=Id(1,:);
                Set(rank(C))=1;
            else
                C=[C;Id(cur_index,:)];
                Set(rank(C))=cur_index;
            end
            
            
            
        else
            if(flag==0)
                C=Id(max_index,:);
                Set(rank(C))=max_index;
            else
                C=[C;Id(max_index,:)];
                Set(rank(C))=max_index;
            end
        end
        
        C_temp=C;
        step_index = rank(C);
        flag=1; % marks the first round, 0 for yes 1 for no
        R_err=logdet_ini(C,G,len_start,Cov_z); %Best error value so far
        if(R_err==inf)
            R_err=1e3;
        end
        
        R_var(step_index) = R_err; %log det error of each step
        Sensor_num(step_index) = step_index;
        if(step_index == Num_chn)
            break;
        end
 end
    
 R_var_all(j,:)=R_var; %logdet error changes as number of sensor given threshold R_step(j)
 Sensor_set_all(j,:)=Set; %sensor deployment R_step(j)
 Sensor_num_all(j,1:length(Sensor_num))=Sensor_num; %# of sensors required given R_step(j)
 toc
end

sen_req=zeros(steps_r,2); % (# of sensors required, error)
for k=1:steps_r
   sen_req(k,1)=max(Sensor_num_all(k,:));
   sen_req(k,2)=R_step(1,k);
end
save(senreq_name, 'sen_req');
save(sendeploy_name, 'Sensor_set_all');
%---------------------------------------------------------------------


% %----------------Solve Prob 2 ----------------------------------------------
% %----Solve Prob 2
% Sen_start=1;
% Sen_end=64;
% sen_step=Sen_start:Sen_end;
% steps_r=length(sen_step);
% 
% 
% R_var_all=zeros(steps_r,1);
% Sensor_set_all=zeros(steps_r,Num_chn);
% Sensor_num_all=zeros(1,steps_r);
% Set=zeros(1,Num_chn);
% R_var=zeros(1,Num_chn);
% 
% for j=1:steps_r
%     j
%     R_err=1e3;
%     flag=0;
%     Set=zeros(1,Num_chn);
% R_var=zeros(1,Num_chn);
% 
%  while(Sensor_num_all(1,j)<sen_step(j))
%         r_delta=0;
%         max_index=Num_chn+1;
%         for i=1:Num_chn
%             
%             if(find(Set==i))
%                 continue;
%             end
%             if(flag==0)
%                 C_temp=Id(i,:);
%             else
%                 C_temp=C;
%                 C_temp=[C_temp;Id(i,:)];
%             end
%             R_new=logdet(C_temp,G,len_start,inv_Cov_z);
%             if(R_new==inf)
%                 r_temp=0;
%             else     
%             r_temp=R_err-R_new;
%             end
%             cur_index=i;
%             if(r_temp>r_delta)
%                 r_delta=r_temp;
%                 max_index=i;
%             end
%         end
%         if(max_index==Num_chn+1) % Infeasible round, just add one sensor to see how it works
%             if(flag==0)
%                 C=Id(1,:);
%                 Set(rank(C))=1;
%             else
%                 C=[C;Id(cur_index,:)];
%                 Set(rank(C))=cur_index;
%             end
%             
%             
%             
%         else
%             if(flag==0)
%                 C=Id(max_index,:);
%                 Set(rank(C))=max_index;
%             else
%                 C=[C;Id(max_index,:)];
%                 Set(rank(C))=max_index;
%             end
%         end
%         C_temp=C;
%         flag=1;
%         R_err=logdet(C,G,len_start,inv_Cov_z);
%         if(R_err==inf)
%             R_err=1e3;
%         else
%             R_err=R_err;
%         end
%         R_var(rank(C))=R_err;
%         Sensor_num_all(1,j)=rank(C);
%     
%  end
%     
%  R_var_all(j,1)=R_var(rank(C));
%  Sensor_set_all(j,:)=Set;
%  %Sensor_num_all(j,1:length(Sensor_num))=Sensor_num;
%  
% end


%---------------------------------------------------------------------


% % 
% %  plot(R_var,Sensor_num);
% %  
% % title('Minimal number of sensors given required error','Fontsize',24);
% % ylabel('Number of sensors','Fontsize',24);
% % xlabel('Required error level')
% 
% %-------------------Forecast using the stf model---------------------------
%  %%%K-step Forecast using connetivity matrix
% [X_sim_cnnct]=VARFIMA_predct_step_v3(A,order,SAMPLE,5);
% %%Retrieve the innovations
% W=SAMPLE-X_sim_cnnct;
% 
% %--------------------------------------------------------------------------
% % % %Calculate the normalized root mean square error
% fit=zeros(m,1);
% %  fit_eye=zeros(m,1);
%    for i=1:m
%         fit(i,1)=1- (norm(X_sim_cnnct(i,:)-SAMPLE(i,:))./norm(SAMPLE(i,:)-mean(SAMPLE(i,:))));
% % %       fit_eye(i,1)=1- (norm(X_sim_eye(i,:)-SAMPLE(i,:))./norm(SAMPLE(i,:)-mean(SAMPLE(i,:))));
%    end
%--------------------------------------------------------------------------

 
 
 
 