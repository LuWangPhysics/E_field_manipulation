function my_figure_settings(save_name,tick_flag)
addpath('print_file/');
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
set(0,'DefaultTextFontName','Helvitica')
set(0,'DefaultAxesFontName','Helvitica')

fontname = 'Helvetica'; 
width = 3;     % Width in inches
height = 2;    % Height in inches
alw = 1.5;    % AxesLineWidth
fsz = 20;      % Fontsize
lw = 2.5;      % LineWidth
msz = 8;       % MarkerSize
tl=0.03;       % tick length
% The properties we've been using in the figures
set(gcf,'PaperSize',[width height])
set(gca,'LineWidth',lw);   % set the default line width to lw
%set(gca,'MarkerSize',msz); % set the default line marker size to msz
set(gca,'TickLength',[tl, tl])
set(gca,'Box','on')
set(gca,'Boxstyle','full');
if(tick_flag==0)
set(gca,'TickDir','in');
end
if(tick_flag==1)
%ticks outside also means 2D plot.
set(gca,'TickDir','out');

end
set(gca,'Fontname',fontname);
%h.FontWeight='bold';
%set(gca,'fontweight','Normal');
%legend boxoff 
set(gcf,'PaperUnits', 'inches');
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
r = 300; % pixels per inch
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 width.*r height.*r]/r);


papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);


%print([save_name '.pdf'],'-dpdf');
print2eps(save_name);

my_path=pwd;
eps2pdf([my_path '/' save_name '.eps'],[my_path '/' save_name '.pdf']);
delete([my_path '/' save_name '.eps']);
end

