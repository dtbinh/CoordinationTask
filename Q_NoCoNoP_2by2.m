function [Result_a, Result_b] = Q_NoCoNoP_2by2()

% Condition 1: isolated conditions; independent agents
% Q-learning agents
% 2 by 2 girdworld game, enter the same room
% softmax action selection

addpath('/Users/Huang/Documents/MATLAB/EnterSameRoom/code2/functions');

X_DIM = 2;
Y_DIM = 2;
   
GOAL_POS = 1;
  
NUM_POS = X_DIM*Y_DIM;
NUM_A   = 5; % 5 actions

[X, Y] = meshgrid(1:X_DIM, 1:Y_DIM);
GW_X = reshape(X.',1,NUM_POS);
GW_Y = reshape(Y.',1,NUM_POS);
GW_idx = zeros(X_DIM,Y_DIM);
GW_idx(:) = 1:NUM_POS;
%% Set alpha, gamma, tau
alpha_p = 0.2;
gamma_p = 0.9;

EPI = 10000; % numbers of episodes
tau_0   = 1;   % hyberbolic discounting for softmax action selection
tau_k   = 0.005;
tau     = tau_0; 
%% Initialize Q^p functions
% init Q; Q(s,a)
Qp1 = 0.001*rand(NUM_POS,NUM_A); 
Qp2 = 0.001*rand(NUM_POS,NUM_A); % Q1(4,:) = 0.1; % bias on up action

stat_r = zeros(2,EPI);
stat_t = zeros(1,EPI);

Result_a = [];
Result_b = [];
%% Repeat (for each episode)
for epi = 1:EPI
    epi_end = false; % logical 0
  
    %% Initialize s^p, randomly starting position
    pot_pos = setdiff(1:NUM_POS,GOAL_POS);
    pot_pos = pot_pos(randperm(numel(pot_pos)));
    sp1 = pot_pos(1);
    sp2 = pot_pos(2);

    %% Repeat (for each step of episode)  
    trials = 0;
    while ~epi_end
        
        trials = trials + 1;

        q1 = squeeze(Qp1(sp1,:));
        q2 = squeeze(Qp2(sp2,:));
        ap1 = softmax(q1,tau);
        ap2 = softmax(q2,tau);

        %% obeserve new state s'^p, and reward
        % move get r -- GW_move(gw_size, x, y, a)
        [new_x1, new_y1] = GW_move([X_DIM,Y_DIM], GW_X(sp1), GW_Y(sp1), ap1);
        [new_x2, new_y2] = GW_move([X_DIM,Y_DIM], GW_X(sp2), GW_Y(sp2), ap2);

        new_sp1 = GW_idx(new_x1, new_y1);
        new_sp2 = GW_idx(new_x2, new_y2);
        
        % reward rules
        [r1, r2, epi_end] = calc_rewards(new_sp1, new_sp2, GOAL_POS);     

        %% Update Q^p
        delta_p1 = r1 - q1(ap1);
        delta_p2 = r2 - q2(ap2);

        if ~epi_end
            new_q1 = squeeze(Qp1(new_sp1,:));
            new_q2 = squeeze(Qp2(new_sp2,:));

            delta_p1 = delta_p1 + gamma_p * max(new_q1);
            delta_p2 = delta_p2 + gamma_p * max(new_q2);
        end
         
        Qp1(sp1,ap1) = Qp1(sp1,ap1) + alpha_p * delta_p1;
        Qp2(sp2,ap2) = Qp2(sp2,ap2) + alpha_p * delta_p2;
        %%
        sp1 = new_sp1;
        sp2 = new_sp2;
    end

    stat_r(1,epi) = r1;
    stat_r(2,epi) = r2;
    stat_t(epi) = trials; 
    tau = tau_0/(1 + tau_k * epi); 
    result_qs_a = [epi, r1];
    result_qs_b = [epi, r2];
    Result_a = [ Result_a; result_qs_a]; 
    Result_b = [ Result_b; result_qs_b]; 
end
% save('Q_AverageReward_noconop_2by2.mat','stat_r')
%% plot reward (mean)
%  plot_rewards(stat_r, EPI)
% save('STAT_QC.mat','STAT_QC1','STAT_QC2')
end
