%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DE 190614
% Allan_deviation_wvia_DE_github_2018.m
% Matlab (v. 2017a)
% modified 2018
% LGR datasets uploaded to figshare site
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sub files
% ImportLGRall.m
% ImportLGRall2014.m
% allan.m
%
% Excel file
% allan_a_b.csv

clear all
close all
%%

addpath G:\github\Allan\Custom_2013 % Change path to your dir
addpath G:\github\Allan\Custom_2014
addpath G:\github\Allan\WVISS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setup_nr=1; % (1) 2013 (2) 2014 (3) WVISS

    if setup_nr==1
    wr_c=6;    
    elseif setup_nr==2
%     wr_c=14;
    wr_c=25;
    elseif setup_nr==3 
    wr_c=4; 
    end

%  Goes to (2013) 5, (2014), 13 (WVISS) 4


for run_nr=1:wr_c

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if setup_nr==1
% Load 2013 EP-35 data
% 2013 custom setup

    if run_nr==1
        filename='wvia_24may2013_f0001.txt';
    elseif run_nr==2    
        filename='wvia_01Jun2013_f0001.txt'; %*
    elseif run_nr==3
        filename='wvia_09jun2013_f0000.txt'; %*
    elseif run_nr==4
        filename='wvia_23jun2013_f0000.txt'; %*
    elseif run_nr==5
        filename='wvia_29jun2013_f0000.txt'; %* used fot time series fig
    elseif run_nr==6    
        filename='wvia_01jul2013_f0001.txt';
        
        
    end

elseif setup_nr==2
% Load 2014 EP-45 data

%  2014 setup

    if run_nr==1
        filename='wvia_20Jun2014_f0002.txt'; % first 12h most stable
    elseif run_nr==2    
        filename='wvia_21Jun2014_f0000.txt';
    elseif run_nr==3
        filename='wvia_22Jun2014_f0005.txt';
    elseif run_nr==4    
        filename='wvia_25Jun2014_f0004.txt';
    elseif run_nr==5     
        filename='wvia_26Jun2014_f0002.txt'; %dont use start (b)
    elseif run_nr==6
        filename='wvia_27Jun2014_f0003.txt';
    elseif run_nr==7    
        filename='wvia_28Jun2014_f0002.txt';
    elseif run_nr==8 
        filename='wvia_05Jul2014_f0002.txt';
    elseif run_nr==9 
        filename='wvia_06Jul2014_f0000.txt';
    elseif run_nr==10 
        filename='wvia_19Jul2014_f0000.txt';
    elseif run_nr==11    
        filename='wvia_20Jul2014_f0000.txt';
    elseif run_nr==12      
        filename='wvia_26Jul2014_f0000.txt';
    elseif run_nr==13 
        filename='wvia_27Jul2014_f0000.txt';
    elseif run_nr==14 
        filename='wvia_05Jun2014_f0003.txt';
    elseif run_nr==15
        filename='wvia_12Jun2014_f0007.txt';
    elseif run_nr==16
        filename='wvia_13Jun2014_f0011.txt';
    elseif run_nr==17
        filename='wvia_14Jun2014_f0016.txt';
    elseif run_nr==18
        filename='wvia_15Jun2014_f0001.txt';
    elseif run_nr==19     
        filename='wvia_16Jun2014_f0007.txt';
    elseif run_nr==20 
        filename='wvia_17Jun2014_f0004.txt';
    elseif run_nr==21 
        filename='wvia_18Jun2014_f0004.txt';
    elseif run_nr==22     
        filename='wvia_19Jun2014_f0002.txt';
    elseif run_nr==23 
        filename='wvia_12Jul2014_f0000.txt';
    elseif run_nr==24 
        filename='wvia_13Jul2014_f0000.txt';  
    elseif run_nr==25     
        filename='wvia_29Jun2014_f0003.txt';
    end
    
   

elseif setup_nr==3
    
% wviss
    if run_nr==1
        filename='wvia_22Jan2014_f0000.txt'; %   stable no airbubbles
    elseif run_nr==2    
        filename='wvia_24Jan2014_f0000.txt'; %
    elseif run_nr==3    
        filename='wvia_28Jan2014_f0000.txt'; %
    elseif run_nr==4
        filename='wvia_30Jan2014_f0000.txt'; % 
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filedir='G:\github\Allan\mat_files\';

if setup_nr==1

    % edit ImportLGRall
[Time,H2Oc_ppm,O18_del,D_del,GasP_torr,GasT_C,AmbT_C]=ImportLGRall(filename);

elseif setup_nr==2 || setup_nr==3 % with O17

[Time,H2Oc_ppm,O18_del,O17_del,D_del,GasP_torr,GasT_C]=ImportLGRall2014(filename);

end

filename_c=strcat(filedir,filename);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% save raw data as .mat
savefilename=regexprep(filename_c,'txt','mat');
% savefilename=regexprep(savefilename,'wvia','allan');
% name_short=regexprep(savefilename,'.mat','');

if setup_nr==1
    save (savefilename, 'Time','H2Oc_ppm','O18_del','D_del','GasP_torr','GasT_C');% 2013
elseif setup_nr==2 || setup_nr==3
    save (savefilename, 'Time','H2Oc_ppm','O18_del','D_del','GasP_torr','GasT_C','O17_del'); % 2014
end

 clearvars -except setup_nr

end

 

%% time series and Allan script

%load .mat file
%%%%%%%%%%%%%%%%%%
setup_nr=2; % (1), 2013 (2), 2014 (3), WVISS
% run_nr=1; % (5) used in timeseries fig in AMT paper
%%%%%%%%%%%%%%%%%
close all

dir_f='G:\github\Allan\mat_files\';


    if setup_nr==1
    wr_c=2;
   % wr_c=6;
    elseif setup_nr==2
    %wr_c=14;
    wr_c=25;
    elseif setup_nr==3
    wr_c=4; 
    end


 for run_nr= 1:wr_c  

if setup_nr==1
    
    if run_nr==1
%     load('C:/PHD/allan/2013_setup/wvia_24may2013_f0001.mat')
        load([dir_f,'wvia_24may2013_f0001.mat'])
        filename='wvia_24may2013_f0001.txt';
        filedatestring='24/05/2013';

    elseif run_nr==2
        load([dir_f,'wvia_01jun2013_f0001.mat'])
        filename='wvia_01jun2013_f0001.txt';
        filedatestring='01/06/2013';
    
    elseif run_nr==3
        load([dir_f,'wvia_09jun2013_f0000.mat'])
        filename='wvia_09jun2013_f0000.txt';
        filedatestring='09/06/2013';

    elseif run_nr==4
        load([dir_f,'wvia_23jun2013_f0000.mat'])
        filename='wvia_23jun2013_f0000.txt'; 
        filedatestring='23/06/2013';
    
    elseif run_nr==5
        load([dir_f,'wvia_29jun2013_f0000.mat'])
        filename='wvia_29jun2013_f0000.txt';
        filedatestring='29/06/2013';
    
    elseif run_nr==6
        load([dir_f,'wvia_01jul2013_f0001.mat'])
        filename='wvia_01jul2013_f0001.txt';
        filedatestring='01/07/2013';
    
    end

elseif setup_nr==2

 
 % 2014
    if run_nr==1
        load([dir_f,'wvia_20jun2014_f0002.mat'])
        filename='wvia_20Jun2014_f0002.txt'; % first 12h most stable
        filedatestring='20/06/2014';
    elseif run_nr==2
        load([dir_f,'wvia_21jun2014_f0000.mat'])
        filename='wvia_21Jun2014_f0000.txt';
        filedatestring='21/06/2014';
    elseif run_nr==3
        load([dir_f,'wvia_22jun2014_f0005.mat'])
        filename='wvia_22Jun2014_f0005.txt';
        filedatestring='22/06/2014';
    elseif run_nr==4
        load([dir_f,'wvia_25jun2014_f0004.mat'])
        filename='wvia_25Jun2014_f0004.txt';
        filedatestring='25/06/2014';
    elseif run_nr==5
        load([dir_f,'wvia_26jun2014_f0002.mat'])
        filename='wvia_26Jun2014_f0002.txt';
        filedatestring='26/06/2014';
    elseif run_nr==6
        load([dir_f,'wvia_27jun2014_f0003.mat'])
        filename='wvia_27Jun2014_f0003.txt';
        filedatestring='27/06/2014';
    elseif run_nr==7
        load([dir_f,'wvia_28jun2014_f0002.mat'])
        filename='wvia_28Jun2014_f0002.txt';
        filedatestring='28/06/2014';
    elseif run_nr==8
        load([dir_f,'wvia_05jul2014_f0002.mat'])
        filename='wvia_05Jul2014_f0002.txt';
        filedatestring='05/07/2014';
    elseif run_nr==9
        load([dir_f,'wvia_06jul2014_f0000.mat'])
        filename='wvia_06Jul2014_f0000.txt';
        filedatestring='06/07/2014';
    elseif run_nr==10
        load([dir_f,'wvia_19jul2014_f0000.mat'])
        filename='wvia_19Jul2014_f0000.txt';
        filedatestring='19/07/2014';
    elseif run_nr==11
        load([dir_f,'wvia_20jul2014_f0000.mat'])
        filename='wvia_20Jul2014_f0000.txt';
        filedatestring='20/07/2014';
    elseif run_nr==12
        load([dir_f,'wvia_26jul2014_f0000.mat'])
        filename='wvia_26Jul2014_f0000.txt';
        filedatestring='26/07/2014';
    elseif run_nr==13
        load([dir_f,'wvia_27jul2014_f0000.mat'])
        filename='wvia_27Jul2014_f0000.txt';
        filedatestring='27/07/2014';
    elseif run_nr==14
        load([dir_f,'wvia_05Jun2014_f0003.mat'])
        filename='wvia_05Jun2014_f0003.txt';
        filedatestring='05/06/2014';
    elseif run_nr==15
        load([dir_f,'wvia_12Jun2014_f0007.mat'])
        filename='wvia_12Jun2014_f0007.txt';
        filedatestring='12/06/2014';
    elseif run_nr==16
        load([dir_f,'wvia_13Jun2014_f0011.mat'])
        filename='wvia_13Jun2014_f0011.txt';
        filedatestring='13/06/2014';
    elseif run_nr==17
        load([dir_f,'wvia_14Jun2014_f0016.mat'])
        filename='wvia_14Jun2014_f0016.txt';
        filedatestring='14/06/2014';
    elseif run_nr==18
        load([dir_f,'wvia_15Jun2014_f0001.mat'])
        filename='wvia_15Jun2014_f0001.txt';
        filedatestring='15/06/2014';
    elseif run_nr==19
        load([dir_f,'wvia_16Jun2014_f0007.mat'])
        filename='wvia_16Jun2014_f0007.txt';
        filedatestring='16/06/2014';
    elseif run_nr==20
        load([dir_f,'wvia_17Jun2014_f0004.mat'])
        filename='wvia_17Jun2014_f0004.txt';
        filedatestring='17/06/2014';
    elseif run_nr==21
        load([dir_f,'wvia_18Jun2014_f0004.mat'])
        filename='wvia_18Jun2014_f0004.txt';
        filedatestring='18/06/2014';
    elseif run_nr==22
        load([dir_f,'wvia_19Jun2014_f0002.mat'])
        filename='wvia_19Jun2014_f0002.txt';
        filedatestring='19/06/2014';
    elseif run_nr==23
        load([dir_f,'wvia_12Jul2014_f0000.mat'])
        filename='wvia_12Jul2014_f0000.txt';
        filedatestring='12/07/2014';
    elseif run_nr==24
        load([dir_f,'wvia_13Jul2014_f0000.mat'])
        filename='wvia_13Jul2014_f0000.txt';
        filedatestring='13/07/2014';
    elseif run_nr==25 
        load([dir_f,'wvia_29Jun2014_f0003.mat'])
        filename='wvia_29Jun2014_f0003.txt';
        filedatestring='29/06/2014';
    end

%
% WVISS
elseif setup_nr==3

    if run_nr==1
        load([dir_f,'wvia_24jan2014_f0000.mat'])
        filename='wvia_24jan2014_f0000.txt';
        filedatestring='24/01/2014';
    elseif run_nr==2
        load([dir_f,'wvia_28jan2014_f0000.mat'])
        filename='wvia_28jan2014_f0000.txt';
        filedatestring='28/01/2014';
    elseif run_nr==3
        load([dir_f,'wvia_30jan2014_f0000.mat'])
        filename='wvia_30jan2014_f0000.txt';
        filedatestring='30/01/2014'; 
    elseif run_nr==4
        load([dir_f,'wvia_22jan2014_f0000.mat'])
        filename='wvia_22jan2014_f0000.txt';
        filedatestring='22/01/2014';
    end

end


filename_c=strcat(dir_f,filename);
t0=datenum(Time(1));
t=(datenum(Time)-t0)*3600*24;
t_diff=diff(Time);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% From allan help file
%  For rate-based data, ADEV is computed only for tau values greater than the
%   minimum time between samples and less than the half the total time. For
%   time-stamped data, only tau values greater than the maximum gap between
%   samples and less than half the total time are used.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_diff_c=diff(t);
gap_in=find(t_diff_c==max(t_diff_c)); % find location of largest gap

%%%%%%%%%%%%%%%%%%
%
% select date look-up a (start) b (stop) values from excel sheet
%
%%%%%%%%%%%%%%%%%%%%

 [excel_allan,reporttxt] = xlsread('allan_a_b.xlsx');
 date=reporttxt((3:38),2);

 tf_index = find(strcmp(date,filedatestring));
 
 a=excel_allan(tf_index ,4);
 b=excel_allan(tf_index ,5);
 
D_del=D_del(a:b);
H2Oc_ppm=H2Oc_ppm(a:b);
O18_del=O18_del(a:b);

GasT_C=GasT_C(a:b);
GasP_torr=GasP_torr(a:b);
t=t(a:b);

% d17O
    if setup_nr==2 || setup_nr==3
    O17_del=O17_del(a:b);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ts subplots 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

D_del_mean=nanmean(D_del);
O18_del_mean=nanmean(O18_del);

RM=60;
 
 
 f1= fig('units','inches','width',15,'height',9,'font','Helvetica','fontsize',14,'border','on');
 
 subplot(4,1,1), 
 hold on

r=nanmoving_average(D_del(1:end)-D_del_mean,RM); 
h=plot(t(5:end-5)/3600,r(5:end-5),'r');%;,...

    ylabel(['{\delta}D (',char(8240),')'])
    xlabel('time (h)')
    set(gca,'YLim',[-2 2])
    l=legend([num2str(RM),' s moving average']);
    grid
 
          TextBox = uicontrol('style','text');
          set(TextBox,'String','a','position',[200 760 20 20],'FontWeight','bold','FontSize',13 ); % x position y position xsize ysize
          set(TextBox,'foregroundcolor', [0 0 0], ...
         'backgroundcolor', [1 1 1]);
                   
    hold off
 
 subplot(4,1,2)
 hold on
 
 r1=nanmoving_average(O18_del(1:end)-O18_del_mean,RM);
 
  h2=plot(t(5:end-5)/3600,r1(5:end-5),'b');
  

 ylabel(['{\delta}^1^8O (',char(8240),')'])
 xlabel('time (h)')

 l2=legend([num2str(RM),' s moving average']);

 set(gca,'YLim',[-1.5 1.5])
 grid
 
           TextBox = uicontrol('style','text');
          set(TextBox,'String','b','position',[200 560 20 20],'FontWeight','bold','FontSize',13 ); % x position y position xsize ysize
          set(TextBox,'foregroundcolor', [0 0 0], ...
         'backgroundcolor', [1 1 1]);

 hold off
 
 
 subplot(4,1,3)
 hold on
 

 h3=plot(t(1:end)/3600,nanmoving_average(H2Oc_ppm(1:end),RM),'g');%,...
 
    ylabel('H_2O conc (ppm)')
    xlabel('time (h)')
    l3=legend([num2str(RM),' s moving average']);
    %  set(l3,'FontSize',7,'location','SouthEast');
    set(gca,'YLim',[18000 22000])
    grid
 
          TextBox = uicontrol('style','text');
          set(TextBox,'String','c','position',[200 385 20 20],'FontWeight','bold','FontSize',13 ); % x position y position xsize ysize
          set(TextBox,'foregroundcolor', [0 0 0], ...
         'backgroundcolor', [1 1 1]);
 
    hold off
 
 
 subplot(4,1,4)
 hold on

 plot(t(1:end)/3600,GasT_C(1:end),'r')
 
 ylabel('Cavity temp ( ^{\circ}C)')
 xlabel('time (h)')
 grid
 
 l2=legend([num2str(RM),' s moving average']);
          TextBox = uicontrol('style','text');
          set(TextBox,'String','d','position',[200 200 20 20],'FontWeight','bold','FontSize',13 ); % x position y position xsize ysize
          set(TextBox,'foregroundcolor', [0 0 0], ...
         'backgroundcolor', [1 1 1]);
 
 hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save figure

save_ts_fig=0; %%%%%%%%%%%%%%%%%%

if save_ts_fig==1
 savefilename_c=regexprep(filename_c,'.txt','');
 saveas(f1,[savefilename_c,'time_series'],'fig')
% for paper
 orient landscape
 export_fig('-png','-nocrop','-painters' ,'-r500', [savefilename_c,'time_series']); % This function is available on File Exchange

end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% check
check_nr=0;
    if check_nr==1
    t_duration=t(end)/3600-t(1)/3600 % h
    %t_nodrips_duration=t_nodrips(b)/3600-t_nodrips(a)/3600;
    H2Oc_ppm_nodrips_mean=nanmean(H2Oc_ppm)
    H2Oc_ppm_nodrips_std=nanstd(H2Oc_ppm)
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save run stat files

save_stats=0;
if save_stats==1
    M=[a b t_duration H2Oc_ppm_nodrips_mean H2Oc_ppm_nodrips_std];
    filedir ='C:/PHD/allan_stats/'; % Ienovo
    filename_c2=strcat(filedir,filename);
    % saveas(f2,[filename_c,'_allan_stats'],'fig')
    filename_c2=regexprep(filename_c2,'.txt','');
    filename_c2=[filename_c2,'allan_stats'];
    % open a file for writing
    fid = fopen(filename_c2, 'w');
    % print a title, followed by a blank line
    fprintf(fid, 'a b t_duration H2O_ppm_mean H2O_ppm_std');
    fprintf(fid,'\r\n');
    % print values in column order
    % two values appear on each row of the file
    fprintf(fid, '%6.0f  %6.0f %6.2f  %6.0f %6.0f \n', M);
    fclose(fid);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Run Allan script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%t0=datenum('jan 0, 2013');
%n1=t_nodrips*24*60*60-t_nodrips(1)*24*60*60;

%n1=t_nodrips-t_nodrips(1); comment/uncomment
n1=t-t(1);

%n1=n;
%n1=t*24*60*60-t(1)*24*60*60; % convert from days to seconds 
%n1=t_nodrips;%-t0)*24*60*60;



%dD
%D_del=D_del_nodrips(1:end);
D_del=D_del(1:end); %dont remove any data (nodrips)
DATA_2H.freq=D_del;  % Isotope data 
DATA_2H.rate=0; % Hz if set to 0 it will use timesteps instead
%DATA_2H.time=n1;    % use Hz column in LGR file instead
DATA_2H.time=n1;

%O18_del
%O18_del=O18_del_nodrips(1:end);
O18_del=O18_del(1:end);
DATA_O18.freq=O18_del;  %Isotope data 
DATA_O18.rate=0; % Hz
%DATA_O18.time=n1;
DATA_O18.time=n1;

%specify tau parameter

%w=1:1:1000;%10^3
%w=1:1:10000; %10^4
w=1:1:100000; %10^5

%w=[0.001,0.01,1,2,5,10,15,20,25,30,50,75,100,200,500,1000];
%w=w';
%c=allan(DATA, [2,5,10,15,20,25,30,50,75,100,200,500],'Isotope Data');
%hold on
% edit allan
% https://se.mathworks.com/matlabcentral/fileexchange/13246-allan

 [All_2H_RETVAL, All_2H_S, All_2H_ERRORB, All_2H_TAU]=allan(DATA_2H, w,'{\delta}^2H',0);
 [All_O18_RETVAL, All_O18_S, All_O18_ERRORB, All_O18_TAU]=allan(DATA_O18, w,'{\delta}^1^8O',0);
 
if setup_nr==2 || setup_nr==3
    % 2014 EP-45
    %O17_del
    %O17_del=O17_del_nodrips(1:end);
    %O17_del=O17_del(1:end);
    DATA_O17.freq=O17_del;  % Isotope data 
    DATA_O17.rate=0; % Hz
    DATA_O17.time=n1;

    [All_O17_RETVAL, All_O17_S, All_O17_ERRORB, All_O17_TAU]=allan(DATA_O17, w,'{\delta}^1^7O',0);

end

%%%%%%%%%%%%%%
% all iso figure 11.0 EP-45 figure d18O, dD and d17O

f2=figure;
%hold on

if setup_nr==1
    loglog(All_O18_TAU,All_O18_RETVAL,'.k',All_2H_TAU,All_2H_RETVAL,'+b');
elseif setup_nr==2 || setup_nr==3
    loglog(All_O18_TAU,All_O18_RETVAL,'k',All_2H_TAU,All_2H_RETVAL,'b',All_O17_TAU,All_O17_RETVAL,'r');
end

%loglog(All_O18_TAU_23jun2013_f0000,All_O18_RETVAL_23jun2013_f0000,'r',All_2H_TAU_23jun2013_f0000,All_2H_RETVAL_23jun2013_f0000,'g');


    %ylabel(['Allan Variance (',char(8240)])
    legend('{\delta}^1^8O','{\delta}^2H', '{\delta}^1^7O')
    title('Allan Deviation')
    grid
    %set(gca,'gridlinestyle','--','Xcolor', [0.5 0.5 0.5],'Ycolor', [0.5 0.5 0.5])
    ylabel(['{\sigma} (', char(8240) ')'])
    xlabel('Averaging Time (s)')
    Caxes = copyobj(gca,gcf);
    set(Caxes, 'color', 'none', 'xcolor', 'k', 'xgrid', 'off', 'ycolor','k', 'ygrid','off');

% set(h, 'color', [0.5 0.5 0.5])
grid minor

%stats
%d18O
min_O18=min(All_O18_RETVAL);
%min_O18_loc=All_O18_RETVAL(find(min(All_O18_RETVAL));
[r,c_O18]=find(All_O18_RETVAL==min(min(All_O18_RETVAL)));
opt_O18_TAU=All_O18_TAU(c_O18);
%dD
min_dD=min(All_2H_RETVAL);
[r,c_2H]=find(All_2H_RETVAL==min(min(All_2H_RETVAL)));
opt_2H_TAU=All_2H_TAU(c_2H);


%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_ind_allan_fig=0;
if save_ind_allan_fig==1
    save figure
    savefilename_c=regexprep(filename_c,'.txt','');
    saveas(f2,[savefilename_c,'iso_all'],'fig')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save x file

savefilename=regexprep(filename_c,'txt','mat');
savefilename=regexprep(savefilename,'wvia','allan');

record.All_O18_TAU = All_O18_TAU';
record.All_O18_RETVAL = All_O18_RETVAL';
record.All_2H_TAU = All_2H_TAU';
record.All_2H_RETVAL = All_2H_RETVAL';


% T
All_O18_TAU = All_O18_TAU';
All_O18_RETVAL = All_O18_RETVAL';
All_2H_TAU = All_2H_TAU';
All_2H_RETVAL = All_2H_RETVAL';

% EP-45 d17O
if setup_nr==2 || setup_nr==3
    All_O17_TAU = All_O17_TAU';
    All_O17_RETVAL = All_O17_RETVAL';
    record.All_O17_TAU = All_O17_TAU;
    record.All_O17_RETVAL = All_O17_RETVAL;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save Allan data

if setup_nr==1
save (savefilename, 'record','All_O18_TAU','All_2H_TAU',...
    'All_O18_RETVAL','All_2H_RETVAL');
elseif setup_nr==2 || setup_nr==3
save (savefilename, 'record', 'All_O18_TAU','All_2H_TAU','All_O17_TAU',...
    'All_O18_RETVAL','All_2H_RETVAL','All_O17_RETVAL');
end


 clearvars -except setup_nr dir_f

 end % loop

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load all Allan files
% CFA paper figures
% Allan


% setup_nr=2; %(1) setup 2013(2) setup 2014 (3) WVISS %%%%%%%%%%%%%%%%%%%%%%%

% Custom
% filedir ='C:/DanielE/Allan_test_files/Custom_2013/';

% filedir ='G:/backup/Allan_test_files/Custom_2013/'; % external hard drive
filedir ='F:\github\Allan\mat_files\';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(strcat(filedir,'allan_01jun2013_f0001.mat'));
record_01jun2013=record;

load(strcat(filedir,'allan_09jun2013_f0000.mat'));
record_09jun2013=record;

load(strcat(filedir,'allan_23jun2013_f0000.mat'));
record_23jun2013=record;

load(strcat(filedir,'allan_29jun2013_f0000.mat'));
record_29jun2013=record;

%%%%%%%%%%%%
    show_additional_rec=1; % (1/0) %%%%%%%%%%%%%%%%%%%% 

if show_additional_rec
    load(strcat(filedir,'allan_24may2013_f0001.mat'));
    record_24may2013=record;

    load(strcat(filedir,'allan_01jul2013_f0001.mat'));
    record_01jul2013=record;
end
%%%%%%%%%%%%%

%wviss
% filedir ='C:/DanielE/Allan_test_files/WVISS/';
% filedir ='G:/backup/Allan_test_files/WVISS/'; % external hard drive

load(strcat(filedir,'allan_22Jan2014_f0000.mat')); %%%%%%%%%%%%%%%%%%%
record_22Jan2014=record;

load(strcat(filedir,'allan_24Jan2014_f0000.mat'));
record_24Jan2014=record;

load(strcat(filedir,'allan_28Jan2014_f0000.mat'));
record_28Jan2014=record;

load(strcat(filedir,'allan_30Jan2014_f0000.mat'));
record_30Jan2014=record;


% 2014 setup

%  filedir ='C:/DanielE/Allan_test_files/2014_setup/'; %gns
%  filedir ='C:/PHD/allan/2014_setup/old_files/';  %Ienovo
% filedir ='G:/backup/Allan_test_files/2014_setup/'; % external hard drive

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(strcat(filedir,'allan_05Jun2014_f0003.mat'));
record_05june2014=record;
load(strcat(filedir,'allan_12Jun2014_f0007.mat'));
record_12june2014=record;
load(strcat(filedir,'allan_13Jun2014_f0011.mat'));
record_13june2014=record;
load(strcat(filedir,'allan_14Jun2014_f0016.mat'));
record_14june2014=record;
load(strcat(filedir,'allan_15Jun2014_f0001.mat'));
record_15june2014=record;
load(strcat(filedir,'allan_16Jun2014_f0007.mat'));
record_16june2014=record;
load(strcat(filedir,'allan_17Jun2014_f0004.mat'));
record_17june2014=record;
load(strcat(filedir,'allan_18Jun2014_f0004.mat'));
record_18june2014=record;
load(strcat(filedir,'allan_19Jun2014_f0002.mat'));
record_19june2014=record;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(strcat(filedir,'allan_20Jun2014_f0002.mat'));
record_20june2014=record;
load(strcat(filedir,'allan_21Jun2014_f0000.mat'));
record_21june2014=record;
load(strcat(filedir,'allan_22Jun2014_f0005.mat'));
record_22june2014=record;
% load(strcat(filedir,'allan_23Jun2014_f0000.mat'));
% record_23june2014=record;
% load(strcat(filedir,'allan_24Jun2014_f0003.mat'));
% record_24june2014=record;

load(strcat(filedir,'allan_25Jun2014_f0004.mat'));
record_25june2014=record;
load(strcat(filedir,'allan_26Jun2014_f0002.mat'));
record_26june2014=record;
load(strcat(filedir,'allan_27Jun2014_f0003.mat'));
record_27june2014=record;
load(strcat(filedir,'allan_28Jun2014_f0002.mat'));
record_28june2014=record;

% July 2014

load(strcat(filedir,'allan_19Jul2014_f0000.mat'));
record_19jul2014=record;
load(strcat(filedir,'allan_20Jul2014_f0000.mat'));
record_20jul2014=record;


if show_additional_rec==1
    
    
    
    
    
    %%%%%
    
    load(strcat(filedir,'allan_29Jun2014_f0003.mat'));%%%%%%%%%%%%%%%%%
    record_29june2014=record;
    
    
    load(strcat(filedir,'allan_05Jul2014_f0002.mat'));
    record_05jul2014=record;
    
    load(strcat(filedir,'allan_06Jul2014_f0000.mat'));
    record_06jul2014=record;
       

    load(strcat(filedir,'allan_12Jul2014_f0000.mat'));
    record_12jul2014=record;
    load(strcat(filedir,'allan_13Jul2014_f0000.mat'));
    record_13jul2014=record;

    load(strcat(filedir,'allan_26Jul2014_f0000.mat'));
    record_26jul2014=record;
    
    load(strcat(filedir,'allan_27Jul2014_f0000.mat'));
    record_27jul2014=record;
    

    
    
end


% load picarro data (not included in the figshare dataset upload)
load('Allan_Gkinis_syttensen.mat'); %gkinis time series my script
load('Allan_Gkinis_Vas_calcs_20140530.mat') % gkinis calcs
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fig d18O
% mean custom


show_additional_rec_2013=0; %%%(1/0)%%%%%%%%%%%
show_additional_rec_2014=1; %%%(1/0) not both on at the same time %%%%%%%%%%
%  show_additional_rec=0; 

% Find shortest record
    
    le_1=length(record_24may2013.All_O18_TAU);
    le_2=length(record_01jun2013.All_O18_TAU);%%%
    le_3=length(record_09jun2013.All_O18_TAU);
    le_4=length(record_23jun2013.All_O18_TAU);
    le_5=length(record_29jun2013.All_O18_TAU);    
    
les_custom=min([le_2 le_3 le_4 le_5]');
clear le_1 le_2 le_3 le_4 le_5


R=[record_01jun2013.All_O18_TAU(1:les_custom)';...
    record_09jun2013.All_O18_TAU(1:les_custom)';...
    record_23jun2013.All_O18_TAU(1:les_custom)';...
    record_29jun2013.All_O18_TAU(1:les_custom)'];

All_O18_TAU_custom_mean=mean(R,1);
All_2H_TAU_custom_mean=All_O18_TAU_custom_mean;
clear R

R=[record_01jun2013.All_O18_RETVAL(1:les_custom)';...
    record_09jun2013.All_O18_RETVAL(1:les_custom)';...
    record_23jun2013.All_O18_RETVAL(1:les_custom)';...
    record_29jun2013.All_O18_RETVAL(1:les_custom)'];

All_O18_RETVAL_custom_mean=mean(R,1);
clear R


R=[record_01jun2013.All_2H_RETVAL(1:les_custom)';...
    record_09jun2013.All_2H_RETVAL(1:les_custom)';...
    record_23jun2013.All_2H_RETVAL(1:les_custom)';...
    record_29jun2013.All_2H_RETVAL(1:les_custom)'];


All_2H_RETVAL_custom_mean=mean(R,1);



%WVISS
    le_1=length(record_22Jan2014.All_O18_TAU);
    le_2=length(record_24Jan2014.All_O18_TAU);
    le_3=length(record_28Jan2014.All_O18_TAU);
    le_4=length(record_30Jan2014.All_O18_TAU); 
les_WVISS=min([le_1 le_2 le_3 le_4]');
clear  le_2 le_3 le_4

R=[ record_24Jan2014.All_O18_TAU(1:les_WVISS)';...
   record_28Jan2014.All_O18_TAU(1:les_WVISS)';...
   record_30Jan2014.All_O18_TAU(1:les_WVISS)'];


All_O18_TAU_WVISS_mean=mean(R,1);
All_2H_TAU_WVISS_mean=All_O18_TAU_WVISS_mean;
All_O17_TAU_WVISS_mean=All_O18_TAU_WVISS_mean;

clear R

R=[record_24Jan2014.All_O18_RETVAL(1:les_WVISS)';...
   record_28Jan2014.All_O18_RETVAL(1:les_WVISS)';...
   record_30Jan2014.All_O18_RETVAL(1:les_WVISS)'];


All_O18_RETVAL_WVISS_mean=mean(R,1);
clear R

R=[record_24Jan2014.All_2H_RETVAL(1:les_WVISS)';...
   record_28Jan2014.All_2H_RETVAL(1:les_WVISS)';...
   record_30Jan2014.All_2H_RETVAL(1:les_WVISS)'];


All_2H_RETVAL_WVISS_mean=mean(R,1);
clear R

R=[record_24Jan2014.All_O17_RETVAL(1:les_WVISS)';...
   record_28Jan2014.All_O17_RETVAL(1:les_WVISS)';...
   record_30Jan2014.All_O17_RETVAL(1:les_WVISS)'];
All_O17_RETVAL_WVISS_mean=mean(R,1);
clear R


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figures
% del_18O
% f1= figure('position',[300 100 1100 700]);

f1=fig('units','inches','width',12,'height',9,'font','Helvetica','fontsize',16,'border','on');

%************* 
% Custom 2013
%*************
    
   
    color_code_1=[0.9,0.4,0.2];

   
   h1= loglog(record_01jun2013.All_O18_TAU,...
       record_01jun2013.All_O18_RETVAL,'Color', color_code_1);
   
       hold on
       loglog(record_09jun2013.All_O18_TAU,...
       record_09jun2013.All_O18_RETVAL,'Color', color_code_1);
   
       loglog(record_23jun2013.All_O18_TAU,...
       record_23jun2013.All_O18_RETVAL,'Color', color_code_1);
   
       loglog(record_29jun2013.All_O18_TAU,...
       record_29jun2013.All_O18_RETVAL,'Color', color_code_1);   
      
   
   if show_additional_rec==1 && show_additional_rec_2013==1
       
      color_code_1c=[0.9,0.3,0.1];
      loglog(record_24may2013.All_O18_TAU,...
      record_24may2013.All_O18_RETVAL,'.','Color', color_code_1c);
   
      loglog(record_01jun2013.All_O18_TAU,...
      record_01jun2013.All_O18_RETVAL,'.','Color', color_code_1c);
   
   end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%WVISS 
   color_code_2=[0.2,0.7,0.1];
   h2=loglog(record_22Jan2014.All_O18_TAU,...
   record_22Jan2014.All_O18_RETVAL,'Color',color_code_2);

   loglog(record_24Jan2014.All_O18_TAU,...
   record_24Jan2014.All_O18_RETVAL,'Color', color_code_2);

% h2=    loglog(record_28Jan2014.All_O18_TAU,...
%     record_28Jan2014.All_O18_RETVAL,'Color', color_code_2);

    loglog(record_30Jan2014.All_O18_TAU,...
    record_30Jan2014.All_O18_RETVAL,'Color', color_code_2);

   
   % 2014 setup
% h5=loglog(record_05june2014.All_O18_TAU_allan_05Jun2014_f0003,...
%     record_05june2014.All_O18_RETVAL_allan_05Jun2014_f0003,'Color',[0.5,0.2,0.2]);   
% loglog(record_20june2014.All_O18_TAU_allan_20Jun2014_f0002,...
%     record_20june2014.All_O18_RETVAL_allan_20Jun2014_f0002,'Color',[0.5,0.2,0.2]);
% 
%  
   
% Mean Lines
   h3=loglog(All_O18_TAU_custom_mean,All_O18_RETVAL_custom_mean,'Color',[0.3,0.0,0.0], 'LineWidth', 2); %mean custom
   h4=loglog(All_O18_TAU_WVISS_mean,All_O18_RETVAL_WVISS_mean,'Color',[0.0,0.3,0.0], 'LineWidth', 2); %mean WVISS
%  h5=loglog(All_O18_TAU_2014setup_mean,All_O18_RETVAL_2014setup_mean,'Color',[0.0,0.3,0.0],'LineWidth', 2); 


% Gkinis Picarro 20140530
%  loglog(int_time,sqrt(allan_d18O),'r') % allan Gkinis calcs (sqrt convert to allan deviation)

 h6=loglog(All_O18_TAU_Gkinis,All_O18_RETVAL_Gkinis,'k', 'LineWidth', 2);%gkinis time series run through my allan script


 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% 2014 setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h5=    loglog(record_19jul2014.All_O18_TAU,...
       record_19jul2014.All_O18_RETVAL,...
       'Color',[0.5,0.5,0.8], 'LineWidth', 1);
       
       loglog(record_20jul2014.All_O18_TAU,...
       record_20jul2014.All_O18_RETVAL,...
       'Color',[0.5,0.5,0.8], 'LineWidth', 1);
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   if show_additional_rec==1 && show_additional_rec_2014==1
       
        color_code_3_c=[0.3,0.3,0.8];   

       loglog(record_05june2014.All_O18_TAU,...
       record_05june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
        
       loglog(record_20june2014.All_O18_TAU,...
       record_20june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);       
       
       loglog(record_21june2014.All_O18_TAU,...
       record_21june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_22june2014.All_O18_TAU,...
       record_22june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_25june2014.All_O18_TAU,...
       record_25june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_26june2014.All_O18_TAU,...
       record_26june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);   
   
       loglog(record_27june2014.All_O18_TAU,...
       record_27june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_28june2014.All_O18_TAU,...
       record_28june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_05jul2014.All_O18_TAU,...
       record_05jul2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_06jul2014.All_O18_TAU,...
       record_06jul2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_26jul2014.All_O18_TAU,...
       record_26jul2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_27jul2014.All_O18_TAU,...
       record_27jul2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
   %%%%%%%%%%
       loglog(record_12june2014.All_O18_TAU,...
       record_12june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_13june2014.All_O18_TAU,...
       record_13june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);

       loglog(record_14june2014.All_O18_TAU,...
       record_14june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_15june2014.All_O18_TAU,...
       record_15june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_16june2014.All_O18_TAU,...
       record_16june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_17june2014.All_O18_TAU,...
       record_17june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_18june2014.All_O18_TAU,...
       record_18june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_29june2014.All_O18_TAU,...
       record_29june2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_12jul2014.All_O18_TAU,...  % * stable run
       record_12jul2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_13jul2014.All_O18_TAU,...  % * stable run
       record_13jul2014.All_O18_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   

   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   

   h7=hline(0.054016,'--k'); % precsion average from std calculated for 
   % injection contributing to each samples value for samples:
   % w-132110 to w-130276 (outer 5622 to 5680)
   
    set(h7, 'LineWidth', 2); % in word document the line disapears if not a bit thicker

   hold off
  
% w. 2014 setup   
 h_leg=legend([h1 h3 h2 h4 h5 h6],'Custom 2013','Mean of custom 2013','WVISS',...
    'Mean of WVISS','Custom 2014',...
    'UC setup','location','SouthWest');

   title('Allan Deviation {\delta}^1^8O')
   ylabel(['{\sigma}_A_l_l_a_n (', char(8240) ')'])
   xlabel('Averaging Time (s)')
   set(gca,'YLim',[0.001 1])
         
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         set(gca,...
          'linewidth',2,...
          'FontWeight','bold' ); 
 %%%%%%%%%%%%%%%%%%%%%%
 
 
    if show_additional_rec==0
    letter='a';
    elseif show_additional_rec==1 && show_additional_rec_2013==1
    letter='c';
    elseif show_additional_rec==1 && show_additional_rec_2014==1
    letter='e';
    end
 
 
 letter_pos=[75 690 50 60];
 
          TextBox = uicontrol('style','text');
          set(TextBox,'String',letter,'position',letter_pos,'FontWeight','bold','FontSize',34 ); % x position y position xsize ysize
          set(TextBox,'foregroundcolor', [0 0 0], ...
         'backgroundcolor', [1 1 1]);
 %%%%%%%%%%%%%%
 
 
 %%%%%
 
   grid
   hold off
  
   
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 % save figure
  
 
 if show_additional_rec==0
    
    file_end_str='';
    
 elseif show_additional_rec==1 && show_additional_rec_2013==1
  
    file_end_str='_c13';
    
 elseif show_additional_rec==1 && show_additional_rec_2014==1
  
    file_end_str='_c14';
    
 end
 
orient landscape
 
filedir ='C:\PHD\matlab_storage_of_output_files\figures\';
filename='Allan_d18O_Eman_AMT';
savefilename_c=strcat(filedir,filename,file_end_str);
 

 % using the export_fig function 
  export_fig('-png','-nocrop','-painters' ,'-r250', 'f04_allan_d18O', savefilename_c);
%   export_fig('-pdf','-nocrop','-painters' ,'-r500', 'f04_allan_d18O');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fig del_D 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 f1=fig('units','inches','width',12,'height',9,'font','Helvetica','fontsize',16,'border','on');

%************* 
% 2013 Custom
%*************
   
  color_code_1=[0.9,0.4,0.2]; 
%    h1=loglog(record_24may2013.All_2H_TAU,...
%        record_24may2013.All_2H_RETVAL,'Color', color_code_1);

       h1=loglog(record_01jun2013.All_2H_TAU,...
       record_01jun2013.All_2H_RETVAL,'Color', color_code_1);
    hold on
       loglog(record_09jun2013.All_2H_TAU,...
       record_09jun2013.All_2H_RETVAL,'Color', color_code_1);
       loglog(record_23jun2013.All_2H_TAU,...
       record_23jun2013.All_2H_RETVAL,'Color', color_code_1);
       loglog(record_29jun2013.All_2H_TAU,...
       record_29jun2013.All_2H_RETVAL,'Color', color_code_1);   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%WVISS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

color_code_2=[0.2,0.7,0.1];


h2=loglog(record_24Jan2014.All_2H_TAU,...
    record_24Jan2014.All_2H_RETVAL,'Color', color_code_2);
    loglog(record_28Jan2014.All_2H_TAU,...
    record_28Jan2014.All_2H_RETVAL,'Color', color_code_2);
    loglog(record_30Jan2014.All_2H_TAU,...
    record_30Jan2014.All_2H_RETVAL,'Color', color_code_2);



   if show_additional_rec_2013==1
       
      color_code_1c=[0.9,0.3,0.1];
      
      loglog(record_24may2013.All_2H_TAU,...
      record_24may2013.All_2H_RETVAL,'.','Color', color_code_1c);
   
      loglog(record_01jun2013.All_2H_TAU,...
      record_01jun2013.All_2H_RETVAL,'.','Color', color_code_1c);
   end


%%%%%%%%%%%%%%%%%%%%%%%%%%   
% 2014 setup
%%%%%%%%%%%%%%%%%%%%%%%%%%

  
% Mean Lines
   h3=loglog(All_O18_TAU_custom_mean,All_2H_RETVAL_custom_mean,'Color',[0.3,0.0,0.0], 'LineWidth', 2); %mean custom
   h4=loglog(All_O18_TAU_WVISS_mean,All_2H_RETVAL_WVISS_mean,'Color',[0.0,0.3,0.0], 'LineWidth', 2); %mean WVISS
 


    if show_additional_rec_2014==1
       
       color_code_3_c=[0.3,0.3,0.8];   
       
       loglog(record_05june2014.All_2H_TAU,...
       record_05june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);  
              
       loglog(record_20june2014.All_2H_TAU,...
       record_20june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);       
       
       loglog(record_21june2014.All_2H_TAU,...
       record_21june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_22june2014.All_2H_TAU,...
       record_22june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_25june2014.All_2H_TAU,...
       record_25june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_26june2014.All_2H_TAU,... % ** stable
       record_26june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);   
   
       loglog(record_27june2014.All_2H_TAU,... 
       record_27june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_28june2014.All_2H_TAU,...  % ** stable
       record_28june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_05jul2014.All_2H_TAU,...
       record_05jul2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_06jul2014.All_2H_TAU,...
       record_06jul2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_26jul2014.All_2H_TAU,...
       record_26jul2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_27jul2014.All_2H_TAU,...
       record_27jul2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
   
   
       loglog(record_12june2014.All_2H_TAU,...  % ** stable reduced long-term drift
       record_12june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_13june2014.All_2H_TAU,...   % ** stable reduced long-term drift
       record_13june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);

       loglog(record_14june2014.All_2H_TAU,...     % ** stable reduced long-term drift
       record_14june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1); 
   
       loglog(record_15june2014.All_2H_TAU,...       % ** stable reduced long-term drift
       record_15june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_16june2014.All_2H_TAU,...
       record_16june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_17june2014.All_2H_TAU,...
       record_17june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_18june2014.All_2H_TAU,...
       record_18june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_29june2014.All_2H_TAU,...
       record_29june2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
       loglog(record_12jul2014.All_2H_TAU,...
       record_12jul2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
%    
       loglog(record_13jul2014.All_2H_TAU,...
       record_13jul2014.All_2H_RETVAL,...
       'Color',color_code_3_c, 'LineWidth', 1);
   
   %%%
   
   
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gkinis Picarro 20140530
%  loglog(int_time,sqrt(allan_d18O),'r') % allan Gkinis calcs (sqrt convert to allan deviation)

 h6=loglog(All_2H_TAU_Gkinis,All_2H_RETVAL_Gkinis,'k', 'LineWidth', 2); %gkinis time series run through my allan script

   
 h5=loglog(record_19jul2014.All_2H_TAU,...
       record_19jul2014.All_2H_RETVAL,...
       'Color',[0.5,0.5,0.8], 'LineWidth', 1);
       
       loglog(record_20jul2014.All_2H_TAU,...
       record_20jul2014.All_2H_RETVAL,...
       'Color',[0.5,0.5,0.8], 'LineWidth', 1);
   
  h7= hline(0.323033,'--k'); % precsion average from std calculated for 
   % injection contributing to each samples value for samples:
   % w-132110 to w-130276 (outer 5622 to 5680)
 % set(h7, 'LineWidth', 2.5); 
    set(h7, 'LineWidth', 2);
%   loglog(All_2H_TAU,All_2H_RETVAL,'r'); %current run
   hold off

% w. 2014 setup   
 h_leg=legend([h1 h3 h2 h4 h5 h6],'Custom 2013','Mean of Custom 2013','WVISS',...
    'Mean of WVISS','Custom 2014',...
    'UC setup','location','SouthWest');
  
    title('Allan Deviation {\delta}D')

 % set(le,'location','SouthWest','FontSize',10,'color',[0.8 0.8 0.8]);
   ylabel(['{\sigma}_A_l_l_a_n (', char(8240) ')'])
   xlabel('Averaging Time (s)')
  
   set(gca,'YLim',[0.01 3])       
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         set(gca,...
          'linewidth',2,...
          'FontWeight','bold' ); 
 %%%%%%%%%%%%%%%%%%%%%% 
    if show_additional_rec==0
    letter='b';
    elseif show_additional_rec==1 && show_additional_rec_2013==1
    letter='d';
    elseif show_additional_rec==1 && show_additional_rec_2014==1
    letter='f';
    end
 
          TextBox = uicontrol('style','text');
          set(TextBox,'String',letter,'position',letter_pos,'FontWeight','bold','FontSize',34 ); % x position y position xsize ysize
          set(TextBox,'foregroundcolor', [0 0 0], ...
         'backgroundcolor', [1 1 1]);
 %%%%%%%%%%%%%%
    
   grid
   hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%  save figure


filedir ='C:\PHD\matlab_storage_of_output_files\figures\';
filename='Allan_dD_Eman_AMT';
savefilename_c=strcat(filedir,filename,file_end_str);

     
 orient landscape
%  name='f08_response_time';
 % using the export_fig function text boxes doesnt get moved around
 %   export_fig -r400 Test.pdf
  export_fig('-png','-nocrop','-painters' ,'-r250', 'f05_allan_dDO', savefilename_c);
%   export_fig('-pdf','-nocrop','-painters' ,'-r500', 'f05_allan_dDO');

