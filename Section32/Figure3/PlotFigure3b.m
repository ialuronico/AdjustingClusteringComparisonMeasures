close all;
clear all;
clc;

load('figure3b');

h = figure;
hold all;
grid on;
for qi=1:length(qs)
    plot(rs,AVIq(qi,:),'o-');
end

plot(rs,ARandIndexToPlot,'b*-');
plot(rs,AMIToPlot,'r*-');

legQ = cell(1,length(qs));
for qi=1:length(qs)
   legQ{qi} = ['$q = $ ' num2str(qs(qi))];
end 
legQ{length(qs)+1} = 'ARI';
legQ{length(qs)+2} = 'AMI';

leg = legend(legQ);
set(leg,'Interpreter','latex');

ylabel('AMI$_q$','Interpreter','latex','FontSize',12);
xlabel('Number of sets $r$ in $U$ ','Interpreter','latex','FontSize',12);

% small
set(h,'Position',[200 200 400 220]);
set(h,'PaperSize',[10.7 6],'PaperPositionMode','auto');
saveas(h,'figure3b','pdf');