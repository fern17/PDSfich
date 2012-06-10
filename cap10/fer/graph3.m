function graph3(z,xtics,ytics);
% function graph3(z,xtics,ytics);
%
% This function makes a image plot of a given matrix, in a format similar to imagesc of matlab,
% but using gnuplot instead of the imagesc function of octave, which uses some external program 
% like imagemagick to display an image. 
% Parameters:
%
% z     - Matrix to plot. If this is complex, only the real part is plotted.
% xtics - Vector with the values to be used as labels in x axis.
% ytics - Vector with the values to be used as labels in y axis.
%
% Author: Leandro Di Persia
% Last Modified 01/06/07

[pp,qq]=size(z);
%uses one more to avoid losing a file and a column, due to the pm3d restrictions of gnuplot
aux = zeros(pp+1,qq+1);
aux(1:pp,1:qq) = z;
%clear previous graphics
%clearplot;

%define properties to pm3d mode in map view
__gnuplot_raw__("set hidden3d;\n");
__gnuplot_raw__("set data style lines;\n");
__gnuplot_raw__("set nocontour;\n");
__gnuplot_raw__("set pm3d at b;\n");
__gnuplot_raw__("set pm3d corners2color c1;\n");
__gnuplot_raw__("unset surf;\n");
__gnuplot_raw__("set view map;\n");	

%manage the axis tics
[ly, lx] = size(z);
yini=0.5;
yfin=ly-0.5;
yrange=yfin-yini;
xini=0.5;
xfin=lx-0.5;
xrange=xfin-xini;

ysc=(yrange/(length(ytics)-1));
xsc=(xrange/(length(xtics)-1));

cmd="set xtics (";
for s=1:length(xtics)-1,
   cmd=strcat(cmd, "\"",num2str(xtics(s)),"\" ", num2str(xsc*(s-1)+xini),", ");
end;
cmd=strcat(cmd, "\"",num2str(xtics(length(xtics))),"\" ", num2str(xsc*(length(xtics)-1)+xini),");\n");
__gnuplot_raw__(cmd);
__gnuplot_raw__("set xtics axis;\n");


cmd="set ytics (";
for s=1:length(ytics)-1,
   cmd=strcat(cmd, "\"",num2str(ytics(s)),"\" ", num2str(ysc*(s-1)+yini),", ");
end;
cmd=strcat(cmd, "\"",num2str(ytics(length(ytics))),"\" ", num2str(ysc*(length(ytics)-1)+yini),");\n");
__gnuplot_raw__(cmd);
__gnuplot_raw__("set xtics axis;\n");


% color map for the graphic (hot=21,22,23)
__gnuplot_raw__("set palette  rgbformulae 30,31,32;\n");

% write temp file with data matrix
save -ascii temp.dat aux;

% do the plotting
__gnuplot_raw__("splot 'temp.dat' matrix;\n");
