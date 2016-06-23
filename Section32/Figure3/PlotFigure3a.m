close all;
clear all;
clc;

load('figure3a');

h = figure;
hold all;
grid on;
st = {'-o' '-s' '->','-*'}; % styles
for qi=1:length(qs)
    plot(rs,VIq(qi,:),st{qi});
end
%plot(rs,RandIndexToPlot,'b*-');

legQ = cell(1,length(qs));
for qi=1:length(qs)
   legQ{qi} = ['$q = $ ' num2str(qs(qi))];
end 
%legQ{length(qs)+1} = '$\frac{N-1}{N}(1 - \mbox{RI})$';

leg = legend(legQ);
set(leg,'Interpreter','latex');
set(leg,'Location','NorthEastOutside');

ylabel('NMI$_q$','Interpre8 0.9 1.2 1.5 2 2.5ter','latex','FontSize',12);
xlabel('Number of sets $r$ in $U$ ','Interpreter','latex','FontSize',12);

% big
set(h,'Position',[200 200 900 220]);
set(h,'PaperSize',[20.5 6],'PaperPositionMode','auto');
saveas(h,'figure2','pdf');
%small
%set(h,'Position',[200 200 400 220]);
%set(h,'PaperSize',[10.5 6],'PaperPositionMode','auto');
%saveas(h,'figure3a','pdf');