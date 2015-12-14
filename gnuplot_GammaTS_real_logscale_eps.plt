#set fontpath "/usr/share/fonts/type1/t1-tudfonts/frontpage"
set fontpath "/Users/janvincentlatzko/Library/texmf/fonts/type1/softmake/frontpage"
#set terminal postscript enhanced eps monochrome dashed fontfile "5fpr8a.pfb" font "FrontPage, 18"
set terminal postscript enhanced eps color dashed fontfile "5fpr8a.pfb" font "FrontPage, 18"


set samples 1000
set xlabel 'Frequency / MHz'
set ylabel '{/Symbol a}} / m^{-1}'
set key on
set key right bottom
#set yrange [50:55 ]
#set xtics 20
#set ytics 1
set logscale xy
set format y "10^{%L}"

set output "G_Re_T_S_log.eps"

#set style line 1 lt 1 lc 3 lw 2 pt 7 ps 0.5
#set style line 2 lt 1 lc 2 lw 2 pt 7 ps 0.8

set datafile separator ","
plot "./Gamma_Schelkunoff.csv" u 1:2 w lp ls 2 lc "#E6001A" title "Attenuation constant {/Symbol a} from Schelkunoff", "./Gamma_Tesche_MHz.csv" u 1:2 w lines ls 1 lc 2 title "Attenuation constant {/Symbol a} from Tesche model"