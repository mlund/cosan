@cosanH2 = ('69','70', '71', '73', '74', '75', '76', '78', '79', '81', '82', '83', '84', '85', '86', '88', '77', '90');
@cosanH1 = ('24','25', '26', '28', '29', '30', '31', '33', '34', '36', '37', '38', '39', '40', '41', '43', '32', '45');
@cosanC1 =('42', '27', '44', '35');
@cosanC2 =('80', '89', '87', '72');
@dist;

open (OUT, ">test.dat");
open (OUT2, ">test2.dat");
open (OUT3, ">bonds.dat");
open (OUT4, ">final.dat");
$N=0;
$Frames=0;

for (my $i=0; $i<=100000; $i++) {
    $Bonds=0;
    if (-e "conf${i}.gro"){
	$Frames++;
	foreach $C1(@cosanC1){
	    open(dis, " | gmx distance -f conf${i}.gro -n -s ../topol.tpr -oall");

	    foreach $H2(@cosanH2){
		print dis "atomnr $C1 $H2\n"; 
	    }
	
	    close(dis); 
    

	    open(IN, "<dist.xvg");
	    my @array = <IN>;
	    
	    my $distance;
	    
	    foreach $_ (@array) {
		if ($_ =~ /[#@]/) {
		    # do nothing, it's a comment or formatting line
		} else {
		    my @line = split(" ", $_);
		    @dist = @line;
		}
	    }
	    
	    close(IN);
	    system("rm dist.xvg");
	    
	    for($j=1;$j<19;$j++){
		if($dist[$j] < 0.3){
		print OUT "$C1 \t $cosanH2[$j-1] \t $dist[$j]  conf${i}.gro\n";
		$N++;
		$Bonds++;
		}
	    }
	}
	foreach $C2(@cosanC2){
	    open(dis, " | gmx distance -f conf${i}.gro -n -s ../topol.tpr -oall");
	    
	    foreach $H1(@cosanH1){
		print dis "atomnr $C2 $H1\n"; 
	    }
	    
	    close(dis); 
	    
	    
	    open(IN, "<dist.xvg");
	    my @array = <IN>;
	    
	    my $distance;
	    
	    foreach $_ (@array) {
		if ($_ =~ /[#@]/) {
		    # do nothing, it's a comment or formatting line
		} else {
		    my @line = split(" ", $_);
		    @dist = @line;
		}
	    }
	    
	    close(IN);
	    system("rm dist.xvg");
	    
	    for($j=1;$j<19;$j++){
		if($dist[$j] < 0.3){
		print OUT2 "$C2 \t $cosanH1[$j-1] \t $dist[$j]  conf${i}.gro\n";
		$N++;
		$Bonds++;
		}
	    }
	}
	print OUT3 "$Bonds\n";
    }
   
}
$proc=$N/$Frames;
print OUT4 "Number of Bonds $N\n Number of frames $Frames\n Procent $proc\n";
