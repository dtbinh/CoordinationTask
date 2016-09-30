% function VisCom(GW_X, GW_Y)
% Visualize communication

load('STAT_QC.mat')
[~, QC1] = max(reshape(STAT_QC1(:, end) ,4, []), [], 2);
[~, QC2] = max(reshape(STAT_QC2(:, end) ,4, []), [], 2);

QC1_Signal_1_IND = find (QC1==1); % agent 1, find signal 1
QC1_Signal_2_IND = find (QC1==2);

QC2_Signal_1_IND = find (QC2==1); % agent 2, find signal 1
QC2_Signal_2_IND = find (QC2==2);

X_DIM = 2;
Y_DIM = 2;
GW_SIZE = [X_DIM , Y_DIM];

[i_1,j_1] = ind2sub(GW_SIZE,QC1_Signal_1_IND);% index to subscripts
[i_2,j_2] = ind2sub(GW_SIZE,QC1_Signal_2_IND);

[m_1,n_1] = ind2sub(GW_SIZE,QC2_Signal_1_IND);
[m_2,n_2] = ind2sub(GW_SIZE,QC2_Signal_2_IND);

NUM_POS = X_DIM * Y_DIM;
[X, Y] = meshgrid(1:X_DIM, 1:Y_DIM);%:-1:1); 
% Index = [X(:) Y(:)];
GOAL_POS = [X(1),Y(1)]; %1;
VISUALIZE = 1; %% 0: no visualization, 1: visualization 

%% If VISUALIZE == 1, build images
if VISUALIZE == 1
  H_1 = figure(2); 
  rectangle('Position', [0 0 X_DIM Y_DIM], 'LineWidth', 3);
  for x = 1:X_DIM-1
    line([x,x], [0,Y_DIM], 'Color', [0 0 0])
  end
  for y = 1:Y_DIM-1
    line([0,X_DIM],[y,y], 'Color', [0 0 0])
  end
  axis equal
  axis([-1 X_DIM+1 -1 Y_DIM+1])
  axis off
  title('Signaling of agent A','position',[1,-0.15],'Fontsize',20)
  hold on
end

%% VISULAIZE Signaling for agent 1
if VISUALIZE == 1
  % vis reward
  reward_h  = rectangle('Position', [GOAL_POS(1)-0.75 GOAL_POS(2)-0.75 0.5 0.5],...
      'Curvature', [0.5 0.5],'EdgeColor', [0 1 0], 'LineWidth',4); % Green
  
  for k = 1:numel(i_1)
  agent1_signal_h_1 = rectangle('Position', [i_1(k)-0.75 j_1(k)-0.75 0.5 0.5],...
            'Curvature', [0 0],'FaceColor', [0 0 0]); % white
  end
  
  for l = 1:numel(i_2)
  agent1_signal_h_2 = rectangle('Position', [i_2(l)-0.75 j_2(l)-0.75 0.5 0.5],...
            'Curvature', [0 0],'FaceColor', [1 1 1]); % black
  end
  % save image 
  set(gca,'YDir','reverse');% flip rectangle
  saveas(H_1, 'VisualizeComAgentA' , 'fig');
end

%% VISULAIZE Signaling for agent 2
if VISUALIZE == 1
    H_2 = figure(3); 
      rectangle('Position', [0 0 X_DIM Y_DIM], 'LineWidth', 3);
  for x = 1:X_DIM-1
    line([x,x], [0,Y_DIM], 'Color', [0 0 0])
  end
  for y = 1:Y_DIM-1
    line([0,X_DIM],[y,y], 'Color', [0 0 0])
  end
  axis equal
  axis([-1 X_DIM+1 -1 Y_DIM+1])
  axis off
  title('Signaling of agent B','position',[1,-0.15],'Fontsize',20)
  hold on
  % vis reward
  reward_h  = rectangle('Position', [GOAL_POS(1)-0.75 GOAL_POS(2)-0.75 0.5 0.5],...
      'Curvature', [0.5 0.5],'EdgeColor', [0 1 0], 'LineWidth',4); % Green
  
  for k = 1:numel(m_1)
  agent2_signal_h_1 = rectangle('Position', [m_1(k)-0.75 n_1(k)-0.75 0.5 0.5],...
            'Curvature', [0 0],'FaceColor', [0 0 0]); % white
  end
  
  for l = 1:numel(m_2)
  agent2_signal_h_2 = rectangle('Position', [m_2(l)-0.75 n_2(l)-0.75 0.5 0.5],...
            'Curvature', [0 0],'FaceColor', [1 1 1]); % black
  end
  % save image 
  set(gca,'YDir','reverse');% flip rectangle
  saveas(H_2, 'VisualizeComAgentB' , 'fig');
end
% end
