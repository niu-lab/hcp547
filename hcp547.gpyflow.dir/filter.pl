#!/usr/bin/env perl
my $infile=@ARGV[0];
map{
    chomp;
    $line=$_;
    if(/^#/){
        print $line."\n";
    }; 
    $_=~/(.*)STATUS=(\w+);(.+)DP=(\d+)(.+)AF=([\d.]+);/; 
    if($2 eq "StrongLOH" || $2 eq "StrongSomatic" || $2 eq "LikelyLOH" || $2 eq "LikelySomatic" || $2 eq "AFDiff"){
        print $line."\n"
    }
}`cat $infile`