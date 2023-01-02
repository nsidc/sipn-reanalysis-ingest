#! /bin/csh -f
#
# c-shell script to download selected files from rda.ucar.edu using Wget
# NOTE: if you want to run under a different shell, make sure you change
#       the 'set' commands according to your shell's syntax
# after you save the file, don't forget to make it executable
#   i.e. - "chmod 755 <name_of_script>"
#
# Experienced Wget Users: add additional command-line flags here
#   Use the -r (--recursive) option with care
#   Do NOT use the -b (--background) option - simultaneous file downloads
#       can cause your data access to be blocked
set opts = "-N"
#
# Replace xxxxxx with your rda.ucar.edu password on the next uncommented line
# IMPORTANT NOTE:  If your password uses a special character that has special
#                  meaning to csh, you should escape it with a backslash
#                  Example:  set passwd = "my\!password"
set passwd = 'xxxxxx'
set num_chars = `echo "$passwd" |awk '{print length($0)}'`
if ($num_chars == 0) then
  echo "You need to set your password before you can continue"
  echo "  see the documentation in the script"
  exit
endif
@ num = 1
set newpass = ""
while ($num <= $num_chars)
  set c = `echo "$passwd" |cut -b{$num}-{$num}`
  if ("$c" == "&") then
    set c = "%26";
  else
    if ("$c" == "?") then
      set c = "%3F"
    else
      if ("$c" == "=") then
        set c = "%3D"
      endif
    endif
  endif
  set newpass = "$newpass$c"
  @ num ++
end
set passwd = "$newpass"
#
set cert_opt = ""
# If you get a certificate verification error (version 1.10 or higher),
# uncomment the following line:
#set cert_opt = "--no-check-certificate"
#
if ("$passwd" == "xxxxxx") then
  echo "You need to set your password before you can continue - see the documentation in the script"
  exit
endif
#
# authenticate - NOTE: You should only execute this command ONE TIME.
# Executing this command for every data file you download may cause
# your download privileges to be suspended.
wget $cert_opt -O auth_status.rda.ucar.edu --save-cookies auth.rda.ucar.edu.$$ --post-data="email=matthew.j.fisher@colorado.edu&passwd=$passwd&action=login" https://rda.ucar.edu/cgi-bin/login
#
# download the file(s)
# NOTE:  if you get 403 Forbidden errors when downloading the data files, check
#        the contents of the file 'auth_status.rda.ucar.edu'
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790101-19790105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790101-19790105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790106-19790110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790106-19790110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790111-19790115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790111-19790115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790116-19790120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790116-19790120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790121-19790125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790121-19790125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790126-19790131.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790126-19790131.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790201-19790205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790201-19790205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790206-19790210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790206-19790210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790211-19790215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790211-19790215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790216-19790220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790216-19790220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790221-19790225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790221-19790225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790226-19790228.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790226-19790228.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790301-19790305.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790301-19790305.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790306-19790310.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790306-19790310.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790311-19790315.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790311-19790315.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790316-19790320.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790316-19790320.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790321-19790325.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790321-19790325.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790326-19790331.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790326-19790331.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790401-19790405.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790401-19790405.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790406-19790410.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790406-19790410.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790411-19790415.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790411-19790415.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790416-19790420.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790416-19790420.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790421-19790425.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790421-19790425.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790426-19790430.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790426-19790430.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790501-19790505.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790501-19790505.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790506-19790510.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790506-19790510.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790511-19790515.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790511-19790515.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790516-19790520.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790516-19790520.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790521-19790525.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790521-19790525.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790526-19790531.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790526-19790531.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790601-19790605.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790601-19790605.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790606-19790610.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790606-19790610.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790611-19790615.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790611-19790615.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790616-19790620.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790616-19790620.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790621-19790625.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790621-19790625.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790626-19790630.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790626-19790630.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790701-19790705.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790701-19790705.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790706-19790710.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790706-19790710.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790711-19790715.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790711-19790715.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790716-19790720.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790716-19790720.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790721-19790725.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790721-19790725.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790726-19790731.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790726-19790731.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790801-19790805.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790801-19790805.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790806-19790810.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790806-19790810.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790811-19790815.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790811-19790815.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790816-19790820.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790816-19790820.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790821-19790825.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790821-19790825.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790826-19790831.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790826-19790831.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790901-19790905.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790901-19790905.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790906-19790910.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790906-19790910.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790911-19790915.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790911-19790915.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790916-19790920.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790916-19790920.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790921-19790925.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790921-19790925.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19790926-19790930.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19790926-19790930.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791001-19791005.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791001-19791005.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791006-19791010.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791006-19791010.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791011-19791015.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791011-19791015.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791016-19791020.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791016-19791020.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791021-19791025.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791021-19791025.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791026-19791031.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791026-19791031.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791101-19791105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791101-19791105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791106-19791110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791106-19791110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791111-19791115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791111-19791115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791116-19791120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791116-19791120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791121-19791125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791121-19791125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791126-19791130.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791126-19791130.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791201-19791205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791201-19791205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791206-19791210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791206-19791210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791211-19791215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791211-19791215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791216-19791220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791216-19791220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791221-19791225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791221-19791225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbhnl.gdas.19791226-19791231.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1979/pgbh06.gdas.19791226-19791231.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800101-19800105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800101-19800105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800106-19800110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800106-19800110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800111-19800115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800111-19800115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800116-19800120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800116-19800120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800121-19800125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800121-19800125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800126-19800131.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800126-19800131.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800201-19800205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800201-19800205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800206-19800210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800206-19800210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800211-19800215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800211-19800215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800216-19800220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800216-19800220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800221-19800225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800221-19800225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800226-19800229.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800226-19800229.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800301-19800305.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800301-19800305.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800306-19800310.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800306-19800310.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800311-19800315.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800311-19800315.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800316-19800320.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800316-19800320.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800321-19800325.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800321-19800325.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800326-19800331.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800326-19800331.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800401-19800405.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800401-19800405.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800406-19800410.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800406-19800410.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800411-19800415.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800411-19800415.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800416-19800420.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800416-19800420.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800421-19800425.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800421-19800425.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800426-19800430.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800426-19800430.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800501-19800505.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800501-19800505.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800506-19800510.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800506-19800510.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800511-19800515.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800511-19800515.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800516-19800520.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800516-19800520.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800521-19800525.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800521-19800525.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800526-19800531.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800526-19800531.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800601-19800605.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800601-19800605.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800606-19800610.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800606-19800610.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800611-19800615.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800611-19800615.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800616-19800620.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800616-19800620.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800621-19800625.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800621-19800625.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800626-19800630.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800626-19800630.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800701-19800705.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800701-19800705.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800706-19800710.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800706-19800710.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800711-19800715.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800711-19800715.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800716-19800720.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800716-19800720.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800721-19800725.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800721-19800725.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800726-19800731.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800726-19800731.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800801-19800805.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800801-19800805.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800806-19800810.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800806-19800810.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800811-19800815.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800811-19800815.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800816-19800820.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800816-19800820.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800821-19800825.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800821-19800825.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800826-19800831.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800826-19800831.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800901-19800905.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800901-19800905.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800906-19800910.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800906-19800910.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800911-19800915.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800911-19800915.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800916-19800920.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800916-19800920.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800921-19800925.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800921-19800925.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19800926-19800930.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19800926-19800930.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801001-19801005.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801001-19801005.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801006-19801010.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801006-19801010.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801011-19801015.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801011-19801015.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801016-19801020.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801016-19801020.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801021-19801025.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801021-19801025.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801026-19801031.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801026-19801031.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801101-19801105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801101-19801105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801106-19801110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801106-19801110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801111-19801115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801111-19801115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801116-19801120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801116-19801120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801121-19801125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801121-19801125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801126-19801130.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801126-19801130.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801201-19801205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801201-19801205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801206-19801210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801206-19801210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801211-19801215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801211-19801215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801216-19801220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801216-19801220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801221-19801225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801221-19801225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbhnl.gdas.19801226-19801231.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1980/pgbh06.gdas.19801226-19801231.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810101-19810105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810101-19810105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810106-19810110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810106-19810110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810111-19810115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810111-19810115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810116-19810120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810116-19810120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810121-19810125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810121-19810125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810126-19810131.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810126-19810131.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810201-19810205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810201-19810205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810206-19810210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810206-19810210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810211-19810215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810211-19810215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810216-19810220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810216-19810220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810221-19810225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810221-19810225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810226-19810228.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810226-19810228.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810301-19810305.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810301-19810305.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810306-19810310.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810306-19810310.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810311-19810315.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810311-19810315.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810316-19810320.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810316-19810320.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810321-19810325.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810321-19810325.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810326-19810331.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810326-19810331.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810401-19810405.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810401-19810405.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810406-19810410.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810406-19810410.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810411-19810415.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810411-19810415.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810416-19810420.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810416-19810420.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810421-19810425.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810421-19810425.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810426-19810430.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810426-19810430.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810501-19810505.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810501-19810505.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810506-19810510.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810506-19810510.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810511-19810515.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810511-19810515.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810516-19810520.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810516-19810520.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810521-19810525.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810521-19810525.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810526-19810531.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810526-19810531.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810601-19810605.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810601-19810605.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810606-19810610.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810606-19810610.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810611-19810615.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810611-19810615.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810616-19810620.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810616-19810620.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810621-19810625.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810621-19810625.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810626-19810630.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810626-19810630.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810701-19810705.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810701-19810705.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810706-19810710.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810706-19810710.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810711-19810715.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810711-19810715.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810716-19810720.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810716-19810720.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810721-19810725.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810721-19810725.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810726-19810731.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810726-19810731.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810801-19810805.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810801-19810805.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810806-19810810.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810806-19810810.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810811-19810815.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810811-19810815.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810816-19810820.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810816-19810820.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810821-19810825.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810821-19810825.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810826-19810831.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810826-19810831.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810901-19810905.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810901-19810905.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810906-19810910.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810906-19810910.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810911-19810915.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810911-19810915.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810916-19810920.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810916-19810920.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810921-19810925.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810921-19810925.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19810926-19810930.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19810926-19810930.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811001-19811005.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811001-19811005.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811006-19811010.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811006-19811010.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811011-19811015.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811011-19811015.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811016-19811020.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811016-19811020.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811021-19811025.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811021-19811025.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811026-19811031.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811026-19811031.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811101-19811105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811101-19811105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811106-19811110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811106-19811110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811111-19811115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811111-19811115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811116-19811120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811116-19811120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811121-19811125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811121-19811125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811126-19811130.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811126-19811130.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811201-19811205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811201-19811205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811206-19811210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811206-19811210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811211-19811215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811211-19811215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811216-19811220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811216-19811220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811221-19811225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811221-19811225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbhnl.gdas.19811226-19811231.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1981/pgbh06.gdas.19811226-19811231.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820101-19820105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820101-19820105.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820106-19820110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820106-19820110.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820111-19820115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820111-19820115.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820116-19820120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820116-19820120.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820121-19820125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820121-19820125.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820126-19820131.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820126-19820131.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820201-19820205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820201-19820205.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820206-19820210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820206-19820210.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820211-19820215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820211-19820215.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820216-19820220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820216-19820220.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820221-19820225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820221-19820225.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820226-19820228.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820226-19820228.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820301-19820305.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820301-19820305.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820306-19820310.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820306-19820310.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820311-19820315.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820311-19820315.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820316-19820320.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820316-19820320.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820321-19820325.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820321-19820325.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820326-19820331.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820326-19820331.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820401-19820405.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820401-19820405.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820406-19820410.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820406-19820410.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820411-19820415.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820411-19820415.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820416-19820420.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820416-19820420.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820421-19820425.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820421-19820425.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820426-19820430.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820426-19820430.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820501-19820505.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820501-19820505.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820506-19820510.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820506-19820510.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820511-19820515.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820511-19820515.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820516-19820520.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820516-19820520.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820521-19820525.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820521-19820525.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820526-19820531.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820526-19820531.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820601-19820605.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820601-19820605.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820606-19820610.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820606-19820610.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820611-19820615.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820611-19820615.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbhnl.gdas.19820616-19820620.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.0/1982/pgbh06.gdas.19820616-19820620.tar
#
# clean up
rm auth.rda.ucar.edu.$$ auth_status.rda.ucar.edu
