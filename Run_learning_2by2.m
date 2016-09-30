% run learning_oneside

N = 100; % repeating times

Result = cell(N, 2); % reward of agent a and agent b in every round

parfor i = 1:N
%     [Result_a, Result_b, STAT_QC1, STAT_QC2] = NoCoNoP();
    %% 1. Isolated Condition: 
%     [Result_a, Result_b] = Q_NoCoNoP_2by2();
    
    %% 2. Observable Condition: 
%     [Result_a, Result_b] = Q_NoCoP_2by2();

    %% 3. Communicable Condition:
    [Result_a, Result_b] = Q_CoNoP_2by2();
%     [Result_a, Result_b] = Sar_CoNoP_2by2();

    Result(i, :) = {Result_a, Result_b};
end

%% save current workspace
%% 1. Isolated Condition:
% save ('Reward_Q_NoCoNoP_2by2.mat','Result','N')

%% 2. Observable Condition:
% save ('Reward_Q_NoCoP_2by2.mat','Result','N')

%% 3. Communicable Condition:
save ('Reward_Q_CoNoP_2by2.mat','Result','N')
% save ('Reward_Sar_CoNoP_2by2.mat','Result','N')