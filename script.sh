#Script permettant de générer les données en lancant les simulations

ns exo2_q1.tcl TCP TCP/Reno Data/tahoe_reno
#ns exo2_q1.tcl TCP TCP/Newreno Data/tahoe_newreno
#ns exo2_q1.tcl TCP TCP/Sack1 Data/tahoe_sack
#ns exo2_q1.tcl TCP/Newreno TCP/Sack1 Data/sack_newreno
#ns exo2_q1.tcl TCP/Vegas TCP/Sack1 Data/vegas_sack
ns exo2_q1.tcl TCP/Vegas TCP/Reno Data/vegas_reno
ns exo2_q1.tcl TCP/Vegas TCP Data/vegas_tahoe

mv Data/*.nam Data/nam
mv Data/*.tr Data/tr


for filename in Data/tr/*.tr; do
    ./Data/test.awk $filename
    ./Data/lien_tcpv1.awk $filename
    ./Data/lien_tcpv2.awk $filename
    ./Data/file.awk $filename
    ./Data/file2.awk $filename
    ./Data/file3.awk $filename
    ./Data/debit.awk $filename
    ./Data/debit2.awk $filename
done


gnuplot ./Data/plot.plt

rm ./Data/analyse/*.xg
rm ./Data/analyse/*.out
