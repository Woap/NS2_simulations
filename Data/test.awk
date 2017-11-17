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
      if ( $3 == tab[1] && $8 == 1 && $1 == "+" && $5 == "tcp" && t_debut_tcp1 == -1 ) { t_debut_tcp1 = $2;}
      if ( $3 == tab[1] && $8 == 2 && $1 == "+" && $5 == "tcp" && t_debut_tcp2 == -1 ) { t_debut_tcp2 = $2;}

      if ( $3 == tab[1] && $8 == 1 && $1 == "+" && $5 == "tcp" ) {nombre_paquet_tcp1 = nombre_paquet_tcp1 +1;}
      if ( $3 == tab[1] && $8 == 2 && $1 == "+" && $5 ==  "tcp") {nombre_paquet_tcp2 = nombre_paquet_tcp2 +1;}

      if ( $4 == tab2[1] && $8 == 1 && $1 == "r" && $5 == "ack") {nombre_ack_tcp1 = nombre_ack_tcp1+1;}
      if ( $4 == tab2[1] && $8 == 2 && $1 == "r" && $5 == "ack") {nombre_ack_tcp2 = nombre_ack_tcp2+1;}

      if ($1 == "d" && $8 == 1  && $5 == "tcp") {nombre_paquet_perdus_tcp1 = nombre_paquet_perdus_tcp1 +1;}
      if ($1 == "d" && $8 == 2  && $5 == "tcp") {nombre_paquet_perdus_tcp2 = nombre_paquet_perdus_tcp2 +1;}

      if ($1 == "r" && $8 == 1 && tab2[1] == $4 && $5 == "tcp")
      { nombre_paquet_recus_tcp1 = nombre_paquet_recus_tcp1 +1; t_fin_tcp1 = $2;}
      if ($1 == "r" && $8 == 2 && tab2[1] == $4 && $5 == "tcp")
      { nombre_paquet_recus_tcp2 = nombre_paquet_recus_tcp2 +1; t_fin_tcp2 = $2;}




}

END { print "FILE Complete \n";
      print "Nombre paquet envoyés par les flux de tcp1 : ";
      print nombre_paquet_tcp1 ;
      print "Nombre paquet perdus par les flux de tcp1 : ";
      print nombre_paquet_perdus_tcp1 ;
      print "Nombre paquet recus pour les flux de tcp1 : ";
      print nombre_paquet_recus_tcp1;
      print "Nombre ack recus pour les flux de tcp1 : ";
      print nombre_ack_tcp1;
      print "Durée du flux tcp1 : ";
      temps = t_fin_tcp1-t_debut_tcp1;
      print temps;
      debit = ((1040*nombre_paquet_tcp1/1000)/temps);
      print "Débit Mb/s: ";
      print debit;
      print " ";

      print "Nombre paquet envoyés par les flux de tcp2 : ";
      print nombre_paquet_tcp2 ;
      print "Nombre paquet perdus par les flux de tcp2 : ";
      print nombre_paquet_perdus_tcp2 ;
      print "Nombre paquet recus pour les flux de tcp2 : ";
      print nombre_paquet_recus_tcp2;
      print "Nombre ack recus pour les flux de tcp2 : ";
      print nombre_ack_tcp2;
      print "Durée du flux tcp2 : ";
      temps = t_fin_tcp2-t_debut_tcp2;
      print temps;
      debit = ((1040*nombre_paquet_tcp2/1000)/temps);
      print "Débit Mb/s: ";
      print debit;



      }' $1 > ./Data/analyse/data_$filename.txt

      echo "Generation données $filename"
