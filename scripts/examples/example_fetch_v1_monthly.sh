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
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1979.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1979.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.1000mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.100mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.10mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.125mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.150mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.175mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.1mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.200mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.20mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.225mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.250mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.2mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.300mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.30mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.350mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.3mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.400mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.450mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.500mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.50mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.550mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.5mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.600mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.650mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.700mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.70mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.750mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.775mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.7mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.800mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.825mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.850mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.875mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.900mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.925mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.950mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.975mbar.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.GPML.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.MWSL.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.PVL.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.SIGL.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.SIGY.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal_timeseries/pgbhnl.gdas.TMP.TRO.00Z.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1979.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1979.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1979.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1979.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1979.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1979.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1980.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1980.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1980.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1980.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1980.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1980.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1980.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1980.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1981.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1981.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1981.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1981.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1981.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1981.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1981.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1981.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1982.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1982.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1982.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1982.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1982.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1982.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1982.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1982.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1983.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1983.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1983.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1983.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1983.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1983.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1983.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1983.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1984.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1984.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1984.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1984.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1984.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1984.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1984.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1984.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1985.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1985.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1985.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1985.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1985.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1985.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1985.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1985.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1986.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1986.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1986.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1986.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1986.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1986.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1986.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1986.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1987.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1987.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1987.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1987.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1987.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1987.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1987.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1987.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1988.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1988.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1988.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1988.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1988.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1988.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1988.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1988.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1989.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1989.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1989.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1989.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1989.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1989.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1989.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1989.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1990.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1990.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1990.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1990.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1990.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1990.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1990.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1990.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1991.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1991.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1991.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1991.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1991.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1991.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1991.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1991.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1992.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1992.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1992.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1992.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1992.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1992.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1992.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1992.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1993.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1993.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1993.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1993.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1993.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1993.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1993.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1993.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1994.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1994.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1994.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1994.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1994.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1994.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1994.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1994.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1995.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1995.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1995.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1995.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1995.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1995.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1995.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1995.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1996.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1996.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1996.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1996.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1996.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1996.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1996.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1996.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1997.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1997.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1997.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1997.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1997.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1997.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1997.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1997.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1998.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1998.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1998.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1998.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1998.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1998.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1998.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1998.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1999.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1999.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1999.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1999.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1999.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1999.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.1999.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.1999.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2000.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2000.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2000.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2000.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2000.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2000.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2000.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2000.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2001.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2001.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2001.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2001.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2001.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2001.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2001.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2001.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2002.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2002.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2002.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2002.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2002.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2002.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2002.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2002.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2003.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2003.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2003.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2003.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2003.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2003.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2003.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2003.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2004.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2004.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2004.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2004.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2004.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2004.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2004.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2004.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2005.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2005.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2005.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2005.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2005.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2005.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2005.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2005.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2006.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2006.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2006.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2006.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2006.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2006.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2006.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2006.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2007.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2007.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2007.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2007.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2007.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2007.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2007.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2007.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2008.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2008.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2008.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2008.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2008.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2008.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2008.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2008.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2009.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2009.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2009.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2009.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2009.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2009.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2009.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2009.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2010.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2010.00Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2010.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2010.06Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2010.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2010.12Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbhnl.gdas.2010.18Z.tar
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds093.2/diurnal/pgbh06.gdas.2010.18Z.tar
#
# clean up
rm auth.rda.ucar.edu.$$ auth_status.rda.ucar.edu
