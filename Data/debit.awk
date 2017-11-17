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


             }
/ / {
      split($9, tab, ".");
      split($10, tab2, ".");
      if ( $3 == tab[1] && $8 == 1 && $1 == "+" && $5 == "tcp"  ) { t_debut_tcp1 = $2;}
      if ( $3 == tab[1] && $8 == 2 && $1 == "+" && $5 == "tcp"  ) { t_debut_tcp2 = $2;}

      if ( $3 == tab[1] && $8 == 1 && $1 == "+" && $5 == "tcp" ) {nombre_paquet_tcp1 = nombre_paquet_tcp1 +1;}
      if ( $3 == tab[1] && $8 == 2 && $1 == "+" && $5 ==  "tcp") {nombre_paquet_tcp2 = nombre_paquet_tcp2 +1;}

      if ( $4 == tab2[1] && $8 == 1 && $1 == "r" && $5 == "ack") {nombre_ack_tcp1 = nombre_ack_tcp1+1;}
      if ( $4 == tab2[1] && $8 == 2 && $1 == "r" && $5 == "ack") {nombre_ack_tcp2 = nombre_ack_tcp2+1;}

      if ($1 == "d" && $8 == 1  && $5 == "tcp") {nombre_paquet_perdus_tcp1 = nombre_paquet_perdus_tcp1 +1;}
      if ($1 == "d" && $8 == 2  && $5 == "tcp") {nombre_paquet_perdus_tcp2 = nombre_paquet_perdus_tcp2 +1;}

      if ($1 == "r" && $8 == 1 && tab2[1] == $4 && $5 == "tcp")
      { nombre_paquet_recus_tcp1 = nombre_paquet_recus_tcp1 +1; t_fin_tcp1 = $2;
        temps = t_fin_tcp1-t_debut_tcp1;
        debit = ((1040*1/1000)/temps);
        printf "%f %f\n",$2,debit ;
      }
      if ($1 == "r" && $8 == 2 && tab2[1] == $4 && $5 == "tcp")
      { nombre_paquet_recus_tcp2 = nombre_paquet_recus_tcp2 +1; t_fin_tcp2 = $2;}




}

END {


      }' $1 > ./Data/analyse/debit_tcp1_$filename.out
