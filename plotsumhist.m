% plot 3 conditions hist compare
clc;

figure(1);
action_2by2 = [0.345 0.305 0.35;0 0 1;0.015 0.007 0.978];
x=1:1:9;
% bar(x,action_a);
b = bar(action_2by2);

ylim([0 1.5])

for i = 1:3
    text(x(i)-0.4, action_2by2(i)+0.1, num2str(action_2by2(i)*100,'%3.1f'), 'Fontsize',20);   
end

for i = 4:6
    text(x(i)-3.12, action_2by2(i)+0.08, num2str(action_2by2(i)*100,'%3.1f'), 'Fontsize',20);   
end

% text(6-3.3, action_2by2(6)+0.1, num2str(action_2by2(6)*100,'%3.1f'), 'Fontsize',20)

for i = 7:9
    text(x(i)-5.9, action_2by2(i)+0.1, num2str(action_2by2(i)*100,'%3.1f'), 'Fontsize',20);   
end

textstr={'Percentage of Reward = ';'0, 1, and 3 (%) in ';'2 \times 2 gridworld'};
text(0.8, 1.3,textstr,'Fontsize',20);
set(gca,'xticklabel', {'Condition 1','Condition 2','Condition 3'}, 'Fontsize', 20)

legend('r = 0','r = 1','r = 3')


