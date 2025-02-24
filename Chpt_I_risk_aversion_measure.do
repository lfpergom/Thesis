clear
set more off, permanently

gl final="D:\data\ENOE\Chpt_I_II\final"


* Retomando el archivo base de la ENOE.
*clear 08 09 10 11 12 13 14 15 16 17
local years 07 08 09 10 11 12 13 14 15 16 17
foreach y of local years{
clear
use "$final\20`y'_allQ.dta"
replace migest=0 if migest==.
* extracción de salarios de no migrantes
replace ingocup_1=ingocup[_n-1] if time_wp!=1
replace ingocup_1=ingocup if time_wp==1
replace ing_x_hrs_1=ing_x_hrs[_n-1] if time_wp!=1
replace ing_x_hrs_1=ing_x_hrs if time_wp==1

keep if migest==0

*replace ingocup_1=ingocup[_n-1] if time_wp!=1
*replace ing_x_hrs_1=ing_x_hrs[_n-1] if time_wp!=1

collapse (mean) mean_ing_x_hrs_nm=ing_x_hrs_1 mean_ingocup_nm=ingocup_1 [fw=fac], by(year time_wp)
*drop migest
keep if mean_ing_x_hrs>0 
save "$final\wages_nonmig_`y'.dta", replace



clear
use "$final\20`y'_allQ.dta"

replace migest=0 if migest==.

replace ingocup_1=ingocup[_n-1] if time_wp!=1
replace ingocup_1=ingocup if time_wp==1
replace ing_x_hrs_1=ing_x_hrs[_n-1] if time_wp!=1
replace ing_x_hrs_1=ing_x_hrs if time_wp==1

keep if migest==1

collapse (mean) mean_ing_x_hrs=ing_x_hrs_1 mean_ingocup=ingocup_1 [fw=fac], by(year time_wp)
*drop migest
keep if mean_ing_x_hrs>0 
save "$final\wages_mig_`y'.dta", replace


clear 
use "$final\wages_nonmig_`y'.dta"
merge 1:1 year time_wp using "$final\wages_mig_`y'.dta"
drop _merge
save, replace
}

* obtener la probabilidad de migrar por año 
local years 07 08 09 10 11 12 13 14 15 16 17
foreach y of local years{
clear 
use "$final\20`y'_allQ.dta"
replace migest=0 if migest==.
*bysort migest: gen cont=_N
*codebook key_var
drop tot_obs tot_obs_mig p_mig p_mig_mean
bysort time_wp: egen tot_obs=count(key_var) 
bysort time_wp: egen tot_obs_mig=count(key_var) if migest==1
gen p_mig=tot_obs_mig/tot_obs
sum p_mig
egen p_mig_mean=mean(p_mig)
merge m:1 year time_wp using "$final\wages_nonmig_`y'.dta"
drop _merge

save, replace



merge m:1 year using "D:\data\ENOE\Chpt_I_II\final\mig_cost_pxd.dta"
keep if _merge==3
drop _merge


replace ingocup_1=ingocup[_n-1] if time_wp!=1
replace ingocup_1=ingocup if time_wp==1
replace ing_x_hrs_1=ing_x_hrs[_n-1] if time_wp!=1
replace ing_x_hrs_1=ing_x_hrs if time_wp==1


* generating the individual risk aversion measure
replace p_mig=0 if p_mig==.
gen a=2*ing_x_hrs_1
gen b=(p_mig_mean * mean_ing_x_hrs_nm)
replace p_mig=0 if p_mig==.
gen c= mean_mig_cost_pesos
gen d=a*(b-c)
gen risk_a_num=d

sum risk_a_num, d

gen e=p_mig*(mean_ing_x_hrs_nm^2)
gen f=2*p_mig*mean_ing_x_hrs_nm*mean_mig_cost_pesos
gen g=mean_mig_cost_pesos^2
gen h=e-f+g

gen risk_a_den=h

gen risk_a=risk_a_num/risk_a_den

drop a b c d e f g h risk_a_num risk_a_den
		
* ahora el umbral de referencia 
	
gen a=2*mean_ing_x_hrs
gen b=(p_mig_mean * mean_ing_x_hrs_nm)
replace p_mig=0 if p_mig==.
gen c= max_cost_pesos
gen d=a*(b-c)
gen risk_a_num=d

gen e=p_mig*(mean_ing_x_hrs_nm^2)
gen f=2*p_mig*mean_ing_x_hrs_nm*max_cost_pesos
gen g=max_cost_pesos^2
gen h=e-f+g

gen risk_a_den=h

gen risk_a_max=risk_a_num/risk_a_den

drop a b c d e f g h risk_a_num risk_a_den

* generating the variable that identifies the risk averse individuals

	
gen risk_averse=0
replace risk_averse=1 if risk_a < risk_a_max




save "$final\ra_20`y'_allQ.dta", replace
}

* generating an alternative break even point
clear
use "$final\ra_20`y'_allQ.dta"

* ahora el umbral de referencia 
	
gen a=(2*mean_ing_x_hrs)/max_cost_pesos
gen b=((p_mig_mean * mean_ing_x_hrs_nm)/max_cost_pesos)-1
replace p_mig=0 if p_mig==.

gen d=a*b
gen risk_a_num=d

gen e=p_mig*((mean_ing_x_hrs_nm/max_cost_pesos)^2)
gen f=((2*p_mig*mean_ing_x_hrs_nm)/max_cost_pesos)+1
gen h=e-f

gen risk_a_den=h

gen risk_a_max=risk_a_num/risk_a_den

drop a b c d e f g h risk_a_num risk_a_den

* generating the variable that identifies the risk averse individuals

	
gen risk_averse=0
replace risk_averse=1 if risk_a < risk_a_max






* stats of risk averse individuals

tab risk_averse migest
fre risk_averse
fre risk_averse if sex==1
fre risk_averse if sex==2
fre risk_averse if sex==1 & migest==0
fre risk_averse if sex==1 & migest==1
fre risk_averse if sex==2 & migest==0
fre risk_averse if sex==2 & migest==1
*/
save "$final\ra_20`y'_allQ.dta", replace

}
	






/*
logit migest_30 scian eda19c cs_p13_1 sex rural 
sort key_var year time_wp
br key_var year time_wp 
*/


clear
local years 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017
foreach y of local years{

	use "$final\ra_`y'_allQ.dta"
	count if risk_averse==0 & ingocup!=. & migest==1 & ingocup!=0
}




