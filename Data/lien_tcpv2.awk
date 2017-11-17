filename=$(echo $1 | sed -e 's/Data\/tr\/\(.*\).tr/\1/')
awk 'BEGIN { "Debut analyse \n";
             nombre_paquet_tcp1 = 0;
             nombre_paquet_tcp2 = 0;

             nombre_paquet_perdus_tcp1 = 0;
             nombre_paquet_perdus_tcp2 = 0;

             nombre_ack_tcp1 = 0;
             nombre_ack_tcp2 = 0;

             nombre_paquet_recus_tcp1 = 0;
             nombre_paquet_recus_tcp2 = 0;

             t_debut_tcp1=-1;
             t_fin_tcp1=-1;

             t_debut_tcp2=0;
             t_fin_tcp2=0;

             nb_paquet_lien=0;


             }
/ / {
      split($9, tab, ".");
      split($10, tab2, ".");
      if ( $4 == 0 && $1 == "-" && $5 == "tcp" && $8 == 2) {
      nb_paquet_lien = nb_paquet_lien + 1;
      printf "%f %d\n",$2,nb_paquet_lien ;}

      if ( $4 == 0 && $1 == "r" && $5 == "tcp" && $8 == 2 ) {
      nb_paquet_lien = nb_paquet_lien - 1;
      printf "%f %d\n",$2,nb_paquet_lien ;}
      if ( $4 == 0 && $1 == "d" && $5 == "tcp" && $8 == 2) {
      nb_paquet_lien = nb_paquet_lien - 1;
      printf "%f %d\n",$2,nb_paquet_lien ;}


}

END { print "FILE Complete \n";
      }' $1 > ./Data/analyse/lien_noeudcentral_tcpv2_$filename.out
