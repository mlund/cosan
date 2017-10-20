#!/usr/bin/perl -w

use Math::Trig;

$phi;
$x1;
$y1;
$z1;
$tot1;
$x2;
$y2;
$z2;
$tot2;

open (OUT, "> ang.dat");
open (OUT2, ">conf.dat");
# loop g_dist command - measure distance in each frame, write to a file
for (my $i=0; $i<=100000; $i++) {
    if (-e "conf${i}.gro"){
	print "Processing configuration $i...\n";
	system("gmx gangle -f conf${i}.gro -s ../topol.tpr -oall -n -g1 vector -g2 vector -group1 3 -group2 4 -binw 10");
	open (IN, "< angles.xvg");
	my(@lines)=<IN>;
	my($line);
	my(@words);
	my($word);
	foreach $line (@lines){
	    if ($line =~ /[#@]/) {}
	    else {
		chomp $line; 
		$line =~ s/\s/:/g;
		@words = split(/:/,$line);
		@words = grep /\S/, @words;
		$phi = $words[1];
	    }
	}
	close(IN);
	
	system("rm angles.xvg");

        open(dip1,"| gmx dipoles -f conf${i}.gro -n -s ../topol.tpr");
	print dip1 "5\n";
	close (dip1);
	
	open (IN, "< Mtot.xvg");
	my(@lines)=<IN>;
	my($line);
	my(@words);
	my($word);
	foreach $line (@lines){
	    if ($line =~ /[#@]/) {}
	    else {
		chomp $line; 
		$line =~ s/\s/:/g;
		@words = split(/:/,$line);
		@words = grep /\S/, @words;
		$x1 = $words[1];
		$y1 = $words[2];
		$z1 = $words[3];
		$tot1 = $words[4];
	    }
	}
	close(IN);
	
	system("rm Mtot.xvg epsilon.xvg aver.xvg dipdist.xvg");

	open(dip2,"| gmx dipoles -f conf${i}.gro -n -s ../topol.tpr");
	print dip2 "6\n";
	close (dip2);
	
	open (IN, "< Mtot.xvg");
	my(@lines)=<IN>;
	my($line);
	my(@words);
	my($word);
	foreach $line (@lines){
	    if ($line =~ /[#@]/) {}
	    else {
		chomp $line; 
		$line =~ s/\s/:/g;
		@words = split(/:/,$line);
		@words = grep /\S/, @words;
		$x2 = $words[1];
		$y2 = $words[2];
		$z2 = $words[3];
		$tot2 = $words[4];
	    }
	}
	close(IN);

	system("rm Mtot.xvg epsilon.xvg aver.xvg dipdist.xvg");
	
	$rad=acos(($x1*$x2 + $y1*$y2 + $z1*$z2)/($tot1*$tot2));
 	$angle = rad2deg($rad);
	if($phi > 90){
	    $phi = 180 - $phi;
	}
	
	if($phi > 89 && $phi < 91 && $angle > 89 && $angle < 91){
	    print OUT2 "conf${i}.gro\n";
	}
	print OUT "$phi \t $angle \t conf${i}.gro\n";
	
    }
}
