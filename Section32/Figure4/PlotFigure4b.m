close all;
clear all;
clc;

load('figure4b');

h = figure;
hold all;
grid on;
for qi=1:length(qs)
    plot(Allperc*100,AVIq(qi,:),'o-');
end
plot(Allperc*100,ARandIndexToPlot,'b*-');
plot(Allperc*100,AMIToPlot,'r*-');

legQ = cell(1,length(qs));
for qi=1:length(qs)
   legQ{qi} = ['$q = $ ' num2str(qs(qi))];
end 
legQ{length(qs)+1} = 'ARI';
legQ{length(qs)+2} = 'AMI';

leg = legend(legQ);
set(leg,'Interpreter','latex');

ylabel('AMI$_q$','Interpreter','latex','FontSize',12);
xlabel('Relative size of the biggest set in $U$ [\%]','Interpreter','latex','FontSize',12);

set(h,'Position',[200 200 400 220]);
set(h,'PaperSize',[10.8 6],'PaperPositionMode','auto');
saveas(h,'figure4b','pdf');