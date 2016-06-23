close all;
clear all;
clc;

load('figure4a');

h = figure;
hold all;
grid on;
st = {'-o' '-s' '->','-*'}; % styles
for qi=1:length(qs)
    plot(Allperc*100,VIq(qi,:),st{qi});
end
%plot(Allperc*100,RandIndexToPlot,'b*-');

legQ = cell(1,length(qs));
for qi=1:length(qs)
   legQ{qi} = ['$q = $ ' num2str(qs(qi))];
end 
%legQ{length(qs)+1} = '$\frac{N-1}{N}(1 - \mbox{RI})$';

%leg = legend(legQ);
%set(leg,'Interpreter','latex');

ylabel('NMI$_q$','Interpreter','latex','FontSize',12);
xlabel('Relative size of the biggest set in $U$ [\%]','Interpreter','latex','FontSize',12);

set(h,'Position',[200 200 360 220]);
set(h,'PaperSize',[9.5 6],'PaperPositionMode','auto');
saveas(h,'figure4a','pdf');