#set fontpath "/usr/share/fonts/type1/t1-tudfonts/frontpage"
set fontpath "/Users/janvincentlatzko/Library/texmf/fonts/type1/softmake/frontpage"
#set terminal postscript enhanced eps monochrome dashed fontfile "5fpr8a.pfb" font "FrontPage, 18"
set terminal postscript enhanced eps color dashed fontfile "5fpr8a.pfb" font "FrontPage, 18"


set samples 1000
set xlabel 'Frequency / MHz'
set ylabel '{/Symbol D}{/Symbol b}}/{/Symbol b}'
set key on
#set key right bottom
#set yrange [0:3.1e8]
#set xtics 20
#set ytics 1

set logscale xy
set format y "10^{%L}"

set output "Dev_Beta_loglog.eps"

#set style line 1 lt 1 lc 3 lw 2 pt 7 ps 0.5
#set style line 2 lt 1 lc 2 lw 2 pt 7 ps 0.8

set datafile separator ","
plot "./Gamma_Deviation_MHz.csv" u 1:3 w lines ls 1 lc "#E6001A" title "Deviation {/Symbol b}_{CST} from analytical {/Symbol b}"