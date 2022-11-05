clear all
close all
LY=2021;

%%% SEA ICE %%%
SICE(1:LY)=NaN;
SI=load('ARCTIC-SEA-ICE/OctNov-volume-N30.dat');
fid=fopen('DATA/ARCTIC-SEA-ICE.txt','w+');
for yy=SI(1,1):SI(end,1)
    F=find(SI(:,1)==yy);
    fprintf(fid,'%.2f %.3f\n',yy,SI(F,2));
end

clearvars -except LY
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
    if length(F)>=728 & length(F)<=732 % twice per day, each day, allowing for one missing day
     AMOC(yy)=nanmean(MOC_RAW(F,end));
     fprintf(fid,'%.2f %.3f\n',yy+0.25,AMOC(yy));
    else
        disp(sprintf('%d %d',yy,length(F)));
        AMOC2(yy)=nanmean(MOC_RAW(F,end));
    end
end
fclose(fid);

clearvars -except LY
%%% SPG
SPG(1:LY)=NaN;
SPGOHC=ncread('SPG-OHC/EN4_OHC_NA.nc','OHC_EN4_1000m_SPG');
SPGOHCtime=ncread('SPG-OHC/EN4_OHC_NA.nc','time');
first_year=1950;
last_year=2020;
fid=fopen('DATA/SPG-OHC.txt','w+');
for yy=(first_year):last_year
   SPG(yy)=mean(SPGOHC(12*(yy-first_year)+[1:12]))/1e21;
   fprintf(fid,'%d %.3f\n',yy,SPG(yy));
end

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

clearvars
%%%% JET %%%%
LY=2021;
JETJJA(1:LY)=NaN;
JETDJF(1:LY)=NaN;
SS=ncread('JET/JetDiags_ukext_seasmean_1950to2021.nc','u');
SS=SS(3,:); % select row
LL=ncread(sprintf('JET/JetDiags_0to20W_centroidfromseasmean_1950to2021.nc'),'cen_lats_eastward_wind_');
LL=LL(3,:); % select row

JETDJF(1951:LY)=SS(4:4:end);
JETJJA(1950:LY)=LL(2:4:end);

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

clearvars -except LY
%%%% OZONE %%%%
LY=2018;
first_year=2005;
OZONE(1:LY)=NaN;
OZONE_RAW=load('OZONE/Raw_ozone_data_0-60N_100W-30E.txt');
fid=fopen('DATA/OZONE.txt','w+');
for yy=first_year:LY
    O(yy)=mean(OZONE_RAW((yy-first_year)*12+[1:12]));
    fprintf(fid,'%d %.3f\n',yy,O(yy));
end
fclose(fid);

