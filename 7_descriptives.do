*descriptives

clear
set more off, permanently

*gl final="D:\data\ENOE\Chpt_I_II\final"

cd D:\data\ENOE\Chpt_I_II\final

use ra_071217_years_VF.dta

*********** Main table - descriptives *****************************************
gen eda7c_1=eda7c[_n-1] if time_wp!=1
replace eda7c_1=eda7c if time_wp==1
gen anios_esc_1=anios_esc[_n-1] if time_wp!=1
replace anios_esc_1=anios_esc if time_wp==1
gen clase2_1=clase2[_n-1] if time_wp!=1
replace clase2_1=clase2 if time_wp==1
gen clase1_1=clase1[_n-1] if time_wp!=1
replace clase1_1=clase1 if time_wp==1
gen gob_supp_1=p14apoyos[_n-1] if time_wp!=1
replace gob_supp_1=p14apoyos if time_wp==1



count if migest==0 & risk_averse==0 & sex==1
count if migest==0 & risk_averse==1 & sex==1
count if migest==1 & risk_averse==0 & sex==1
count if migest==1 & risk_averse==1 & sex==1

count if migest==0 & risk_averse==0 & sex==2
count if migest==0 & risk_averse==1 & sex==2
count if migest==1 & risk_averse==0 & sex==2
count if migest==1 & risk_averse==1 & sex==2



fre migest if risk_averse==0 & sex==1
fre migest if risk_averse==1 & sex==1
fre migest if risk_averse==0 & sex==2
fre migest if risk_averse==1 & sex==2

tabstat eda if migest==0 & risk_averse==0 & sex==1, stats(mean p50)
tabstat eda if migest==0 & risk_averse==1 & sex==1, stats(mean p50)
tabstat eda if migest==1 & risk_averse==0 & sex==1, stats(mean p50)
tabstat eda if migest==1 & risk_averse==1 & sex==1, stats(mean p50)

tabstat eda if migest==0 & risk_averse==0 & sex==2, stats(mean p50)
tabstat eda if migest==0 & risk_averse==1 & sex==2, stats(mean p50)
tabstat eda if migest==1 & risk_averse==0 & sex==2, stats(mean p50)
tabstat eda if migest==1 & risk_averse==1 & sex==2, stats(mean p50)

fre rural if migest==0 & risk_averse==1 & sex==1
fre rural if migest==1 & risk_averse==1 & sex==1
fre rural if migest==0 & risk_averse==0 & sex==1
fre rural if migest==1 & risk_averse==0 & sex==1

fre rural if migest==0 & risk_averse==1 & sex==2
fre rural if migest==1 & risk_averse==1 & sex==2
fre rural if migest==0 & risk_averse==0 & sex==2
fre rural if migest==1 & risk_averse==0 & sex==2

tabstat anios_esc_1 if migest==0 & risk_averse==0 & sex==1, stats(mean p50)
tabstat anios_esc_1 if migest==0 & risk_averse==1 & sex==1, stats(mean p50)
tabstat anios_esc_1 if migest==1 & risk_averse==0 & sex==1, stats(mean p50)
tabstat anios_esc_1 if migest==1 & risk_averse==1 & sex==1, stats(mean p50)

tabstat anios_esc_1 if migest==0 & risk_averse==0 & sex==2, stats(mean p50)
tabstat anios_esc_1 if migest==0 & risk_averse==1 & sex==2, stats(mean p50)
tabstat anios_esc_1 if migest==1 & risk_averse==0 & sex==2, stats(mean p50)
tabstat anios_esc_1 if migest==1 & risk_averse==1 & sex==2, stats(mean p50)

fre clase1
fre clase1_1 if migest==0 & risk_averse==0 & sex==1
fre clase1_1 if migest==0 & risk_averse==1 & sex==1
fre clase1_1 if migest==1 & risk_averse==0 & sex==1
fre clase1_1 if migest==1 & risk_averse==1 & sex==1

fre clase1_1 if migest==0 & risk_averse==0 & sex==2
fre clase1_1 if migest==0 & risk_averse==1 & sex==2
fre clase1_1 if migest==1 & risk_averse==0 & sex==2
fre clase1_1 if migest==1 & risk_averse==1 & sex==2



fre clase2
fre clase2_1 if migest==0 & risk_averse==0 & sex==1
fre clase2_1 if migest==0 & risk_averse==1 & sex==1
fre clase2_1 if migest==1 & risk_averse==0 & sex==1
fre clase2_1 if migest==1 & risk_averse==1 & sex==1

fre clase2_1 if migest==0 & risk_averse==0 & sex==2
fre clase2_1 if migest==0 & risk_averse==1 & sex==2
fre clase2_1 if migest==1 & risk_averse==0 & sex==2
fre clase2_1 if migest==1 & risk_averse==1 & sex==2


fre wage_earners if migest==0 & risk_averse==0 & sex==1
fre wage_earners if migest==0 & risk_averse==1 & sex==1
fre wage_earners if migest==1 & risk_averse==0 & sex==1
fre wage_earners if migest==1 & risk_averse==1 & sex==1

fre wage_earners if migest==0 & risk_averse==0 & sex==2
fre wage_earners if migest==0 & risk_averse==1 & sex==2
fre wage_earners if migest==1 & risk_averse==0 & sex==2
fre wage_earners if migest==1 & risk_averse==1 & sex==2

fre gob_supp_1 if migest==0 & risk_averse==0 & sex==1
fre gob_supp_1 if migest==0 & risk_averse==1 & sex==1
fre gob_supp_1 if migest==1 & risk_averse==0 & sex==1
fre gob_supp_1 if migest==1 & risk_averse==1 & sex==1

fre gob_supp_1 if migest==0 & risk_averse==0 & sex==2
fre gob_supp_1 if migest==0 & risk_averse==1 & sex==2
fre gob_supp_1 if migest==1 & risk_averse==0 & sex==2
fre gob_supp_1 if migest==1 & risk_averse==1 & sex==2






mean ing_x_hrs_1 [fw=fac] if migest==0 & risk_averse==0 & sex==1
mean ing_x_hrs_1 [fw=fac] if migest==0 & risk_averse==1 & sex==1
mean ing_x_hrs_1 [fw=fac] if migest==1 & risk_averse==0 & sex==1
mean ing_x_hrs_1 [fw=fac] if migest==1 & risk_averse==1 & sex==1

mean ing_x_hrs_1 [fw=fac] if migest==0 & risk_averse==0 & sex==2
mean ing_x_hrs_1 [fw=fac] if migest==0 & risk_averse==1 & sex==2
mean ing_x_hrs_1 [fw=fac] if migest==1 & risk_averse==0 & sex==2
mean ing_x_hrs_1 [fw=fac] if migest==1 & risk_averse==1 & sex==2


mean ingocup_1 [fw=fac] if migest==0 & risk_averse==0 & sex==1
mean ingocup_1 [fw=fac] if migest==0 & risk_averse==1 & sex==1
mean ingocup_1 [fw=fac] if migest==1 & risk_averse==0 & sex==1
mean ingocup_1 [fw=fac] if migest==1 & risk_averse==1 & sex==1

mean ingocup_1 [fw=fac] if migest==0 & risk_averse==0 & sex==2
mean ingocup_1 [fw=fac] if migest==0 & risk_averse==1 & sex==2
mean ingocup_1 [fw=fac] if migest==1 & risk_averse==0 & sex==2
mean ingocup_1 [fw=fac] if migest==1 & risk_averse==1 & sex==2




********************************************************************************
foreach y in 2007 2012 2017{
tab year if year==`y'
tab eda7c_1 [fw=fac] if migest==0 & risk_averse==0 & rural==1 & year==`y'
tab eda7c_1 [fw=fac] if migest==0 & risk_averse==1 & rural==1 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==0 & rural==1 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==1 & rural==1 & year==`y'

tab eda7c_1 [fw=fac] if migest==0 & risk_averse==0 & rural==0 & year==`y'
tab eda7c_1 [fw=fac] if migest==0 & risk_averse==1 & rural==0 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==0 & rural==0 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==1 & rural==0 & year==`y'

}


foreach y in 2007 2012 2017{
tab year if year==`y'
fre migest [fw=fac] if sex==1 & year==`y'
fre migest [fw=fac] if sex==2 & year==`y'

}


foreach y in 2007 2012 2017{
tab year if year==`y'
tab eda7c_1 [fw=fac] if migest==0 & risk_averse==0 & sex==1 & year==`y'
tab eda7c_1 [fw=fac] if migest==0 & risk_averse==1 & sex==1 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==0 & sex==1 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==1 & sex==1 & year==`y'

tab eda7c_1 [fw=fac] if migest==0 & risk_averse==0 & sex==2 & year==`y'
tab eda7c_1 [fw=fac] if migest==0 & risk_averse==1 & sex==2 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==0 & sex==2 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==1 & sex==2 & year==`y'

}

 foreach y in 2007 2012 2017{
tab year if year==`y'
tab eda7c_1 [fw=fac] if migest==0 & risk_averse==0 & rural==1 & year==`y'
tab eda7c_1 [fw=fac] if migest==0 & risk_averse==1 & rural==1 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==0 & rural==1 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==1 & rural==1 & year==`y'

tab eda7c_1 [fw=fac] if migest==0 & risk_averse==0 & rural==0 & year==`y'
tab eda7c_1 [fw=fac] if migest==0 & risk_averse==1 & rural==0 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==0 & rural==0 & year==`y'
tab eda7c_1 [fw=fac] if migest==1 & risk_averse==1 & rural==0 & year==`y'

}


gen unemployment=0
replace unemployment=1 if clase2_1==2 | clase2_1==3
 foreach y in 2007 2012 2017{
tab time_wp unemployment if migest==1 & year==`y' [fw=fac] 
 }

gen id_migurbana=0
replace id_migurbana=1 if rural[_n-1]==1 & rural[_n]==0
 
gen mig_urbana=0
replace mig_urbana=1 if id_migurbana==1


 foreach y in 2007 2012 2017{
tab time_wp mig_urbana if migest==0 & year==`y' & risk_averse==1 [fw=fac] 
 }
 foreach y in 2007 2012 2017{
tab time_wp mig_urbana if migest==0 & year==`y' & risk_averse==0 [fw=fac] 
 } 
 foreach y in 2007 2012 2017{
tab time_wp mig_urbana if migest==1 & year==`y' & risk_averse==1 [fw=fac] 
 }
 foreach y in 2007 2012 2017{
tab time_wp mig_urbana if migest==1 & year==`y' & risk_averse==0 [fw=fac] 
 }
 
 
 
 
 foreach y in 2007 2012 2017{
     foreach i in 0 1{
		foreach x in 1 2 3 4 5 6 {
	     
			mean anios_esc_1 if eda7c_1==`x' & year==`y' & migest==`i'
		 }
	 }
 }
 
 
 foreach y in 2007 2012 2017{
     foreach i in 0 1{
		foreach x in 1 2 3 4 5 6 {
	     
			mean ingocup_1 if eda7c_1==`x' & year==`y' & migest==`i'
		 }
	 }
 } 
  foreach y in 2007 2012 2017{
     foreach i in 0 1{
		foreach x in 1 2 3 4 5 6 {
	     
			mean ing_x_hrs_1 if eda7c_1==`x' & year==`y' & migest==`i'
		 }
	 }
 }
 
 
save, replace