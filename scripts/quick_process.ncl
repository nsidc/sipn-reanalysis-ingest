begin

setfileoption("nc","Format","NetCDF4")

hrs=(/"18","00","06","12","18"/)
dys=(/"01","02","02","02","02"/)

; Variables from the pgbh06 file, these are 6 hourly forecasts valid 6 hours after
; the date of the file
; SURFACE VARIABLES AND PRECIPITATBLE WATER

hr6vars=(/"UGRD_P0_L103_GLL0","VGRD_P0_L103_GLL0","TMP_P0_L103_GLL0","SPFH_P0_L103_GLL0","RH_P0_L103_GLL0","PWAT_P0_L200_GLL0"/)


; Variables from the pgbhnl file, these are analysis files (so valid at the time
; of the file date)
; UPPER LEVEL VARIABLES AND SLP

nlvars=(/"UGRD_P0_L100_GLL0","VGRD_P0_L100_GLL0","TMP_P0_L100_GLL0","SPFH_P0_L100_GLL0","RH_P0_L100_GLL0","HGT_P0_L100_GLL0","PRMSL_P0_L101_GLL0"/)


; Output file names
hr6names=(/"U","V","T","SH","RH","PWAT"/)
nlnames=(/"U","V","T","SH","RH","HGT","MSLP"/)


; Open output file, define file attributes
fout=addfile("cfsr.19790102.nc","c")
setfileoption(fout,"DefineMode",True)
fAtt = True
fAtt@title = "Test file"
fAtt@creation_date = systemfunc("date")
fileattdef(fout,fAtt)


; Attributes for variables 
dimNames=(/"lat_0","lon_0","level"/)
dimSizes=(/61,720,5/)
dimUnlim=(/False,False,False/)
filedimdef(fout,dimNames,dimSizes,dimUnlim)




; Loop through variables to extract
do v=0,6
   do h=0,3

; Grab these variables from 2 different files (i.e. upper level temperature
; in the pgbhnl file and 2m temperature from the pgb06 file
      if(v.le.4) then 
         if(h.eq.0) then
            tvar4d=new((/61,720,4,4/),"float")
         end if
         fn06=addfile("../Python/pgbh06.gdas.197901"+dys(h)+hrs(h)+".grb2","r")
         var06=fn06->$hr6vars(v)$
         fnnl=addfile("../Python/pgbhnl.gdas.197901"+dys(h+1)+hrs(h+1)+".grb2","r")
         varnl=fnnl->$nlvars(v)$
         tvar4d(:,:,0,h)=var06(0:60,:)
         tvar4d(:,:,1,h)=varnl(33,0:60,:)
         tvar4d(:,:,2,h)=varnl(30,0:60,:)
         tvar4d(:,:,3,h)=varnl(21,0:60,:)
; Write out lat/lon/levels to output file
         if(v.eq.0) then
; Latitude
            lat_0=fnnl->lat_0
            lat_0new=lat_0(0:60)
            lat_0new@units = "degrees_north"
            lat_0new@long_name = "latitude"
            filevardef(fout,"lat_0",typeof(lat_0new),getvardims(lat_0new))
            filevarattdef(fout,"lat_0",lat_0new)
            fout->lat_0 = lat_0new
; Longitude
            lon_0=fnnl->lon_0
            lon_0=where(lon_0.gt.180.,lon_0-360.,lon_0)
            delete_VarAtts(lon_0,-1)
            lon_0@long_name="longitude"
            lon_0@units="degrees_east"
            fout->lon_0 = lon_0
; Levels
            levels=(/925,850,500,2,10/)
            levels!0="level"
            filevardef(fout,"levels",typeof(levels),"level")
            filevarattdef(fout,"levels",levels)
            fout->levels = levels
         end if
      else if (v.eq.5) then ; Grab one from the pgbhnl and one variable from pgbh06
         if(h.eq.0) then
            tvar4d=new((/61,720,4,4/),"float")
            tvar3d=new((/61,720,4/),"float")
         end if
         fn06=addfile("../Python/pgbh06.gdas.197901"+dys(h)+hrs(h)+".grb2","r")
         var06=fn06->$hr6vars(v)$
         tvar3d(:,:,h)=var06(0:60,:)
         fnnl=addfile("../Python/pgbhnl.gdas.197901"+dys(h+1)+hrs(h+1)+".grb2","r")
         varnl=fnnl->$nlvars(v)$
         tvar4d(:,:,0,h)=varnl(33,0:60,:)
         tvar4d(:,:,1,h)=varnl(30,0:60,:)
         tvar4d(:,:,2,h)=varnl(21,0:60,:)
      else if (v.eq.6) then ; Grab SLP
         if(h.eq.0) then
            tvar3d=new((/61,720,4/),"float")
         end if
         fnnl=addfile("../Python/pgbhnl.gdas.197901"+dys(h+1)+hrs(h+1)+".grb2","r")
         varnl=fnnl->$nlvars(v)$
         tvar3d(:,:,h)=varnl(0:60,:)
      end if
      end if
      end if
   end do


; Write out all variables (if statement is to make sure correct levels are 
; included with the variables in the output file)

   if(v.le.1) then
      varout3d=new((/61,720,4/),"float")
      do x=0,3
         varout3d(:,:,x)=dim_avg(tvar4d(:,:,x,:))
      end do
      copy_VarAtts(varnl,varout3d)
      delete_VarAtts(varout3d,(/"center","production_status","parameter_discipline_and_category","parameter_template_discipline_category_number","level_type","forecast_time","forecast_time_units","initial_time"/))
      varout3d!0="lat_0"
      varout3d!1="lon_0"
      varout3d!2="level"
      varout3d@date = "19790102"
      varout3d@levels = "10m,925mb,850mb,500mb"
      filevardef(fout,nlnames(v),typeof(varout3d),getvardims(varout3d))
      filevarattdef(fout,nlnames(v),varout3d)
      fout->$nlnames(v)$ = (/varout3d/)
      delete(tvar4d)
      delete(varout3d)
      delete(varnl)
   else if (v.ge.2.and.v.le.4) then
      varout3d=new((/61,720,4/),"float")
      do x=0,3
         varout3d(:,:,x)=dim_avg(tvar4d(:,:,x,:))
      end do
      copy_VarAtts(varnl,varout3d)
      delete_VarAtts(varout3d,(/"center","production_status","parameter_discipline_and_category","parameter_template_discipline_category_number","level_type","forecast_time","forecast_time_units","initial_time"/))
      varout3d!0="lat_0"
      varout3d!1="lon_0"
      varout3d!2="level"
      varout3d@date = "19790102"
      varout3d@levels = "2m,925mb,850mb,500mb"
      filevardef(fout,nlnames(v),typeof(varout3d),getvardims(varout3d))
      filevarattdef(fout,nlnames(v),varout3d)
      fout->$nlnames(v)$ = (/varout3d/)
      delete(tvar4d)
      delete(varout3d)
      delete(varnl)
   else if (v.eq.5) then
      varout3d=new((/61,720,3/),"float")
      do x=0,2
         varout3d(:,:,x)=dim_avg(tvar4d(:,:,x,:))
      end do
      copy_VarAtts(varnl,varout3d)
      delete_VarAtts(varout3d,(/"center","production_status","parameter_discipline_and_category","parameter_template_discipline_category_number","level_type","forecast_time","forecast_time_units","initial_time"/))
      varout3d!0="lat_0"
      varout3d!1="lon_0"
      varout3d!2="level"
      varout3d@date = "19790102"
      varout3d@levels = "925mb,850mb,500mb"
      filevardef(fout,nlnames(v),typeof(varout3d),getvardims(varout3d))
      filevarattdef(fout,nlnames(v),varout3d)
      fout->$nlnames(v)$ = (/varout3d/)

      varout2d=new((/61,720/),"float")
      varout2d=dim_avg(tvar3d)
      copy_VarAtts(var06,varout2d)
      varout2d!0="lat_0"
      varout2d!1="lon_0"
      varout2d@date = "19790102"
      delete_VarAtts(varout2d,(/"center","production_status","parameter_discipline_and_category","parameter_template_discipline_category_number","level_type","level","forecast_time","forecast_time_units","initial_time"/))
      filevardef(fout,hr6names(v),typeof(varout2d),getvardims(varout2d))
      filevarattdef(fout,hr6names(v),varout2d)
      fout->$hr6names(v)$ = (/varout2d/)
      delete(tvar4d)
      delete(varout3d)
      delete(varnl)
      delete(tvar3d)
      delete(varout2d)
      delete(var06)
   else if (v.eq.6) then
      varout2d=new((/61,720/),"float")
      varout2d=dim_avg(tvar3d)
      copy_VarAtts(varnl,varout2d)
      varout2d!0="lat_0"
      varout2d!1="lon_0"
      varout2d@date = "19790102"
      delete_VarAtts(varout2d,(/"center","production_status","parameter_discipline_and_category","parameter_template_discipline_category_number","level_type","level","forecast_time","forecast_time_units","initial_time"/))
      filevardef(fout,nlnames(v),typeof(varout2d),getvardims(varout2d))
      filevarattdef(fout,nlnames(v),varout2d)
      fout->$nlnames(v)$ = (/varout2d/)
      delete(tvar3d)
      delete(varout2d)
      delete(varnl)
   end if
   end if
   end if
   end if
end do


end
;      t2mout!0=dimNames(0)
;     t2mout!1=dimNames(1)
;t2mout&lon_0=lonsfc
;0-60
;0-12
;         21=500mb
;30=850
;33=925 
