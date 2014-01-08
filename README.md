##########################
# yum_check.pl script
##########################

INTRODUCTION
============
Perl script to run a yum list updates and email the contents to a defined email address

INSTALLATION
============
Copy the yum_updates.pl script to /usr/local/sbin or other preferred directory.

Add to your root user crontab a preferred interval.  We run ours every Monday so we have 
the following in crontab

* 2 * * 1 /usr/local/sbin/yum_check.pl > /dev/null 2>&1

CONFIGURATION
=============
Edit the script to define variables relevant to your installation.  At minimum you need to 
set the following variables:

my $domain = "domain.com";
my $to_addr = 'email@$domain';
my $from_addr = "$host\@$domain";

We check to make sure Yum isn't already running, If yum places it's pid file in a non 
standard location you may need to update the following variable:

my $pid = "/var/run/yum.pid";