/* stting up the data sets for the analysis */

clear
set more off, permanently
log close _all

gl raw="D:\data\ENOE"
gl temp="D:\data\ENOE\Chpt_I_II\temporal"
gl final="D:\data\ENOE\Chpt_I_II\final"

foreach y in 07 08 09 10 11 12 13 14 15 16 17 18{
foreach x in 4 3 2 1{


use "$raw\20`y'\SDEMT`x'`y'.dta"


*br cd_a ent con v_sel n_hog h_mud n_ren

/*
tostring cd_a, gen(cd_a_s)
tostring ent, gen(ent_s) 
tostring con, gen(con_s) 
tostring v_sel, gen(v_sel_s) 
tostring n_hog, gen(n_hog_s) 
tostring h_mud, gen(h_mud_s) 
tostring n_ren, gen(n_ren_s)
egen key_var=concat(cd_a_s ent_s con_s v_sel_s n_hog_s h_mud_s n_ren_s) 

destring key_var, replace

drop cd_a_s ent_s con_s v_sel_s n_hog_s h_mud_s n_ren_s

*/

destring cd_a ent con v_sel n_hog h_mud n_ren, replace
egen key_var=concat(cd_a ent con v_sel n_hog h_mud n_ren) 
destring key_var, replace

codebook key_var

*fre sex
*fre n_ren 

*tab n_ren sex [fw=fac]
*fre n_ren if sex==1
*fre n_ren if sex==2
*tab n_ren sex
*keep if n_ren==1


bysort key_var: gen cont=_n
keep if cont==1
drop cont
destring key_var, replace
	
/*	* once the sample is working this need to be anulated.
**************************************************************************	
	gen sample=ceil(runiform(0,100))
    gen samplem=ceil(runiform(0,100)) if cs_ad_des==3
	
	
	gen sample_1=0
	replace sample_1=1 if sample<11
	replace sample_1=1 if samplem<99
	
	keep if sample_1==1
**************************************************************************	
*/
*cd ‪D:\data\ENOE\Chpt_I_II
save "$temp\sdemt_`x'`y'", replace
clear
}
}

* identifica a las personas que son cabeza de hogar que aparecen en la base
* y 08  09 10 11 12 13 14 15 16 17 18
foreach y in 07 08 09 10 11 12 13 14 15 16 17 18{
foreach x in 4 3 2 1{
clear
use "$temp\sdemt_`x'`y'.dta"  
keep if n_ren==1
bysort key_var: gen cont=_n
keep if cont==1
drop cont 
keep key_var fac
gen trim_`x'`y'=1
destring key_var, replace
save "$temp\key_`x'`y'", replace

}
}

foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
foreach x in 08 09 10 11 12 13 14 15 16 17 18 {
if `x'==`y'+1 {
clear
use "$temp\key_4`y'"

merge 1:1 key_var using "$temp\key_1`x'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_2`x'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_3`x'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_4`x'"
drop if _merge==2
drop _merge

save  "$temp\key_4`y'", replace
}
}
}

foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
foreach x in 08 09 10 11 12 13 14 15 16 17 18 {
if `x'==`y'+1 {
clear
use "$temp\key_3`y'"

merge 1:1 key_var using "$temp\key_4`y'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_1`x'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_2`x'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_3`x'"
drop if _merge==2
drop _merge

save  "$temp\key_3`y'", replace
}
}
}

foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
foreach x in 08 09 10 11 12 13 14 15 16 17 18 {
if `x'==`y'+1 {
clear
use "$temp\key_2`y'"

merge 1:1 key_var using "$temp\key_3`y'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_4`y'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_1`x'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_1`x'"
drop if _merge==2
drop _merge

save  "$temp\key_2`y'", replace
}
}
}

foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
foreach x in 08 09 10 11 12 13 14 15 16 17 18 {
if `x'==`y'+1 {
clear
use "$temp\key_1`y'"

merge 1:1 key_var using "$temp\key_2`y'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_3`y'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_4`y'"
drop if _merge==2
drop _merge
merge 1:1 key_var using "$temp\key_1`x'"
drop if _merge==2
drop _merge

save  "$temp\key_1`y'", replace
}
}
}


foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
foreach x in 08 09 10 11 12 13 14 15 16 17 18 {

* empezando en el 4to trimestsre
if `x'==`y'+1{
{
	
		clear
		use "$temp\key_4`y'"
		
		codebook key_var if trim_4`y'==1  
		codebook key_var
		
		
		bysort key_var: gen cont=_n
		fre cont
		keep if cont==1
		drop cont 

* para identificar a los que se ausentan de la base, pero permanecen todo el periodo
		egen all_sample=rowtotal( trim_4`y' trim_1`x' trim_2`x' trim_3`x' trim_4`x' )

		fre all_sample 
		
		keep key_var all_sample trim_4`y' trim_1`x' trim_2`x' trim_3`x' trim_4`x'

		save "$temp\key_4`y'_fpanel.dta", replace

 
		expand 5

		bysort key_var: gen cont=_n
		fre cont
		
		gen per=4`y' if cont==1
		replace per=1`x' if cont==2
		replace per=2`x' if cont==3
		replace per=3`x' if cont==4
		replace per=4`x' if cont==5
		
		rename cont time_wp
		
		*sort key_var time_wp

		save "$temp\key_4`y'_fpanel.dta", replace 
  
		clear
		use "$temp\sdemt_4`y'.dta"
		append using "$temp\sdemt_1`x'.dta"
		append using "$temp\sdemt_2`x'.dta"
		append using "$temp\sdemt_3`x'.dta"
		append using "$temp\sdemt_4`x'.dta"

*fre n_ren [fw=fac] if per==417
*fre n_ren [fw=fac] if per==118
*fre n_ren [fw=fac] if per==218
*fre n_ren [fw=fac] if per==318
*fre n_ren [fw=fac] if per==418

		keep if n_ren==1


		save "$temp\4`y'_fpanel.dta", replace 
  

		clear

		use "$temp\key_4`y'_fpanel.dta"

		merge 1:1 key_var per using "$temp\4`y'_fpanel.dta"

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
		


		save "$temp\20`y'Q4.dta", replace  
}  
}
}
}
 * empezando en el 3er trimestsre
foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
foreach x in 08 09 10 11 12 13 14 15 16 17 18 {

* empezando en el 4to trimestsre
if `x'==`y'+1{

 { 
 clear
		use "$temp\key_3`y'"
		
		codebook key_var if trim_3`y'==1  
		codebook key_var
		
		
		bysort key_var: gen cont=_n
		fre cont
		keep if cont==1
		drop cont 

* para identificar a los que se ausentan de la base, pero permanecen todo el periodo
		egen all_sample=rowtotal( trim_3`y' trim_4`y' trim_1`x' trim_2`x' trim_3`x' )

		fre all_sample 
		
		keep key_var all_sample trim_3`y' trim_4`y' trim_1`x' trim_2`x' trim_3`x'

		save "$temp\key_3`y'_fpanel.dta", replace

		expand 5

		bysort key_var: gen cont=_n
		fre cont
		
		gen per=3`y' if cont==1
		replace per=4`y' if cont==2
		replace per=1`x' if cont==3
		replace per=2`x' if cont==4
		replace per=3`x' if cont==5
		
		rename cont time_wp
		
		*sort key_var time_wp

		save "$temp\key_3`y'_fpanel.dta", replace 
  
		clear
		use "$temp\sdemt_3`y'.dta"
		append using "$temp\sdemt_4`y'.dta"
		append using "$temp\sdemt_1`x'.dta"
		append using "$temp\sdemt_2`x'.dta"
		append using "$temp\sdemt_3`x'.dta"

*fre n_ren [fw=fac] if per==417
*fre n_ren [fw=fac] if per==118
*fre n_ren [fw=fac] if per==218
*fre n_ren [fw=fac] if per==318
*fre n_ren [fw=fac] if per==418

		keep if n_ren==1


		save "$temp\3`y'_fpanel.dta", replace 
  

		clear

		use "$temp\key_3`y'_fpanel.dta"

		merge 1:1 key_var per using "$temp\3`y'_fpanel.dta"

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
		


		save "$temp\20`y'Q3.dta", replace  

}
}
}
}

* empezando en el 2do trimestsre 
foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
foreach x in 08 09 10 11 12 13 14 15 16 17 18 {

* empezando en el 4to trimestsre
if `x'==`y'+1{

{

clear
		use "$temp\key_2`y'"
		
		codebook key_var if trim_2`y'==1  
		codebook key_var
		
		
		bysort key_var: gen cont=_n
		fre cont
		keep if cont==1
		drop cont 

* para identificar a los que se ausentan de la base, pero permanecen todo el periodo
		egen all_sample=rowtotal( trim_2`y' trim_3`y' trim_4`y' trim_1`x' trim_2`x' )

		fre all_sample 
		
		keep key_var all_sample trim_2`y' trim_3`y' trim_4`y' trim_1`x' trim_2`x' 

		save "$temp\key_2`y'_fpanel.dta", replace

		expand 5

		bysort key_var: gen cont=_n
		fre cont
		
		gen per=2`y' if cont==1
		replace per=3`y' if cont==2
		replace per=4`y' if cont==3
		replace per=1`x' if cont==4
		replace per=2`x' if cont==5
		
		rename cont time_wp
		
		*sort key_var time_wp

		save "$temp\key_2`y'_fpanel.dta", replace 
  
		clear
		use "$temp\sdemt_2`y'.dta"
		append using "$temp\sdemt_3`y'.dta"
		append using "$temp\sdemt_4`y'.dta"
		append using "$temp\sdemt_1`x'.dta"
		append using "$temp\sdemt_2`x'.dta"

*fre n_ren [fw=fac] if per==417
*fre n_ren [fw=fac] if per==118
*fre n_ren [fw=fac] if per==218
*fre n_ren [fw=fac] if per==318
*fre n_ren [fw=fac] if per==418

		keep if n_ren==1
		save "$temp\2`y'_fpanel.dta", replace 
  
		clear

		use "$temp\key_2`y'_fpanel.dta"

		merge 1:1 key_var per using "$temp\2`y'_fpanel.dta"

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
		


		save "$temp\20`y'Q2.dta", replace  
	
}
}
}
}

* empezando en el 1er trimestsre 
foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
foreach x in 08 09 10 11 12 13 14 15 16 17 18 {

* empezando en el 4to trimestsre
if `x'==`y'+1{

{
clear
		use "$temp\key_1`y'"
		
		codebook key_var if trim_1`y'==1  
		codebook key_var
		
		
		bysort key_var: gen cont=_n
		fre cont
		keep if cont==1
		drop cont 

* para identificar a los que se ausentan de la base, pero permanecen todo el periodo
		egen all_sample=rowtotal( trim_1`y' trim_2`y' trim_3`y' trim_4`y' trim_1`x'  )

		fre all_sample 
		
		keep key_var all_sample trim_1`y' trim_2`y' trim_3`y' trim_4`y' trim_1`x' 

		save "$temp\key_1`y'_fpanel.dta", replace

		expand 5

		bysort key_var: gen cont=_n
		fre cont
		
		gen per=1`y' if cont==1
		replace per=2`y' if cont==2
		replace per=3`y' if cont==3
		replace per=4`y' if cont==4
		replace per=1`x' if cont==5
		
		rename cont time_wp
		
		*sort key_var time_wp

		save "$temp\key_1`y'_fpanel.dta", replace 
  
		clear
		use "$temp\sdemt_1`y'.dta"
		append using "$temp\sdemt_2`y'.dta"
		append using "$temp\sdemt_3`y'.dta"
		append using "$temp\sdemt_4`y'.dta"
		append using "$temp\sdemt_1`x'.dta"

*fre n_ren [fw=fac] if per==417
*fre n_ren [fw=fac] if per==118
*fre n_ren [fw=fac] if per==218
*fre n_ren [fw=fac] if per==318
*fre n_ren [fw=fac] if per==418

		keep if n_ren==1


		save "$temp\1`y'_fpanel.dta", replace 
  

		clear

		use "$temp\key_1`y'_fpanel.dta"

		merge 1:1 key_var per using "$temp\1`y'_fpanel.dta"

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
		
		

		save "$temp\20`y'Q1.dta", replace    
}
}
}
}

foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
    foreach x in 1 2 3 4{
	clear
	use "$temp\20`y'Q`x'.dta"
	gen quarter=`x'
	sum year
	sum quarter
	
	tab time_wp migest
	tab migest
	tab migest sex
	}
}
 
foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
  
  clear
	use "$temp\20`y'Q1.dta"  
	append using "$temp\20`y'Q2.dta"
	append using "$temp\20`y'Q3.dta"
	append using "$temp\20`y'Q4.dta"
	
	tab year
	tab migest
	tab migest sex [fw=fac]
	
	
	
	save "$temp\20`y'_allQ.dta", replace
	
}

foreach y in 07 08 09 10 11 12 13 14 15 16 17 {
clear
use "$temp\20`y'_allQ.dta", replace


	tab migest [fw=fac]
	tab migest sex [fw=fac]
save "$final\20`y'_allQ.dta", replace	
}





