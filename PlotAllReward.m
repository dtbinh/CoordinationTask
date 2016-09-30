load('AverageReward_co.mat')
load('AverageReward.mat')
load('AverageReward_noco.mat')

EPI = 10000;
subplot(3,1,1)
plot_rewards(stat_r_noconop, EPI)
h = legend('Agent A', 'Agent B');
set(h, 'FontSize', 18, 'Location', 'NorthEast')
xlabel('Episodes/10, Condition 1', 'Fontsize', 18)

subplot(3,1,2)
plot_rewards(stat_r_nocop, EPI)
xlabel('Episodes/10, Condition 2', 'Fontsize', 18)
ylabel('Average rewards per 10 episodes', 'Fontsize', 18)

subplot(3,1,3)
plot_rewards(stat_r, EPI)
xlabel('Episodes/10, Condition 3', 'Fontsize', 18)


