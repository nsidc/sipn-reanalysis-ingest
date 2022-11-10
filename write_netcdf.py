import numpy as np
import Ngl, Nio

def write_netcdf(array):

   outf=Nio.open_file("cfsr."+date+".nc","c")

   outf.create_dimension('lat_0',array.dimensions['lat_0'] 

   outf=create_variable('lat_0',lat_0.typecode(),lat.dimensions)

   outf.create_variable('t','f',('time','lat','lon')
