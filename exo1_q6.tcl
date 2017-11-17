#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 0 Blue
$ns color 1 Red
$ns color 2 Green
$ns color 3 Yellow

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

set f [open out.tr w]
$ns trace-all $f

#Define a 'finish' procedure
proc finish {} {
        global ns f nf stat
        puts "C'est fini"
        $ns flush-trace
        #Close the NAM trace file
        close $nf
        #Execute NAM on the trace file
        exec nam -a out.nam &
        close $f          
        exit 0
}

#Create 104 nodes

for {set i 0} {$i < 104} {incr i} {
    set n($i) [$ns node]
}


#Create links between the nodes

for {set i 0} {$i < 25} {incr i} {
    $ns duplex-link $n($i) $n(100) 2Mb 10ms DropTail
}

for {set i 25} {$i < 50} {incr i} {
    $ns duplex-link $n($i) $n(101) 2Mb 10ms DropTail
}

for {set i 50} {$i < 75} {incr i} {
    $ns duplex-link $n($i) $n(102) 2Mb 10ms DropTail
}

for {set i 75} {$i < 100} {incr i} {
    $ns duplex-link $n($i) $n(103) 2Mb 10ms DropTail
}

for {set i 0 } {$i < 4} {incr i} {
    for {set j [expr {$i +1}] } {$j < 4} {incr j} {
    $ns duplex-link $n(10$i) $n(10$j) 2Mb 10ms DropTail
    }
}


#Set Queue Size of link (n2-n3) to 10
#$ns queue-limit $n2 $n3 10

#Give node position (for NAM)
#$ns duplex-link-op $n0 $n2 orient right-down
#$ns duplex-link-op $n1 $n2 orient right-up
#$ns duplex-link-op $n2 $n3 orient right

#Monitor the queue for link (n2-n3). (for NAM)
#$ns duplex-link-op $n2 $n3 queuePos 0.5


#Setup a UDP connection

for {set i 0} {$i < 25} {incr i} {
  for {set j 0} {$j < 3} {incr j} {

    set udp($i.$j) [new Agent/UDP]
    $udp($i.$j) set class_ 0
    $ns attach-agent $n($i) $udp($i.$j)
    $udp($i.$j) set fid_ 1
    }

    set recep($i) [new Agent/Null]
    $ns attach-agent $n($i) $recep($i)
}

for {set i 25} {$i < 50} {incr i} {
for {set j 0} {$j < 3} {incr j} {

  set udp($i.$j) [new Agent/UDP]
  $udp($i.$j) set class_ 1
  $ns attach-agent $n($i) $udp($i.$j)
  $udp($i.$j) set fid_ 2
  }

    set recep($i) [new Agent/Null]
    $ns attach-agent $n($i) $recep($i)
}

for {set i 50} {$i < 75} {incr i} {

for {set j 0} {$j < 3} {incr j} {

  set udp($i.$j) [new Agent/UDP]
  $udp($i.$j) set class_ 2
  $ns attach-agent $n($i) $udp($i.$j)
  $udp($i.$j) set fid_ 3
  }

    set recep($i) [new Agent/Null]
    $ns attach-agent $n($i) $recep($i)
}

for {set i 75} {$i < 100} {incr i} {
    for {set j 0} {$j < 3} {incr j} {
        set udp($i.$j) [new Agent/UDP]
        $udp($i.$j) set class_ 3
        $ns attach-agent $n($i) $udp($i.$j)
        $udp($i.$j) set fid_ 4
    }

    set recep($i) [new Agent/Null]
    $ns attach-agent $n($i) $recep($i)
}



# Connect

for {set i 0} {$i < 25} {incr i} {
    set k [expr { (($i+25) % 100 ) } ]
    for {set j 0} {$j < 3} {incr j} {
        $ns connect $udp($i.$j) $recep($k)
        set k [expr {(($k+25) % 100 ) } ]
    }
}


for {set i 25} {$i < 50} {incr i} {
    set k [expr { (($i+25) % 100 ) } ]
    for {set j 0} {$j < 3} {incr j} {
        $ns connect $udp($i.$j) $recep($k)
        set k [expr {(($k+25) % 100 ) } ]
    }


}

for {set i 50} {$i < 75} {incr i} {
    set k [expr { (($i+25) % 100 ) } ]
    for {set j 0} {$j < 3} {incr j} {
        $ns connect $udp($i.$j) $recep($k)
        set k [expr {(($k+25) % 100 ) } ]
    }

}

for {set i 75} {$i < 100} {incr i} {
    set k [expr { (($i+25) % 100 ) } ]
    for {set j 0} {$j < 3} {incr j} {
        $ns connect $udp($i.$j) $recep($k)
        set k [expr {(($k+25) % 100 ) } ]
    }


}


# Application

for {set i 0} {$i < 100} {incr i} {
    for {set j 0} {$j < 3} {incr j} {
        set app($i.$j) [new Application/Traffic/CBR]
        $app($i.$j) set type_ CBR
        $app($i.$j) set packet_size_ 1000
        $app($i.$j) set rate_ 1mb
        $app($i.$j) attach-agent $udp($i.$j)
    }
}



#Schedule events for the CBR and FTP agents

for {set i 0} {$i < 100} {incr i} {
    for {set j 0} {$j < 3} {incr j} {
        $ns at 1.0 "$app($i.$j) start"
        $ns at 5.0 "$app($i.$j) stop"
    }
}



#Call the finish procedure after 5 seconds of simulation time
$ns at 10.0 "finish"


#Run the simulation
$ns run
