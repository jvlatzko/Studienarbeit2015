#set fontpath "/usr/share/fonts/type1/t1-tudfonts/frontpage"
set fontpath "/Users/janvincentlatzko/Library/texmf/fonts/type1/softmake/frontpage"
#set terminal postscript enhanced eps monochrome dashed fontfile "5fpr8a.pfb" font "FrontPage, 18"
set terminal postscript enhanced eps color dashed fontfile "5fpr8a.pfb" font "FrontPage, 18"


set samples 1000
set xlabel 'Frequency / MHz'
set ylabel '{/Symbol w}/{/Symbol b}} = v_p_h'
set key on
set key right bottom
#set xrange [-20:20]
set yrange [0:3.1e8]
#set xtics 20
#set ytics 1
set logscale x

set output "Phasespeed_final_log.eps"

set datafile separator ","
plot "./Omega_over_beta_MHz.csv" u 1:2 w lines ls 1 lc "#E6001A" title "{/Symbol w} / {/Symbol b} from CST", "./Omega_over_beta_MHz.csv" u 1:3 w lines ls 1 lc 2 title "{/Symbol w} / {/Symbol b}  from Tesche model", "./Omega_over_beta_MHz.csv" u 1:4 w lines ls 1 lc 3 title "Speed of light in vacuum"