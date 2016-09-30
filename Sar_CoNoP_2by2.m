function [Result_a, Result_b, STAT_QC1, STAT_QC2] = Sar_CoNoP_2by2()

% Condition 3: Communicable condition; don't know others position
% Multi-agent SARSA learning for communication
% 2 by 2 girdworld game, enter the same room
% softmax action selection

addpath('/Users/Huang/Documents/MATLAB/EnterSameRoom/code2/functions');

X_DIM = 2;
Y_DIM = 2;
   
GOAL_POS = 1;
  
NUM_POS = X_DIM*Y_DIM;
NUM_S   = 2; % Number of signaling
NUM_A   = 5; % 5 actions
NUM_C   = NUM_S;

[X, Y] = meshgrid(1:X_DIM, 1:Y_DIM);
GW_X = reshape(X.',1,NUM_POS);
GW_Y = reshape(Y.',1,NUM_POS);
GW_idx = zeros(X_DIM,Y_DIM);
GW_idx(:) = 1:NUM_POS;

%% Set alpha, gamma, tau
alpha_p = 0.2;
gamma_p = 0.9;
alpha_c = 0.2;
gamma_c = 0.9;

EPI = 1e4;   %2500;
tau_0 = 1;   % hyberbolic discounting for softmax action selection
tau_k = 0.005;
tau_p = tau_0; 
tau_c = tau_0; 

%% Initialize Q^p and Q^c functions
Qp1 = 0.001*rand(NUM_POS, NUM_S, NUM_A);
Qp2 = 0.001*rand(NUM_POS, NUM_S, NUM_A);
Qc1 = 0.001*rand(NUM_POS, NUM_C);
Qc2 = 0.001*rand(NUM_POS, NUM_C);

stat_r = zeros(2,EPI);
stat_t = zeros(1,EPI);

Result_a = [];  % recording reward of agent a
Result_b = [];  % recording reward of agent b

STAT_QP1 = zeros(NUM_POS*NUM_S*NUM_A,EPI);
STAT_QP2 = zeros(NUM_POS*NUM_S*NUM_A,EPI);

STAT_QC1 = zeros(NUM_POS*NUM_C,EPI);
STAT_QC2 = zeros(NUM_POS*NUM_C,EPI);

%% Repeat (for each episode)
for epi = 1:EPI
    
    epi_end = false; % logical 0
   
    %%  Initialize s^p, s^c(<--a^l)
    pot_pos = setdiff(1:NUM_POS,GOAL_POS);
    pot_pos = pot_pos(randperm(numel(pot_pos)));
    sp1 = pot_pos(1);
    sp2 = pot_pos(2);
    % communicate current position
    ac1 = softmax(Qc1(sp1, :), tau_c);
    ac2 = softmax(Qc2(sp2, :), tau_c);
    sc1 = ac2;
    sc2 = ac1;
  
    %% choose a^p from (s^p, s^c) using policy derived from Q^p
    q1 = squeeze(Qp1(sp1, sc1, :));
    q2 = squeeze(Qp2(sp2, sc2, :));
    ap1 = softmax(q1, tau_p);
    ap2 = softmax(q2, tau_p);
    
    %% Repeat (for each step of episode)
    trials = 0;
    while ~epi_end
        
        trials = trials + 1;
        
        %% obeserve new state s'^p, and reward
        % move get r -- GW_move(gw_size, x, y, a)
        [new_x1, new_y1] = GW_move([X_DIM,Y_DIM], GW_X(sp1), GW_Y(sp1), ap1);
        [new_x2, new_y2] = GW_move([X_DIM,Y_DIM], GW_X(sp2), GW_Y(sp2), ap2);
        
        new_sp1 = GW_idx(new_x1, new_y1);
        new_sp2 = GW_idx(new_x2, new_y2);

        % reward rules
        [r1, r2, epi_end] = calc_rewards(new_sp1, new_sp2, GOAL_POS);
        
        %% communicate for s'^p, 
        new_ac1 = softmax(Qc1(new_sp1, :), tau_c);
        new_ac2 = softmax(Qc2(new_sp2, :), tau_c);
        new_sc1 = new_ac2;
        new_sc2 = new_ac1;
        % choose a'^p (new_a) based on (s'^p, s'^c)
        new_q1 = squeeze(Qp1(new_sp1, new_sc1, :));
        new_q2 = squeeze(Qp2(new_sp2, new_sc2, :));
        new_ap1 = softmax(new_q1, tau_p);
        new_ap2 = softmax(new_q2, tau_p);
    
        %% update Q^p and Q^c functions
        delta_p1 = r1 - Qp1(sp1,sc1,ap1);
        delta_p2 = r2 - Qp2(sp2,sc2,ap2);
        delta_c1 = r1 - Qc1(sp1, ac1);
        delta_c2 = r2 - Qc2(sp2, ac2);

        if ~epi_end
            new_q1 = Qp1(new_sp1, new_sc1, new_ap1);
            new_q2 = Qp2(new_sp2, new_sc2, new_ap2);
            delta_p1 = delta_p1 + gamma_p * new_q1;
            delta_p2 = delta_p2 + gamma_p * new_q2;
    
            delta_c1 = delta_c1 + gamma_c * Qc1(new_sp1, new_ac1);
            delta_c2 = delta_c2 + gamma_c * Qc2(new_sp2, new_ac2);
        end
%     if sp1 == 1 || sp2 == 1
%       fprintf('sp1: %d, sp2: %d\n', sp1, sp2)
%     end
        Qp1(sp1, sc1, ap1) = Qp1(sp1, sc1, ap1) + alpha_p*delta_p1;
        Qp2(sp2, sc2, ap2) = Qp2(sp2, sc2, ap2) + alpha_p*delta_p2;
    
        Qc1(sp1, ac1) = Qc1(sp1, ac1) + alpha_c*delta_c1;
        Qc2(sp2, ac2) = Qc2(sp2, ac2) + alpha_c*delta_c2;
        %%
        sp1 = new_sp1;
        sp2 = new_sp2;
        sc1 = new_sc1;
        sc2 = new_sc2;
        ac1 = new_ac1;
        ac2 = new_ac2;
        ap1 = new_ap1;
        ap2 = new_ap2;
    end

    stat_r(1,epi) = r1;
    stat_r(2,epi) = r2;
    stat_t(epi) = trials; 
    tau_p = tau_0/(1 + tau_k * epi); 
    tau_c = tau_0/(1 + tau_k * epi); 
    result_qs_a = [epi, r1];
    result_qs_b = [epi, r2];
    Result_a = [ Result_a; result_qs_a]; 
    Result_b = [ Result_b; result_qs_b]; 
  
    STAT_QC1(:,epi) = Qc1(:);
    STAT_QC2(:,epi) = Qc2(:);
  
    STAT_QP1(:,epi) = Qp1(:);
    STAT_QP2(:,epi) = Qp2(:);
end

% save('Sar_AverageReward_conop.mat','stat_r')
%% plot reward (mean)
% plot_rewards(stat_r, EPI)
% save('STAT_QC.mat','STAT_QC1','STAT_QC2')
end
