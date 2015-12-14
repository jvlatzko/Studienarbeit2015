#set fontpath "/usr/share/fonts/type1/t1-tudfonts/frontpage"
set fontpath "/Users/janvincentlatzko/Library/texmf/fonts/type1/softmake/frontpage"
#set terminal postscript enhanced eps monochrome dashed fontfile "5fpr8a.pfb" font "FrontPage, 18"
set terminal postscript enhanced eps color dashed fontfile "5fpr8a.pfb" font "FrontPage, 18"


set samples 1000
set xlabel 'Frequency / MHz'
set ylabel 'Real part of Z_c / {/Symbol W}'
set key on
set key right top
#set key box #looks like crap with Z_c penetrating the box :-/ 
set yrange [50:58]
#set xtics 20
#set ytics 1

set output "Zc_Re_T_S.eps"

#set style line 1 lt 1 lc 3 lw 2 pt 7 ps 0.5
#set style line 2 lt 1 lc 2 lw 2 pt 7 ps 0.8

set datafile separator ","
plot "./Zc_Schelkunoff.csv" u 1:2 w lp ls 1 lc "#E6001A" title "Real part of Z_c from Schelkunoff model", "./Zc_Tesche_MHz.csv" u 1:2 w lines ls 1 lc 2 title "Real part of Z_c from Tesche model"