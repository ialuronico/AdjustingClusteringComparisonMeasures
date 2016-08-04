close all;
clear all;
clc;

load('figure3b');

h = figure;
hold all;
grid on;
st = {'-o' '-s' '->','-*'}; % styles
for qi=1:length(qs)
    plot(rs,AVIq(qi,:),st{qi});
end

plot(rs,ARandIndexToPlot,'b:','linewidth',2);
plot(rs,AMIToPlot,'r--','linewidth',2);

legQ = cell(1,length(qs));
for qi=1:length(qs)
   legQ{qi} = ['$q = $ ' num2str(qs(qi))];
end 
legQ{length(qs)+1} = 'ARI';
legQ{length(qs)+2} = 'AMI';

leg = legend(legQ);
set(leg,'Interpreter','latex');
set(leg,'Location','NorthEastOutside');

ylabel('AMI$_q$','Interpreter','latex','FontSize',12);
xlabel('Number of sets $r$ in $U$ ','Interpreter','latex','FontSize',12);

% big
set(h,'Position',[200 200 900 220]);
set(h,'PaperSize',[20.7 6],'PaperPositionMode','auto');
saveas(h,'figure3b','pdf');