#!/usr/bin/perl
####################################################################################
# Run Yum Check-Update and email results to contact.
# 1/7/2014
# Version 1.1
# jchieppa@gmail.com
####################################################################################

use strict;
use warnings;
use Sys::Hostname;
use Mail::Sendmail;

# MUST BE RUN AS ROOT
my $login = (getpwuid $>);
die "Must run as root.  Exiting!\n" if $login ne 'root';

# DIE IF YUM ALREADY RUNNING
my $pid = "/var/run/yum.pid";
if (-e $pid) {
	die "Yum already running.  Exiting!\n";
 }
 
# SCRIPT VARIABLES
chomp (my $host = `hostname -s`);
my $domain = "domain.com";
my $to_addr = "email\@$domain";
my $from_addr = "$host\@$domain";
my $smtp = 'localhost';
my $port = '25';

my @updates = `yum list updates -q`;

if (@updates == 0) {
		exit;
		}
		else {
			my %mail = ( To      => $to_addr,
            From    => $from_addr,
            Subject => "Yum Available Updates for Host $host",
            Message => "The following updates are currently available for $host\.$domain\n\n@updates"
           );           
           $mail{server} = "$smtp:$port";           
           sendmail(%mail) or die $Mail::Sendmail::error;
    }     		
exit;