clear all
close all
LY=2020;

%%%% AMOC %%%%
AMOC(1:LY)=NaN;
MOC_RAW=load('AMOC/moc_transports.ascii.txt');
% order: JD YY MM DD HR t_therm10 t_aiw10 t_ud10 t_ld10 t_bw10 t_gs10 t_ek10 t_umo10 moc_mar_hc10
first_year=min(MOC_RAW(:,2));
last_year=max(MOC_RAW(:,2));
%% REMOVE MISSING VALUES OF MOC
N=find(MOC_RAW(:,end)==-99999);
MOC_RAW(N,end)=NaN;
fid=fopen('DATA/AMOC.txt','w+');
for yy=first_year:last_year
    % find values from April one year to March the following year
    F=find((MOC_RAW(:,2)==yy & MOC_RAW(:,3)>=4)|(MOC_RAW(:,2)==(yy+1) & MOC_RAW(:,3)<=3));
    if length(F)>=728 % twice per day, each day, allowing for one missing day
     AMOC(yy)=nanmean(MOC_RAW(F,end));
     fprintf(fid,'%d %.3f\n',yy,AMOC(yy));
    end
end
fclose(fid);

clearvars -except LY
%%%% NAO %%%%
NAO(1:LY)=NaN;
NAO_RAW=load('NAO/nao_3dp.dat.txt');
%% REMOVE MISSING VALUES OF NAO
NAO_RAW(NAO_RAW<-99)=NaN;
first_year=min(NAO_RAW(:,1));
last_year=max(NAO_RAW(:,1));
fid=fopen('DATA/NAO.txt','w+');
for yy=(first_year+1):min(last_year,LY)
    F=find(NAO_RAW(:,1)==yy);
    V=[NAO_RAW(F-1,13) NAO_RAW(F,2:4)]; % find DJFM
    if sum(~isnan(V))==4
        NAO(yy)=mean(V);
        fprintf(fid,'%d %.3f\n',yy,NAO(yy));
    end
end
fclose(fid);

clearvars -except LY
%%%% JET %%%%
JETJJA(1:LY)=NaN;
JETDJF(1:LY)=NaN;
SS=ncread('JetDiags_ukext_seasmean_1950to2020.nc','u');
SS=SS(3,:); % select row
LL=ncread(sprintf('JetDiags_0to20W_centroidfromseasmean_1950to2020.nc'),'cen_lats_eastward_wind_');
LL=LL(3,:); % select row

JETDJF(1951:2020)=SS(4:4:end);
JETJJA(1950:2020)=LL(2:4:end);

fid=fopen('DATA/JET-JJA.txt','w+');
for yy=1950:LY
   fprintf(fid,'%d %.3f\n',yy,JETJJA(yy));
end
fclose(fid);
fid=fopen('DATA/JET-DJF.txt','w+');
for yy=1950:LY
   fprintf(fid,'%d %.3f\n',yy,JETDJF(yy));
end
fclose(fid);






