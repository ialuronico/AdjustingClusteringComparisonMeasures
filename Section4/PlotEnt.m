clear all;
close all;
clc;

qs= [0.1 0.5 1.5 2.5 4 ];
 
frac = (0:.001:1);

plotEnt = zeros(length(qs),length(frac));

 
 for i=1:length(qs)
   q = qs(i);
   for j=1:length(frac)
     plotEnt(i,j) = (1 - frac(j)^q - (1-frac(j))^q)/(q-1);     
   end
 end


h = figure;
plot(frac,plotEnt);
hold all;
grid on;

ylabel('$H_q(p)$','interpreter','latex');
xlabel('$p$','interpreter','latex');

legQ = cell(1,length(qs));
for qi=1:length(qs)
   legQ{qi} = ['$q = $ ' num2str(qs(qi))];
end 

leg = legend(legQ);
set(leg,'Interpreter','latex');

%set(h,'Position',[200 200 900 200]);
%set(h,'PaperSize',[20.5 5.3],'PaperPositionMode','auto');
%saveas(h,'entQ','pdf');

set(h,'Position',[200 200 300 200]);
set(h,'PaperSize',[8.5 5.3],'PaperPositionMode','auto');
saveas(h,'entQ','pdf');