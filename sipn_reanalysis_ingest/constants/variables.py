# Only the variables we are interested in
CFSR_VARIABLES = [
    "TMP_P0_L103_GGA0",
    "UGRD_P0_L103_GGA0",
    "VGRD_P0_L103_GGA0",
    "PWAT_P0_L200_GLL0",
    "SPFH_P0_L103_GLL0",
    "RH_P0_L103_GLL0",
    "UGRD_P0_L100_GLL0",
    "VGRD_P0_L100_GLL0",
    "SPFH_P0_L100_GLL0",
]

# Upper level variables

#4d variables

fourd10m = (("UGRD_P0_L100_GLL0","UGRD_P0_L103_GLL0"),
            ("VGRD_P0_L100_GLL0","VGRD_P0_L103_GLL0"))

fourd2m =(("TMP_P0_L100_GLL0","TMP_P0_L103_GLL0"),
          ("SPFH_P0_L100_GLL0","SPFH_P0_L103_GLL0"),
          ("RH_P0_L100_GLL0","RH_P0_L103_GLL0"))

#3d variable

threed = "HGT_P0_L100_GLL0"

#2d variables
#forecast
twodf = "PWAT_P0_L200_GLL0"
#analysis
twoda = "PRMSL_P0_L101_GLL0"
