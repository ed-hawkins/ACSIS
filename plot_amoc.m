%% PLOT SUMMARY FIGURE OF AMOC
AMOC(2019)=AMOC2(2019);
figure
subaxis(2,1,1);
plot((2004.25):(1/730):((2004.25)+(length(MOC_RAW)-1)/730),(MOC_RAW(:,end)),'k-','Color',[0.7 0.7 0.7]);
hold on
plot((2004.25):(1/730):((2004.25)+(length(MOC_RAW)-1)/730),movmean(MOC_RAW(:,end),60),'k-','LineWidth',2);
set(gcf,'PaperPosition',[0 0 35 30]);
xlim([2004 2020.5]);
ylim([-5 32]);
set(gca,'FontSize',15,'TickDir','out');
title('Atlantic Meridional Overturning Circulation (AMOC) [Sv]','FontSize',20);
ylabel('AMOC (twice-daily & monthly average)');
subaxis(2,1,2);
plot(2004.75:1:2018.751,AMOC(2004:2018),'r.-','MarkerSize',20,'LineWidth',1.5);
hold on
plot(2018.75:1:2019.75,AMOC(2018:2019),'r.--','MarkerSize',20,'LineWidth',1.5);
xlim([2004 2020.5]);
set(gca,'FontSize',15,'TickDir','out');
ylabel('AMOC (annual average - April to March)');
print('-dpng','../amoc_movmean.png');
%%%%
