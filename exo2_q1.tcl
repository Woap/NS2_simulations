#Create a simulator object
set ns [new Simulator]


#Define different colors for data flows (for NAM)
$ns color 1 Red
$ns color 2 Green


#Open the NAM trace file
set nf [open [lindex $argv 2].nam w]
$ns namtrace-all $nf

set f [open [lindex $argv 2].tr w]
$ns trace-all $f

set file [lindex $argv 2]

#Define a 'finish' procedure
proc finish {} {
        global ns f nf stat file
        puts "$file ok"
        $ns flush-trace
        #Close the NAM trace file
        close $nf
        #Execute NAM on the trace file
        #exec nam -a $file &
        close $f
        exit 0
}

#Create 8 nodes

set n(0) [$ns node]
set n(1) [$ns node]

for {set i 0} {$i < 2} {incr i} {
		for {set j 0} {$j < 3} {incr j} {
    		set n($i.$j) [$ns node]
    }
}

#Create links between the nodes

for {set i 0} {$i < 2} {incr i} {
		for {set j 0} {$j < 3} {incr j} {
    		$ns duplex-link $n($i.$j) $n($i) 100Mb 10ms DropTail
        $ns queue-limit $n($i.$j) $n($i) 50
    }
}

$ns duplex-link $n(0) $n(1) 1Mb 500ms DropTail
$ns queue-limit $n(0) $n(1) 50

#Setup a TCP connection

for {set j 0} {$j < 3} {incr j} {

				set tcp(0.$j.0) [new Agent/[lindex $argv 0]]
				set tcp(0.$j.1) [new Agent/[lindex $argv 1]]

				$tcp(0.$j.0) set fid_ 1
				$tcp(0.$j.1) set fid_ 2

				set sink(1.$j.0) [new Agent/TCPSink]
				set sink(1.$j.1) [new Agent/TCPSink]

				for {set k 0} {$k < 2} {incr k} {
						$ns attach-agent $n(0.$j) $tcp(0.$j.$k)
						$ns attach-agent $n(1.$j) $sink(1.$j.$k)
						$ns connect $tcp(0.$j.$k) $sink(1.$j.$k)
				}
}


# Application

for {set j 0} {$j < 3} {incr j} {
    for {set k 0} {$k < 2} {incr k} {

        set app(0.$j.$k) [new Application/Traffic/CBR]
        $app(0.$j.$k) set type_ CBR
        $app(0.$j.$k) set packet_size_ 1000
        $app(0.$j.$k) set rate_ 1mb
        $app(0.$j.$k) attach-agent $tcp(0.$j.$k)
    }
}



#Schedule events for the CBR and FTP agents

for {set j 0} {$j < 3} {incr j} {
    for {set k 0} {$k < 2} {incr k} {
        $ns at 1.0 "$app(0.$j.$k) start"
        $ns at 6.0 "$app(0.$j.$k) stop"
    }
}

proc plotWindow {tcpSource outfile} {
   global ns
   set now [$ns now]
   set cwnd [$tcpSource set cwnd_]

   puts  $outfile  "$now $cwnd"
   $ns at [expr $now+0.1] "plotWindow $tcpSource  $outfile"

}

set tcp_t1 [lindex $argv 0]
set tcp_t2 [lindex $argv 1]
set tcp_typeone [regsub "/" $tcp_t1 "."]
set tcp_typetwo [regsub "/" $tcp_t2 "."]

for {set j 0} {$j < 3} {incr j} {
        set outfile [open  "Data/analyse/congestion$j$tcp_typeone.$tcp_typetwo.xg"  w]
        $ns  at  0.0  "plotWindow $tcp(0.$j.0)  $outfile"
        set outfile [open  "Data/analyse/congestion$j$tcp_typetwo.$tcp_typeone.xg"  w]
        $ns  at  0.0  "plotWindow $tcp(0.$j.1)  $outfile"
}



#Call the finish procedure after 5 seconds of simulation time
$ns at 30.0 "finish"


#Run the simulation
$ns run
