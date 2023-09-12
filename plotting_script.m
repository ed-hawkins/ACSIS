clear all
close all
dfiles={'AMOC','NAO','JET-JJA','JET-DJF','SPG-OHC','ARCTIC-SEA-ICE','OZONE'};
vname={'AMOC [Sv]','NAO (DJFM)','Atlantic jet latitude (JJA) [°N]','Atlantic jet speed (DJF) [m/s]','Atlantic sub-polar gyre OHC [ZJ]','Atlantic Arctic autumn sea ice volume [km^3]','North Atlantic tropospheric ozone [DU]'};
LY=2023;

figure
for dd=1:length(dfiles)
    D=load(sprintf('DATA/%s.txt',dfiles{dd}));
    subaxis(length(dfiles),1,dd,'SV',0.05);
    plot(D(:,1),D(:,2),'LineWidth',2);
    xlim([1949 LY]);
    TT=title(vname{dd},'FontWeight','normal');
    set(gca,'FontSize',14,'TickDir','out');
    set(TT,'FontSize',20);
end
set(gcf,'PaperPosition',[0 0 25 8*length(dfiles)]);
print('-dpng','-r600','ACSIS-indicators.png');

close all
for dd=1:length(dfiles)
    figure
    D=load(sprintf('DATA/%s.txt',dfiles{dd}));
    plot(D(:,1),D(:,2),'LineWidth',2);
    xlim([1949 LY]);
    TT=title(vname{dd},'FontWeight','normal');
    set(gca,'FontSize',14,'TickDir','out');
    set(TT,'FontSize',20);
    set(gcf,'PaperPosition',[0 0 25 8]);
    print('-dpng','-r300',sprintf('ACSIS-indicators-%s.png',dfiles{dd}));
end

