clear all
close all
dfiles={'AMOC','NAO','JET-JJA','JET-DJF','SPG-OHC'};
vname={'AMOC [Sv]','NAO (DJFM)','Jet latitude (JJA) [°N]','Jet speed (DJF) [m/s]','Sub-polar gyre OHC [ZJ]'};
figure
for dd=1:length(dfiles)
    D=load(sprintf('DATA/%s.txt',dfiles{dd}));
    subaxis(length(dfiles),1,dd,'SV',0.05);
    plot(D(:,1),D(:,2),'LineWidth',2);
    xlim([1949 2021]);
    ylabel(vname{dd},'FontSize',11);
    set(gca,'FontSize',13);
end
set(gcf,'PaperPosition',[0 0 25 8*length(dfiles)]);
print('-dpng','ACSIS-indicators.png');


