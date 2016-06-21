close all;
clear all;
clc;

load('figure3a');

h = figure;
hold all;
grid on;
for qi=1:length(qs)
    plot(rs,VIq(qi,:),'o-');
end
%plot(rs,RandIndexToPlot,'b*-');

legQ = cell(1,length(qs));
for qi=1:length(qs)
   legQ{qi} = ['$q = $ ' num2str(qs(qi))];
end 
%legQ{length(qs)+1} = '$\frac{N-1}{N}(1 - \mbox{RI})$';

leg = legend(legQ);
set(leg,'Interpreter','latex');

ylabel('NMI$_q$','Interpreter','latex','FontSize',12);
xlabel('Number of sets $r$ in $U$ ','Interpreter','latex','FontSize',12);

% big
set(h,'Position',[200 200 900 300]);
set(h,'PaperSize',[20.5 8],'PaperPositionMode','auto');
saveas(h,'figure2','pdf');
%small
%set(h,'Position',[200 200 400 220]);
%set(h,'PaperSize',[10.5 6],'PaperPositionMode','auto');
%saveas(h,'figure3a','pdf');