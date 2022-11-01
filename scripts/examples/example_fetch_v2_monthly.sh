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
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201101.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201101.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201101.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201101.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201102.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201102.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201102.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201102.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201103.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201103.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201103.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201103.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201104.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201104.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201104.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201104.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201105.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201105.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201105.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201105.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201106.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201106.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201106.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201106.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201107.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201107.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201107.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201107.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201108.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201108.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201108.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201108.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201109.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201109.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201109.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201109.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201110.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201110.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201110.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201110.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201111.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201111.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201111.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201111.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201112.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201112.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201112.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201112.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201201.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201201.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201201.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201201.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201202.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201202.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201202.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201202.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201203.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201203.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201203.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201203.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201204.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201204.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201204.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201204.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201205.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201205.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201205.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201205.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201206.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201206.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201206.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201206.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201207.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201207.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201207.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201207.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201208.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201208.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201208.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201208.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201209.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201209.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201209.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201209.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201210.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201210.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201210.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201210.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201211.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201211.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201211.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201211.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201212.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201212.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201212.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201212.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201301.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201301.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201301.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201301.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201302.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201302.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201302.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201302.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201303.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201303.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201303.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201303.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201304.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201304.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201304.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201304.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201305.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201305.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201305.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201305.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201306.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201306.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201306.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201306.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201307.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201307.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201307.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201307.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201308.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201308.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201308.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201308.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201309.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201309.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201309.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201309.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201310.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201310.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201310.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201310.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201311.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201311.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201311.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201311.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201312.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201312.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201312.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201312.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201401.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201401.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201401.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201401.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201402.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201402.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201402.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201402.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201403.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201403.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201403.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201403.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201404.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201404.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201404.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201404.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201405.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201405.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201405.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201405.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201406.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201406.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201406.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201406.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201407.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201407.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201407.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201407.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201408.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201408.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201408.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201408.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201409.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201409.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201409.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201409.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201410.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201410.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201410.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201410.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201411.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201411.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201411.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201411.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201412.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201412.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201412.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201412.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201501.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201501.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201501.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201501.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201502.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201502.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201502.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201502.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201503.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201503.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201503.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201503.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201504.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201504.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201504.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201504.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201505.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201505.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201505.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201505.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201506.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201506.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201506.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201506.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201507.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201507.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201507.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201507.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201508.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201508.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201508.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201508.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201509.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201509.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201509.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201509.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201510.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201510.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201510.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201510.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201511.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201511.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201511.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201511.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201512.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201512.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201512.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201512.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201601.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201601.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201601.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201601.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201602.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201602.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201602.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201602.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201603.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201603.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201603.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201603.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201604.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201604.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201604.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201604.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201605.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201605.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201605.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201605.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201606.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201606.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201606.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201606.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201607.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201607.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201607.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201607.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201608.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201608.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201608.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201608.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201609.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201609.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201609.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201609.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201610.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201610.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201610.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201610.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201611.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201611.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201611.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201611.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201612.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201612.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201612.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201612.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201701.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201701.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201701.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201701.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201702.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201702.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201702.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201702.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201703.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201703.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201703.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201703.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201704.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201704.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201704.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201704.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201705.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201705.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201705.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201705.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201706.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201706.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201706.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201706.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201707.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201707.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201707.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201707.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201708.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201708.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201708.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201708.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201709.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201709.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201709.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201709.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201710.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201710.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201710.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201710.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201711.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201711.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201711.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201711.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201712.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201712.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201712.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201712.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201801.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201801.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201801.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201801.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201802.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201802.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201802.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201802.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201803.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201803.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201803.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201803.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201804.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201804.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201804.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201804.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201805.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201805.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201805.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201805.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201806.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201806.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201806.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201806.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201807.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201807.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201807.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201807.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201808.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201808.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201808.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201808.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201809.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201809.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201809.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201809.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201810.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201810.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201810.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201810.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201811.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201811.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201811.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201811.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201812.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201812.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201812.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201812.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201901.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201901.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201901.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201901.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201902.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201902.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201902.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201902.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201903.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201903.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201903.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201903.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201904.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201904.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201904.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201904.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201905.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201905.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201905.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201905.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201906.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201906.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201906.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201906.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201907.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201907.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201907.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201907.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201908.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201908.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201908.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201908.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201909.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201909.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201909.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201909.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201910.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201910.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201910.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201910.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201911.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201911.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201911.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201911.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201912.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201912.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201912.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.201912.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202001.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202001.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202001.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202001.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202002.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202002.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202002.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202002.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202003.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202003.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202003.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202003.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202004.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202004.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202004.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202004.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202005.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202005.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202005.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202005.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202006.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202006.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202006.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202006.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202007.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202007.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202007.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202007.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202008.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202008.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202008.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202008.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202009.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202009.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202009.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202009.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202010.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202010.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202010.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202010.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202011.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202011.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202011.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202011.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202012.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202012.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202012.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202012.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202101.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202101.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202101.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202101.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202102.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202102.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202102.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202102.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202103.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202103.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202103.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202103.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202104.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202104.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202104.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202104.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202105.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202105.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202105.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.2/diurnal/pgbh.gdas.202105.18Z.tar
#
# clean up
rm auth.rda.ucar.edu.$$ auth_status.rda.ucar.edu
