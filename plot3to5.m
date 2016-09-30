% plot 3by3 to 5 by5
%{
figure(2);

action_3by3 = [0.065 0.057 0.878; 0.034 0.039 0.927 ];
x=1:1:6;
% bar(x,action_a);
bar(action_3by3);

ylim([0 1.5])

for i = 1:2
    text(x(i)-0.3, action_3by3(i)+0.1, num2str(action_3by3(i)*100,'%2.1f'), 'Fontsize',20);   
end

for i = 3:4
    text(x(i)-2.05, action_3by3(i)+0.1, num2str(action_3by3(i)*100,'%2.1f'), 'Fontsize',20);   
end

for i = 5:6
    text(x(i)-3.85, action_3by3(i)+0.1, num2str(action_3by3(i)*100,'%2.1f'), 'Fontsize',20);   
end

textstr={'Percentage of Reward = ';'0, 1, and 3 (%) in'; '3 \times 3 gridworld'};
text(0.8, 1.3,textstr,'fontsize',20);
set(gca,'xticklabel', {'Observable Condition', '   Communicable Condition'}, 'Fontsize', 20)
legend('r = 0','r = 1','r = 3')
%}
%{
figure(3);
action_4by4 = [0.297 0.307 0.396; 0.055 0.036 0.909 ];
x=1:1:6;
% bar(x,action_a);
bar(action_4by4);

ylim([0 1.5])

for i = 1:2
    text(x(i)-0.3, action_4by4(i)+0.1, num2str(action_4by4(i)*100,'%2.1f'), 'Fontsize',20);   
end

for i = 3:4
    text(x(i)-2.05, action_4by4(i)+0.1, num2str(action_4by4(i)*100,'%2.1f'), 'Fontsize',20);   
end

for i = 5:6
    text(x(i)-3.85, action_4by4(i)+0.1, num2str(action_4by4(i)*100,'%2.1f'), 'Fontsize',20);   
end


textstr={'Percentage of Reward = ';'0, 1, and 3 (%) in';'4 \times 4 gridworld'};
text(0.8, 1.3,textstr,'fontsize',20);
set(gca,'xticklabel', {'Observable Conditio','   Communicalbe Condition'}, 'Fontsize', 20)
legend('r = 0','r = 1','r = 3')
%}
%
figure(4);
action_5by5 = [0.350 0.372 0.278; 0.059  0.041  0.90 ];
x=1:1:6;
% bar(x,action_a);
b = bar(action_5by5);

ylim([0 1.5])

for i = 1:2
    text(x(i)-0.3, action_5by5(i)+0.1, num2str(action_5by5(i)*100,'%2.1f'), 'Fontsize',20);   
end

for i = 3:4
    text(x(i)-2.05, action_5by5(i)+0.1, num2str(action_5by5(i)*100,'%2.1f'), 'Fontsize',20);   
end

for i = 5:6
    text(x(i)-3.85, action_5by5(i)+0.1, num2str(action_5by5(i)*100,'%2.1f'), 'Fontsize',20);   
end


textstr={'Percentage of Reward = ';'0, 1, and 3 (%) in';'5 \times 5 gridworld'};
text(0.8, 1.3,textstr,'fontsize',20);
set(gca,'xticklabel', {'Obervable Condition','   Communicable Condition'}, 'Fontsize', 20)
legend('r = 0','r = 1','r = 3')
%}