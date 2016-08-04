close all;
clear all;
clc;

load('figure4b');

h = figure;
hold all;
grid on;
st = {'-o' '-s' '->','-*'}; % styles
for qi=1:length(qs)
    plot(Allperc*100,AVIq(qi,:),st{qi});
end
plot(Allperc*100,ARandIndexToPlot,'b:','linewidth',2);
plot(Allperc*100,AMIToPlot,'r--','linewidth',2);

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
xlabel('Relative size of the biggest set in $U$ [\%]','Interpreter','latex','FontSize',12);

set(h,'Position',[200 200 470 220]);
set(h,'PaperSize',[12.8 6],'PaperPositionMode','auto');
saveas(h,'figure4b','pdf');