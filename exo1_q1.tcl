proc finish { } {
  global ns f nf stat
  puts "C'est fini"
  close $f                        # fermeture du fichier de trace (s'il y a)
  close $nf                       # fermeture du fichier de trace animation
  puts "Débit = $stat(debit)"     # impression d'une statistique
}

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
        global ns nf
        $ns flush-trace
        #Close the NAM trace file
        close $nf
        #Execute NAM on the trace file
        exec nam -a out.nam &
        exit 0
}

#Create seven nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]


#Create links between the nodes
$ns duplex-link $n0 $n4 2Mb 10ms DropTail
$ns duplex-link $n1 $n4 2Mb 10ms DropTail
$ns duplex-link $n2 $n4 2Mb 10ms DropTail
$ns duplex-link $n3 $n4 2Mb 10ms DropTail
$ns duplex-link $n4 $n5 2Mb 10ms DropTail
$ns duplex-link $n4 $n6 2Mb 10ms DropTail

#Set Queue Size of link (n2-n3) to 10
#$ns queue-limit $n2 $n3 10

#Give node position (for NAM)
#$ns duplex-link-op $n0 $n2 orient right-down
#$ns duplex-link-op $n1 $n2 orient right-up
#$ns duplex-link-op $n2 $n3 orient right

#Monitor the queue for link (n2-n3). (for NAM)
#$ns duplex-link-op $n2 $n3 queuePos 0.5


#Setup a UDP connection
set udp [new Agent/UDP]
$udp set class_ 0
$ns attach-agent $n0 $udp
$udp set fid_ 1

set udp1 [new Agent/UDP]
$udp1 set class_ 1
$ns attach-agent $n1 $udp1
$udp set fid_ 2

set udp2 [new Agent/UDP]
$udp2 set class_ 2
$ns attach-agent $n2 $udp2
$udp set fid_ 3

set udp3 [new Agent/UDP]
$udp3 set class_ 3
$ns attach-agent $n3 $udp3
$udp set fid_ 4

set recep5 [new Agent/Null]
$ns attach-agent $n5 $recep5

set recep6 [new Agent/Null]
$ns attach-agent $n6 $recep6

$ns connect $udp $recep5
$ns connect $udp1 $recep5
$ns connect $udp2 $recep6
$ns connect $udp3 $recep6
$ns connect $recep5 $recep6
$ns connect $recep6 $recep5

set app [new Application/Traffic/CBR]
$app set type_ CBR
$app set packet_size_ 1000
$app set rate_ 1mb
$app attach-agent $udp

set app2 [new Application/Traffic/CBR]
$app2 set type_ CBR
$app2 set packet_size_ 1000
$app2 set rate_ 1mb
$app2 attach-agent $udp1

set app3 [new Application/Traffic/CBR]
$app3 set type_ CBR
$app3 set packet_size_ 1000
$app3 set rate_ 1mb
$app3 attach-agent $udp2

set app4 [new Application/Traffic/CBR]
$app4 set type_ CBR
$app4 set packet_size_ 1000
$app4 set rate_ 1mb
$app4 attach-agent $udp3


#Schedule events for the CBR and FTP agents
$ns at 1.0 "$app start"
$ns at 5.0 "$app stop"

$ns at 1.0 "$app2 start"
$ns at 5.0 "$app2 stop"

$ns at 1.0 "$app3 start"
$ns at 5.0 "$app3 stop"

$ns at 1.0 "$app4 start"
$ns at 5.0 "$app4 stop"


#Call the finish procedure after 5 seconds of simulation time
$ns at 10.0 "finish"

#Print CBR packet size and interval
puts "APP packet size = [$app set packet_size_]"
puts "APP interval = [$app set interval_]"

puts "APP2 packet size = [$app2 set packet_size_]"
puts "APP2 interval = [$app2 set interval_]"

puts "APP3 packet size = [$app3 set packet_size_]"
puts "APP3 interval = [$app3 set interval_]"

puts "APP4 packet size = [$app4 set packet_size_]"
puts "APP4 interval = [$app4 set interval_]"

#Run the simulation
$ns run
