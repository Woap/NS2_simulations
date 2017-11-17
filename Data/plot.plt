set term png
set output 'Data/analyse/tahoe_reno_cwnd.png'
set xlabel "temps (secondes)"
set ylabel "cwnd"
plot '< paste Data/analyse/congestion0TCP.Reno.TCP.xg Data/analyse/congestion1TCP.Reno.TCP.xg Data/analyse/congestion2TCP.Reno.TCP.xg' using 1:(($2+$4+$6)/3) title "cwnd Reno" w lp, \
'< paste Data/analyse/congestion0TCP.TCP.Reno.xg Data/analyse/congestion1TCP.TCP.Reno.xg Data/analyse/congestion2TCP.TCP.Reno.xg' using 1:(($2+$4+$6)/3) title "cwnd Tahoe" w lp, \


set term png
set output 'Data/analyse/vegas_reno_cwnd.png'
set xlabel "temps (secondes)"
set ylabel "cwnd"
plot '< paste Data/analyse/congestion0TCP.Reno.TCP.Vegas.xg Data/analyse/congestion1TCP.Reno.TCP.Vegas.xg Data/analyse/congestion2TCP.Reno.TCP.Vegas.xg' using 1:(($2+$4+$6)/3) title "cwnd Reno" w lp, \
'< paste Data/analyse/congestion0TCP.Vegas.TCP.Reno.xg Data/analyse/congestion1TCP.Vegas.TCP.Reno.xg Data/analyse/congestion2TCP.Vegas.TCP.Reno.xg' using 1:(($2+$4+$6)/3) title "cwnd Vegas" w lp, \

set term png
set output 'Data/analyse/vegas_tahoe_cwnd.png'
set xlabel "temps (secondes)"
set ylabel "cwnd"
plot '< paste Data/analyse/congestion0TCP.TCP.Vegas.xg Data/analyse/congestion1TCP.TCP.Vegas.xg Data/analyse/congestion2TCP.TCP.Vegas.xg' using 1:(($2+$4+$6)/3) title "cwnd Tahoe" w lp, \
'< paste Data/analyse/congestion0TCP.Vegas.TCP.xg Data/analyse/congestion1TCP.Vegas.TCP.xg Data/analyse/congestion2TCP.Vegas.TCP.xg' using 1:(($2+$4+$6)/3) title "cwnd Vegas" w lp, \


set term png
set output 'Data/analyse/file_noeudcentral_vegas_tahoe.png'
set xlabel "temps (secondes)"
set ylabel "nombre de paquets"
plot 'Data/analyse/file1_noeudcentral_vegas_tahoe.out' using 1:2 every 5 w l title 'file1' linecolor 2, \
'Data/analyse/file2_noeudcentral_vegas_tahoe.out' using 1:2 every 5 w l title 'file2' linecolor 3, \
'Data/analyse/file3_noeudcentral_vegas_tahoe.out' using 1:2 every 5 w l title 'file3' linecolor 4, \

set term png
set output 'Data/analyse/lien_noeudcentral_vegas_tahoe.png'
set xlabel "temps (secondes)"
set ylabel "nombre de paquets"
plot 'Data/analyse/lien_noeudcentral_tcpv1_vegas_tahoe.out' using 1:2 every 5 w l title 'lien central' linecolor 2, \
'Data/analyse/lien_noeudcentral_tcpv2_vegas_tahoe.out' using 1:2 every 5 w l title 'lien central' linecolor 4, \


set term png
set output 'Data/analyse/debit_tcp_vegas_tahoe.png'
set xlabel "temps (secondes)"
set ylabel "Débits Mb/s"
plot 'Data/analyse/debit_tcp1_vegas_tahoe.out' using 1:2 every 5 w l title 'lien central' linecolor 2, \
'Data/analyse/debit_tcp2_vegas_tahoe.out' using 1:2 every 5 w l title 'lien central' linecolor 4, \




set term png
set output 'Data/analyse/file_noeudcentral_vegas_reno.png'
set xlabel "temps (secondes)"
set ylabel "nombre de paquets"
plot 'Data/analyse/file1_noeudcentral_vegas_reno.out' using 1:2 every 5 w l title 'file1' linecolor 2, \
'Data/analyse/file2_noeudcentral_vegas_reno.out' using 1:2 every 5 w l title 'file2' linecolor 3, \
'Data/analyse/file3_noeudcentral_vegas_reno.out' using 1:2 every 5 w l title 'file3' linecolor 4, \

set term png
set output 'Data/analyse/lien_noeudcentral_vegas_reno.png'
set xlabel "temps (secondes)"
set ylabel "nombre de paquets"
plot 'Data/analyse/lien_noeudcentral_tcpv1_vegas_reno.out' using 1:2 every 5 w l title 'lien central' linecolor 2, \
'Data/analyse/lien_noeudcentral_tcpv2_vegas_reno.out' using 1:2 every 5 w l title 'lien central' linecolor 4, \

set term png
set output 'Data/analyse/debit_tcp_vegas_reno.png'
set xlabel "temps (secondes)"
set ylabel "Débits Mb/s"
plot 'Data/analyse/debit_tcp1_vegas_reno.out' using 1:2 every 5 w l title 'lien central' linecolor 2, \
'Data/analyse/debit_tcp2_vegas_reno.out' using 1:2 every 5 w l title 'lien central' linecolor 4, \


set term png
set output 'Data/analyse/file_noeudcentral_tahoe_reno.png'
set xlabel "temps (secondes)"
set ylabel "nombre de paquets"
plot 'Data/analyse/file1_noeudcentral_tahoe_reno.out' using 1:2 every 5 w l title 'file1' linecolor 2, \
'Data/analyse/file2_noeudcentral_tahoe_reno.out' using 1:2 every 5 w l title 'file2' linecolor 3, \
'Data/analyse/file3_noeudcentral_tahoe_reno.out' using 1:2 every 5 w l title 'file3' linecolor 4, \

set term png
set output 'Data/analyse/lien_noeudcentral_tahoe_reno.png'
set xlabel "temps (secondes)"
set ylabel "nombre de paquets"
plot 'Data/analyse/lien_noeudcentral_tcpv1_tahoe_reno.out' using 1:2 every 5 w l title 'lien central' linecolor 2, \
'Data/analyse/lien_noeudcentral_tcpv2_tahoe_reno.out' using 1:2 every 5 w l title 'lien central' linecolor 4, \

set term png
set output 'Data/analyse/debit_tcp_tahoe_reno.png'
set xlabel "temps (secondes)"
set ylabel "Débits Mb/s"
plot 'Data/analyse/debit_tcp1_tahoe_reno.out' using 1:2 every 5 w l title 'lien central' linecolor 2, \
'Data/analyse/debit_tcp2_tahoe_reno.out' using 1:2 every 5 w l title 'lien central' linecolor 4, \
