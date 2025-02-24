
clear
set more off, permanently
log close _all

gl raw="D:\data\ENOE"
gl temp="D:\data\ENOE\Chpt_I_II\temporal"
gl final="D:\data\ENOE\Chpt_I_II\final"
		clear
		use "$temp\key_407"
		
		codebook key_var if trim_407==1  
		codebook key_var
		
		
		bysort key_var: gen cont=_n
		fre cont
		keep if cont==1
		drop cont 

* para identificar a los que se ausentan de la base, pero permanecen todo el periodo
		egen all_sample=rowtotal( trim_407 trim_108 trim_208 trim_308 trim_408 )

		fre all_sample 
		
		keep key_var all_sample trim_407 trim_108 trim_208 trim_308 trim_408

		save "$temp\key_407_fpanel.dta", replace

 
		expand 5

		bysort key_var: gen cont=_n
		fre cont
		
		gen per=407 if cont==1
		replace per=108 if cont==2
		replace per=208 if cont==3
		replace per=308 if cont==4
		replace per=408 if cont==5
		
		rename cont time_wp
		
		*sort key_var time_wp

		save "$temp\key_407_fpanel.dta", replace 
  
		clear
		use "$temp\sdemt_407.dta"


		append using "$temp\sdemt_108.dta"
		append using "$temp\sdemt_208.dta"
		append using "$temp\sdemt_308.dta"
		append using "$temp\sdemt_408.dta"

*fre n_ren [fw=fac] if per==417
*fre n_ren [fw=fac] if per==118
*fre n_ren [fw=fac] if per==218
*fre n_ren [fw=fac] if per==318
*fre n_ren [fw=fac] if per==418

		keep if n_ren==1


		save "$temp\407_fpanel.dta", replace 
  

		clear

		use "$temp\key_407_fpanel.dta"

		merge 1:1 key_var per using "$temp\407_fpanel.dta"

		drop if _merge==2
		drop _merge 


* rellenar los espacvios de las variales de interés
		sort key_var time_wp
		
		tab cs_ad_des, gen(mig)
		rename mig1 mig_mismoest
		rename mig2 mig_otroest
		rename mig3 migest
		
		replace migest=0 if migest==.
		
		tab migest
		gen ingocup_1=0
		gen ing_x_hrs_1=0
		
		foreach x in 2 3 4 5{
		replace ingocup_1=ingocup[_n-1] if time_wp==`x' & ingocup_1==.
		replace ing_x_hrs_1=ing_x_hrs[_n-1] if time_wp==`x' & ing_x_hrs_1==.

		
		replace sex=sex[_n-1] if time_wp==`x' & sex==.
		replace e_con=e_con[_n-1] if time_wp==`x' & e_con==.
		replace n_hij=n_hij[_n-1] if time_wp==`x' & n_hij==.
		replace n_ren=n_ren[_n-1] if time_wp==`x' & n_ren==.
		replace eda12c=eda12c[_n-1] if time_wp==`x' & eda12c==.
		replace eda=eda[_n-1] if time_wp==`x' & eda==.
		replace scian=scian[_n-1] if time_wp==`x' & scian==.
		replace rama_est1=rama_est1[_n-1] if time_wp==`x' & rama_est1==.
		replace rama=rama[_n-1] if time_wp==`x' & rama==.
		replace clase1=clase2[_n-1] if time_wp==`x' & clase1==.
		replace clase2=clase2[_n-1] if time_wp==`x'& clase2==.
		replace clase3=clase2[_n-1] if time_wp==`x' & clase3==.
		replace eda19c=eda19c[_n-1] if time_wp==`x' & eda19c==.
		replace anios_esc=anios_esc[_n-1] if time_wp==`x' & anios_esc==.
		replace t_loc=t_loc[_n-1] if time_wp==`x' & t_loc==.
		replace cs_p13_1=cs_p13_1[_n-1] if time_wp==`x' & cs_p13_1==.
		}
		
		
		tostring key_var, gen(keyvar)
		
		gen year=20`y'
		


		save "$temp\2007Q4.dta", replace  
}  
 
 * ahora para inicio en el tercer trimestre
 
 clear
		use "$temp\key_307"
		
		codebook key_var if trim_307==1  
		codebook key_var
		
		
		bysort key_var: gen cont=_n
		fre cont
		keep if cont==1
		drop cont 

* para identificar a los que se ausentan de la base, pero permanecen todo el periodo
		egen all_sample=rowtotal( trim_307 trim_407 trim_108 trim_208 trim_308 )

		fre all_sample 
		
		keep key_var all_sample trim_307 trim_407 trim_108 trim_208 trim_308

		save "$temp\key_307_fpanel.dta", replace

		expand 5

		bysort key_var: gen cont=_n
		fre cont
		
		gen per=307 if cont==1
		replace per=407 if cont==2
		replace per=108 if cont==3
		replace per=208 if cont==4
		replace per=308 if cont==5
		
		rename cont time_wp
		
		*sort key_var time_wp

		save "$temp\key_307_fpanel.dta", replace 
  
		clear
		use "$temp\sdemt_307.dta"


		append using "$temp\sdemt_407.dta"
		append using "$temp\sdemt_108.dta"
		append using "$temp\sdemt_208.dta"
		append using "$temp\sdemt_308.dta"

*fre n_ren [fw=fac] if per==417
*fre n_ren [fw=fac] if per==118
*fre n_ren [fw=fac] if per==218
*fre n_ren [fw=fac] if per==318
*fre n_ren [fw=fac] if per==418

		keep if n_ren==1


		save "$temp\307_fpanel.dta", replace 
  

		clear

		use "$temp\key_307_fpanel.dta"

		merge 1:1 key_var per using "$temp\307_fpanel.dta"

		drop if _merge==2
		drop _merge 


* rellenar los espacvios de las variales de interés
		sort key_var time_wp

		replace sex=sex[_n-1] if key_var[_n-1]==key_var[_n-1] & sex[_n]==.
		replace e_con=e_con[_n-1] if key_var[_n-1]==key_var[_n-1] & e_con[_n]==.
		replace n_hij=n_hij[_n-1] if key_var[_n-1]==key_var[_n-1] & n_hij[_n]==.
		replace n_ren=n_ren[_n-1] if key_var[_n-1]==key_var[_n-1] & n_ren[_n]==.
		replace eda12c=eda12c[_n-1] if key_var[_n-1]==key_var[_n-1] & eda12c[_n]==.
		replace eda12c=eda12c[_n-1] if key_var[_n-1]==key_var[_n-1] & cs_ad_des==.
		replace eda=eda[_n-1] if key_var[_n-1]==key_var[_n-1] & eda==.
		replace scian=scian[_n-1] if key_var[_n-1]==key_var[_n-1] & scian==.
		replace rama_est1=rama_est1[_n-1] if key_var[_n-1]==key_var[_n-1] & rama_est1==.
		replace rama=rama[_n-1] if key_var[_n-1]==key_var[_n-1] & rama==.
		replace clase1=clase2[_n-1] if key_var[_n-1]==key_var[_n-1] & clase1==.
		replace clase2=clase2[_n-1] if key_var[_n-1]==key_var[_n-1] & clase2==.
		replace clase3=clase2[_n-1] if key_var[_n-1]==key_var[_n-1] & clase3==.
		replace eda19c=eda19c[_n-1] if key_var[_n-1]==key_var[_n-1] & eda19c[_n]==.
		replace anios_esc=anios_esc[_n-1] if key_var[_n-1]==key_var[_n-1] & anios_esc[_n]==.
		replace t_loc=t_loc[_n-1] if key_var[_n-1]==key_var[_n-1] & t_loc[_n]==.
		replace cs_p13_1=cs_p13_1[_n-1] if key_var[_n-1]==key_var[_n-1] & cs_p13_1[_n]==.
		tostring key_var, gen(keyvar)
		gen year=20`y'
		
		tab cs_ad_des, gen(mig)
		rename mig1 mig_mismoest
		rename mig2 mig_otroest
		rename mig3 migest

		save "$temp\2007Q3.dta", replace  
   