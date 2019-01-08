%let name=bar2;

/* 
Set your current-working-directory (to read/write files), if you need to ...
%let rc=%sysfunc(dlgcdir('c:\someplace\public_html')); 
*/
filename odsout '.';

data my_data;
input CATEGORY SERIES $ 3-11 AMOUNT;
datalines;
1 Series A  5
2 Series A  7.8
1 Series B  9.5
2 Series B  5.9
;
run;


ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" 
 (title="SGplot Horizontal Grouped Bar (3D)") 
 style=htmlblue;

ods graphics / imagefmt=png imagename="&name" 
 width=800px height=600px noborder imagemap; 

title1 color=gray33 ls=0.5 h=23pt "Horizontal Grouped Bar";
title2 color=gray33 ls=0.5 h=17pt "With 3D Shading";

proc sgplot data=my_data noautolegend;
styleattrs datacolors=(cx9999ff cx993366);
hbar category / response=amount stat=sum 
 group=series groupdisplay=cluster grouporder=descending
 dataskin=sheen /* <--- basically, added this line! */
 outlineattrs=(color=black) nostatlabel;
xaxis 
 values=(0 to 10 by 2)
 labelattrs=(size=16pt weight=bold color=gray33) 
 valueattrs=(size=16pt weight=bold color=gray33) 
 offsetmax=0 grid minor minorcount=1;
yaxis 
 labelattrs=(size=16pt weight=bold color=gray33) 
 valueattrs=(size=16pt weight=bold color=gray33)
 display=(noticks);
run;

quit;
ODS HTML CLOSE;
ODS LISTING;
