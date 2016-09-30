% plot reward

clear;
clc;

load('Reward_Sar_CoNoP_2by2.mat') % change according to different files

figure('Name','Reward in final 10 steps')

R_a = []; R_b = [];

for i = 1: N
   r_a = Result{i,1}(:,2); 
   r_b = Result{i,2}(:,2); 
   R_a = [R_a,r_a]; 
   R_b = [R_b,r_b];
end

Ra_0 = []; Ra_1 = []; Ra_2 = [];
Rb_0 = []; Rb_1 = []; Rb_2 = [];

for i =1:N
Ra = R_a(:,i);
ra_0 = size(find(Ra(end-9:end)==0)); % reward of last 10 steps
ra_1 = size(find(Ra(end-9:end)==1)); 
ra_2 = size(find(Ra(end-9:end)==3)); 

Ra_0 = [Ra_0, ra_0(1)];
Ra_1 = [Ra_1, ra_1(1)];
Ra_2 = [Ra_2, ra_2(1)];

Rb = R_b(:,i);
rb_0 = size(find(Rb(end-9:end)==0)); 
rb_1 = size(find(Rb(end-9:end)==1)); 
rb_2 = size(find(Rb(end-9:end)==3)); 

Rb_0 = [Rb_0, rb_0(1)];
Rb_1 = [Rb_1, rb_1(1)];
Rb_2 = [Rb_2, rb_2(1)];
 
end

Ra0 = sum(Ra_0)/(10*N);
Ra1 = sum(Ra_1)/(10*N);
Ra2 = sum(Ra_2)/(10*N);
Rb0 = sum(Rb_0)/(10*N);
Rb1 = sum(Rb_1)/(10*N);
Rb2 = sum(Rb_2)/(10*N);

action_a = [Ra0, Ra1, Ra2];
action_b = [Rb0, Rb1, Rb2];

% standard deviation
stda_0 = std(Ra_0)/10;
stda_1 = std(Ra_1)/10;
stda_2 = std(Ra_2)/10;
std = [stda_0, stda_1, stda_2]

subplot(2,1,1)
x = 1:1:3;
bar(x, action_a, 'b');
ylim([0 1.5])
for i = 1:length(action_a)
    text(x(i)-0.1, action_a(i)+0.2, num2str(action_a(i)*100,'%3.1f'), 'Fontsize',20);
end
text(1, 1.25,'Reward of agent A (%)','Fontsize',20);
set(gca,'xticklabel', {'r=0','r=1','r=3'}, 'Fontsize', 20)
% hold on

subplot(2,1,2)
bar(action_b,'c')
ylim([0 1.5])
for i = 1:length(action_b)
    text(x(i)-0.1, action_b(i)+0.2, num2str(action_b(i)*100,'%3.1f'),'Fontsize',20);
end
text(1, 1.25,'Reward of agent B (%)','Fontsize',20);
set(gca,'xticklabel', {'r=0','r=1','r=3'}, 'Fontsize',20)

% suptitle('Com+NoP: Percentages of reward in final 10 steps')

