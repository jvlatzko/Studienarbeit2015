#set fontpath "/usr/share/fonts/type1/t1-tudfonts/frontpage"
set fontpath "/Users/janvincentlatzko/Library/texmf/fonts/type1/softmake/frontpage"
#set terminal postscript enhanced eps monochrome dashed fontfile "5fpr8a.pfb" font "FrontPage, 18"
set terminal postscript enhanced eps color dashed fontfile "5fpr8a.pfb" font "FrontPage, 18" dashed dashlength 1.0

set samples 10
set xlabel 'Frequency / MHz'
set ylabel '{/Symbol b}} / m^{-1}'
set key on
set key right bottom
#set xtics 20
#set ytics 1

set output "G_Im_CST_T_final.eps"

#set style line 1 lt 1 lc 3 lw 2 pt 7 ps 0.5
#set style line 2 lt 1 lc 2 lw 2 pt 7 ps 0.8
#set style line 4 lt 2 lc rgb "green" lw 1

set datafile separator ","
plot "./Gamma_Tesche_MHz.csv" u 1:3 w lines ls 1 lc 2 title "Phase constant {/Symbol b} from Tesche model", "./Gamma_CST_MHz.csv" u 1:3 w lines ls 1 lc "#E6001A" title "Phase constant {/Symbol b} from CST"