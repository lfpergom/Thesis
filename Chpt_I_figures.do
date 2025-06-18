clear
set more off, permanently

gl final="D:\data\ENOE\Chpt_I_II\final"
cd D:\data\ENOE\Chpt_I_II\final

clear
use ra_071217_years


* introduction
label var ingocup_1 "Monthly income (pesos)"

graph box ingocup_1 [fw=fac] if ingocup_1>0, over(migest) over(sex) over(year)   medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\finalboxgraph_ingocup_VF.png", replace

graph box ingocup_1 [fw=fac] if ingocup_1>0 & migest==0, over(risk_averse) over(sex) over(year)   medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\finalboxgraph_ingocup_nomig_VF.png", replace

graph box ingocup_1 [fw=fac] if ingocup_1>0 & migest==1, over(risk_averse) over(sex) over(year)   medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\finalboxgraph_ingocup_mig_VF.png", replace


////////////////////////////////////////////////////////////////////////////////
* alternativa usando rural como variable que clasifica

label var ingocup_1 "Monthly income (pesos)"
la var rural "Rural"

graph box ingocup_1 [fw=fac] if ingocup_1>0, over(migest) over(rural) over(year)   medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\finalboxgraph_ingocup_Vrural.png", replace

graph box ingocup_1 [fw=fac] if ingocup_1>0 & migest==0, over(risk_averse) over(rural) over(year)   medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\finalboxgraph_ingocup_nomig_Vrural.png", replace

graph box ingocup_1 [fw=fac] if ingocup_1>0 & migest==1, over(risk_averse) over(rural) over(year)   medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\\finalboxgraph_ingocup_mig_Vrural.png", replace








* Figure I - CDF graphs 
foreach y in 07 12 17{
clear 

use ra_071217_years
cumul ln_ingocup [fw=fac] if  migest==0 & year==20`y' & ln_ingocup>0, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest==1 & year==20`y' & ln_ingocup>0, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("20`y'") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\F1_CFD_mignomig_20`y'.png, replace

}


*Man
foreach y in 07 12 17{
clear 

use ra_071217_years
cumul ln_ingocup [fw=fac] if  migest==0 & year==20`y' & ln_ingocup>0 & sex==1, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest==1 & year==20`y' & ln_ingocup>0 & sex==1, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("20`y'") subtitle("Migrants and non-migrants (Men)") legend(label(1 "Non migrant") label( 2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\F1_CFD_mignomig_men_20`y'.png, replace

}


*WoMan
foreach y in 07 12 17{
clear 

use ra_071217_years
cumul ln_ingocup [fw=fac] if  migest==0 & year==20`y' & ln_ingocup>0 & sex==2, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest==1 & year==20`y' & ln_ingocup>0 & sex==2, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("20`y'") subtitle("Migrants and non-migrants (Women)") legend(label(1 "Non migrant") label( 2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\F1_CFD_mignomig_women_20`y'.png, replace

}


////////////////////////////////////////////////////////////////////////////////
* prueba rural

*Rural
foreach y in 07 12 17{
clear 

use ra_071217_years
cumul ln_ingocup [fw=fac] if  migest==0 & year==20`y' & ln_ingocup>0 & rural==1, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest==1 & year==20`y' & ln_ingocup>0 & rural==1, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("20`y'") subtitle("Migrants and non-migrants (rural)") legend(label(1 "Non migrant") label( 2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\F1_CFD_mignomig_rural_20`y'.png, replace

}


*Urban
foreach y in 07 12 17{
clear 

use ra_071217_years
cumul ln_ingocup [fw=fac] if  migest==0 & year==20`y' & ln_ingocup>0 & rural==0, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest==1 & year==20`y' & ln_ingocup>0 & rural==0, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("20`y'") subtitle("Migrants and non-migrants (Urban)") legend(label(1 "Non migrant") label( 2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\F1_CFD_mignomig_urban_20`y'.png, replace

}




////////////////////////////////////////////////////////////////////////////////

* Figure I.1 - CDF graphs for risk averse 

foreach y in 07 12 17{
clear 

use ra_071217_years
cumul ln_ingocup [fw=fac] if  migest==0 & year==20`y' & ln_ingocup>0 & risk_averse==1, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest==1 & year==20`y' & ln_ingocup>0 & risk_averse==1, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Risk avese - 20`y'") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\F1_CFD_RA_mignomig_20`y'.png, replace

}

* Figure I.1 - CDF graphs for risk takers 
foreach y in 07 12 17{
clear 

use ra_071217_years
cumul ln_ingocup [fw=fac] if  migest==0 & year==20`y' & ln_ingocup>0 & risk_averse==0, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest==1 & year==20`y' & ln_ingocup>0 & risk_averse==0, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Risk takers - 20`y'") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\F1_CFD_RT_mignomig_20`y'.png, replace

}

////////////////////////////////////////////////////////////////////////////////

foreach y in 07 12 17{
clear 

use ra_071217_years
cumul ln_ingocup [fw=fac] if  migest==0 & year==20`y' & ln_ingocup>0 & risk_averse==1 & sex==2 , gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest==1 & year==20`y' & ln_ingocup>0 & risk_averse==1 & sex==2 , gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Risk avese - 20`y'") subtitle("Migrants and non-migrants (woman)" ) legend(label(1 "Non migrant") label( 2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\F1_CFD_women_RA_mignomig_20`y'.png, replace

}

* Figure I.1 - CDF graphs for risk takers 
foreach y in 07 12 17{
clear 

use ra_071217_years
cumul ln_ingocup [fw=fac] if  migest==0 & year==20`y' & ln_ingocup>0 & risk_averse==0 & sex==2, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest==1 & year==20`y' & ln_ingocup>0 & risk_averse==0 & sex==2, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Risk takers - 20`y'") subtitle("Migrants and non-migrants (woman)") legend(label(1 "Non migrant") label( 2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\F1_CFD_women_RT_mignomig_20`y'.png, replace

}



////////////////////////////////////////////////////////////////////////////////

clear 

use ra_071217_years



* figure II - first comparison between migrants and non migrants
foreach x in 15 25 35 45 55 65 75 85 95{
twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==2007, k(epan2) bw(.`x') legend(label(1 "Non migrant")) title("Kernel densities (2007)") ytitle("") xtitle("log monthly  income") xscale(range(0 15))  || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==2007, k(epan2) bw(.`x') legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))


graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\test_`x'_F2_KD_lningocup_07.png", replace
}
twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==2012, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (2012)") ytitle("") xtitle("log monthly income") xscale(range(0 15)) || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==2012, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_lningocup_12_VF.png", replace

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==2017, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (2017)") ytitle("") xtitle("log monthly income") xscale(range(0 15)) || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==2017, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_lningocup_17_VF.png", replace

* figure II.1 - first comparison between risk averse migrants and non migrants

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==2007 & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (2007)")  sub("Risk Averse") ytitle("") xtitle("log monthly income") xscale(range(0 15))  || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==2007 & risk_averse==1, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RA_lningocup_07_VF.png", replace

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==2012 & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (2012)")  sub("Risk Averse") ytitle("") xtitle("log monthly income") xscale(range(0 15)) || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==2012 & risk_averse==1, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RA_lningocup_12_VF.png", replace

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==2017 & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (2017)") sub("Risk Averse") ytitle("") xtitle("log monthly income") xscale(range(0 15)) || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==2017 & risk_averse==1, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RA_llningocup_17_VF.png", replace

* figure II.2 - first comparison between risk takers migrants and non migrants


twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==2007 & risk_averse==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (2007)")  sub("Risk Taker") ytitle("") xtitle("log monthly income") xscale(range(0 15))  || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==2007 & risk_averse==0, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RT_lningocup_07_VF.png", replace

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==2012 & risk_averse==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (2012)")  sub("Risk Taker") ytitle("") xtitle("log monthly income") xscale(range(0 15)) || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==2012 & risk_averse==0, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RT_lningocup_12_VF.png", replace

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==2017 & risk_averse==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (2017)") sub("Risk Taker") ytitle("") xtitle("log monthly income") xscale(range(0 15)) || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==2017 & risk_averse==0, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RT_lningocup_17_VF.png", replace


foreach y in 2007 2012 2017{
    
* gender

* figure II - first comparison between migrants and non migrants

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==`y' & sex==2, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Women Kernel densities (`y')") ytitle("") xtitle("log monthly income") xscale(range(0 15))  || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==`y' & sex==2, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_lningocup_women_`y'_VF.png", replace


* figure II.1 - first comparison between risk averse migrants and non migrants

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==`y' & sex==2 & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Women Kernel densities (`y')")  sub("Risk Averse") ytitle("") xtitle("log monthly income") xscale(range(0 15))  || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==`y' & sex==2 & risk_averse==1, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RA_lningocup_women_`y'_VF.png", replace


* figure II.2 - first comparison between risk takers migrants and non migrants


twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==`y' & sex==2  & risk_averse==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Women Kernel densities (`y')")  sub("Risk Taker") ytitle("") xtitle("log monthly income") xscale(range(0 15))  || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==`y' & sex==2  & risk_averse==0, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RT_lningocup_women_`y'_VF.png", replace
	
}

foreach y in 2007 2012 2017{
    
* Rural

* figure II - first comparison between migrants and non migrants

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==`y' & rural==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Urban Kernel densities (`y')") ytitle("") xtitle("log monthly income") xscale(range(0 15))  || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==`y' & rural==0, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_lningocup_urban_`y'_VF.png", replace


* figure II.1 - first comparison between risk averse migrants and non migrants

twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==`y' & rural==0 & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Urban Kernel densities (`y')")  sub("Risk Averse") ytitle("") xtitle("log monthly income") xscale(range(0 15))  || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==`y' & rural==0 & risk_averse==1, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RA_lningocup_urban_`y'_VF.png", replace


* figure II.2 - first comparison between risk takers migrants and non migrants


twoway kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==`y' & rural==0  & risk_averse==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Urban Kernel densities (`y')")  sub("Risk Taker") ytitle("") xtitle("log monthly income") xscale(range(0 15))  || kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==`y' & rural==0  & risk_averse==0, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F2_KD_RT_lningocup_urban_`y'_VF.png", replace
	
}



* figure III - Kernel densities difference 
clear 
cd D:\data\ENOE\Chpt_I_II\final\
use ra_071217_years

foreach y in 07 12 17{
kdensity ln_ingocup if ln_ingocup>0 & migest==0 & year==20`y', k(epan2) bw(1) generate(kxrt1_`y' kert1_`y')
kdensity ln_ingocup if ln_ingocup>0 & migest==1 & year==20`y', k(epan2) bw(1) generate(kxrt2_`y' kert2_`y')

gen kdenrest1_rt_`y'= kert2_`y' - kert1_`y'
tabstat  kxrt2_`y' , stats(mean p50 )
}

foreach y in 07 12 17{
	if `y'==07{
		line kdenrest1_rt_`y' kxrt2_`y', xline( 7.22  ) yline(0) ytitle("") title("K-densities difference") graphregion(color(white)) bgcolor(white)
	}
	if `y'==12 {
		line kdenrest1_rt_`y' kxrt2_`y', xline( 7.51  ) yline(0) ytitle("") title("K-densities difference") graphregion(color(white)) bgcolor(white)

	}
	if `y'==17{
		line kdenrest1_rt_`y' kxrt2_`y', xline(  7.98 ) yline(0) ytitle("") title("K-densities difference") graphregion(color(white)) bgcolor(white)
	}
graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\F3_KDDiff_all_`y'.jpg", replace
}


save ra_071217_years_VF.dta, replace

///////////////////////////////////////////////////////////////////////////////////////////////////////////
* observed and unobserved skills graphs\chpt_I\F1_CFD_RA_mignomig_20`y
clear
use ra_071217_years_VF.dta

eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural i.t_loc c.anios_esc c.eda i.rama i.gob_supp i.migest [fw=fac] 

foreach x in 2007 2012 2017{


eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if yr_`x'==1 & migest==0 , robust
predict obs_`x'nomig

eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if yr_`x'==1 & migest==1 , robust
predict obs_`x'mig

eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if yr_`x'==1 & migest==0 , robust
predict unobs_`x'nomig, residuals

eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if yr_`x'==1 & migest==1 , robust
predict unobs_`x'mig, residuals



eststo clear
}

foreach x in 2007 2012 2017{
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.gob_supp [fw=fac] if migest==0 & risk_averse==0, robust
predict unobs_`x'nomigrt, residuals
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.gob_supp [fw=fac] if migest==1 & risk_averse==0, robust
predict unobs_`x'migrt, residuals
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0 & risk_averse==1, robust
predict unobs_`x'nomigra, residuals
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if  migest==1 & risk_averse==1, robust
predict unobs_`x'migra, residuals

eststo clear
}

foreach x in 2007 2012 2017{

eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if yr_`x'==1 & migest==0 & risk_averse==0, robust
predict obs_`x'nomigrt
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if yr_`x'==1 & migest==1 & risk_averse==0, robust
predict obs_`x'migrt
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if yr_`x'==1 & migest==0 & risk_averse==1, robust
predict obs_`x'nomigra
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if yr_`x'==1 & migest==1 & risk_averse==1, robust
predict obs_`x'migra

eststo clear
}
* generales 
* observed all
foreach x in 2007 2012 2017{

twoway kdensity obs_`x'nomig [fw=fac] if  migest==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Observed residuals - `x' ") ytitle("") xtitle("") || kdensity obs_`x'mig [fw=fac] if  migest==1 & risk_averse==1,  k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\obs_skills_`x'.png", replace


}
foreach x in 2007 2012 2017{

twoway kdensity unobs_`x'nomig [fw=fac] if  migest==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Unobserved residuals - `x' ") ytitle("") xtitle("") || kdensity unobs_`x'mig [fw=fac] if  migest==1 & risk_averse==1,  k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\unobs_skills_`x'.png", replace


}
*risk averse
foreach x in 2007 2012 2017{

twoway kdensity obs_`x'nomigra [fw=fac] if  migest==0 & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Observed residuals (RA) - `x' ") ytitle("") xtitle("") || kdensity obs_`x'migra [fw=fac] if  migest==1 & risk_averse==1,  k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\ra_obs_skills_`x'.png", replace


}
////////////////////////////////////////////////////////////////////////////////

foreach x in 2007 2012 2017{

twoway kdensity unobs_`x'nomigra [fw=fac] if  migest==0 & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Unobserved residuals (RA) - `x' ") ytitle("") xtitle("") || kdensity unobs_`x'migra [fw=fac] if  migest==1 & risk_averse==1,  k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\ra_unobs_skills_`x'.png", replace


}

* risk takers
foreach x in 2007 2012 2017{

twoway kdensity obs_`x'nomigrt [fw=fac] if  migest==0 & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Observed residuals (RT) - `x' ") ytitle("") xtitle("") || kdensity obs_`x'migrt [fw=fac] if  migest==1 & risk_averse==1,  k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\rt_obs_skills_`x'.png", replace


}


foreach x in 2007 2012 2017{

twoway kdensity unobs_`x'nomigrt [fw=fac] if  migest==0 & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("Unobserved residuals (RT) - `x' ") ytitle("") xtitle("") || kdensity unobs_`x'migrt [fw=fac] if  migest==1 & risk_averse==1,  k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\chpt_I\graphs\rt_unobs_skills_`x'.png", replace


}


/////////////////////////////////////////////////////////////////////////////////

* differences in the kernell densities


* differences in kernel distributions
* all
eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0  
predict obs_nm_all
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1 
predict obs_m_all

kdensity obs_nm_all [fw=fac] if  migest==0 , generate(kxrt1 kert1) k(epan2) bw(1)
kdensity obs_m_all [fw=fac] if  migest==1 , generate(kxrt2 kert2) k(epan2) bw(1)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\all_gen_obs_diff.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

* 2007
eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0  & year==2007
predict obs_nm_all_2007
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1  & year==2007
predict obs_m_all_2007

kdensity obs_nm_all_2007 [fw=fac] if  migest==0  & year==2007, generate(kxrt1 kert1) k(epan2) bw(1)
kdensity obs_m_all_2007 [fw=fac] if  migest==1  & year==2007, generate(kxrt2 kert2) k(epan2) bw(1)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference 2007") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\all_gen_obs_diff_2007.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

* 2012
eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0  & year==2012
predict obs_nm_all_2012
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1  & year==2012
predict obs_m_all_2012

kdensity obs_nm_all_2012 [fw=fac] if  migest==0  & year==2012, generate(kxrt1 kert1) k(epan2) bw(1)
kdensity obs_m_all_2012 [fw=fac] if  migest==1  & year==2012, generate(kxrt2 kert2) k(epan2) bw(1)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference 2012") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\all_gen_obs_diff_2012.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

* 2017
eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0  & year==2017
predict obs_nm_all_2017
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1  & year==2017
predict obs_m_all_2017

kdensity obs_nm_all_2017 [fw=fac] if  migest==0  & year==2017, generate(kxrt1 kert1) k(epan2) bw(1)
kdensity obs_m_all_2017 [fw=fac] if  migest==1  & year==2017, generate(kxrt2 kert2) k(epan2) bw(1)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference 2017") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\all_gen_obs_diff_2017.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt













* all risk averse

eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0 & risk_averse==1
predict ra_obs_nm_all
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1 & risk_averse==1
predict ra_obs_m_all

kdensity ra_obs_nm_all [fw=fac] if  migest==0 & risk_averse==1 , generate(kxrt1 kert1) k(epan2) bw(1)
kdensity ra_obs_m_all [fw=fac] if  migest==1 & risk_averse==1 , generate(kxrt2 kert2) k(epan2) bw(1)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 mean )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\RA_gen_obs_diff.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt



* all risk takers

eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0 & risk_averse==0
predict rt_obs_nm_all
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1 & risk_averse==0
predict rt_obs_m_all

kdensity rt_obs_nm_all [fw=fac] if  migest==0 & risk_averse==0 , generate(kxrt1 kert1) k(epan2) bw(1)
kdensity rt_obs_m_all [fw=fac] if  migest==1 & risk_averse==0 , generate(kxrt2 kert2) k(epan2) bw(1)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 )

line kdenrest1_rt kxrt2, ytitle("") title("K-densities difference (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\RT_gen_obs_diff.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt







* risk averse by year




* 2007

eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0 & risk_averse==1 & year==2007
predict ra_obs_nm_all_2007
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1 & risk_averse==1 & year==2007
predict ra_obs_m_all_2007

kdensity ra_obs_nm_all_2007 [fw=fac] if  migest==0 & risk_averse==1 & year==2007 , generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity ra_obs_m_all_2007 [fw=fac] if  migest==1 & risk_averse==1 & year==2007 , generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 mean )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference 2007 (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\RA_gen_obs_diff_2007.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

* 2012 

eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0 & risk_averse==1 & year==2012
predict ra_obs_nm_all_2012
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1 & risk_averse==1 & year==2012
predict ra_obs_m_all_2012

kdensity ra_obs_nm_all_2012 [fw=fac] if  migest==0 & risk_averse==1 & year==2012 , generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity ra_obs_m_all_2012 [fw=fac] if  migest==1 & risk_averse==1 & year==2012 , generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 mean )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference 2012 (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\RA_gen_obs_diff_2012.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

*2017

eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0 & risk_averse==1 & year==2017
predict ra_obs_nm_all_2017
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1 & risk_averse==1 & year==2017
predict ra_obs_m_all_2017

kdensity ra_obs_nm_all_2017 [fw=fac] if  migest==0 & risk_averse==1 & year==2017 , generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity ra_obs_m_all_2017 [fw=fac] if  migest==1 & risk_averse==1 & year==2017 , generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 mean )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference 2017 (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\RA_gen_obs_diff_2017.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt











* risk takers by year


* 2007

eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0 & risk_averse==0 & year==2007
predict rt_obs_nm_all_2007
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1 & risk_averse==0 & year==2007
predict rt_obs_m_all_2007

kdensity rt_obs_nm_all_2007 [fw=fac] if  migest==0 & risk_averse==0 & year==2007 , generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity rt_obs_m_all_2007 [fw=fac] if  migest==1 & risk_averse==0 & year==2007 , generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 mean )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference 2007 (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\RT_gen_obs_diff_2007.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

* 2012 

eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0 & risk_averse==0 & year==2012
predict rt_obs_nm_all_2012
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1 & risk_averse==0 & year==2012
predict rt_obs_m_all_2012

kdensity rt_obs_nm_all_2012 [fw=fac] if  migest==0 & risk_averse==0 & year==2012 , generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity rt_obs_m_all_2012 [fw=fac] if  migest==1 & risk_averse==0 & year==2012 , generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 mean )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference 2012 (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\RT_gen_obs_diff_2012.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

*2017

eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==0 & risk_averse==0 & year==2017
predict rt_obs_nm_all_2017
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda [fw=fac] if migest==1 & risk_averse==0 & year==2017
predict rt_obs_m_all_2017

kdensity rt_obs_nm_all_2017 [fw=fac] if  migest==0 & risk_averse==0 & year==2017 , generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity rt_obs_m_all_2017 [fw=fac] if  migest==1 & risk_averse==0 & year==2017 , generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat  kxrt2 , stats(p50 mean )

line kdenrest1_rt kxrt2,  ytitle("") title("K-densities difference 2017 (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\RT_gen_obs_diff_2017.png, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt



* observed and unobserved skills
eststo clear

foreach x in 2007 2012 2017{
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural i.t_loc c.anios_esc c.eda i.rama i.gob_supp i.migest [fw=fac] if yr_`x'==1 & migest==0 & risk_averse==0, robust
predict unobs_`x'nomigrt, residuals
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural i.t_loc c.anios_esc c.eda i.rama i.gob_supp i.migest [fw=fac] if yr_`x'==1 & migest==0 & risk_averse==1, robust
predict unobs_`x'nomigra, residuals
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural i.t_loc c.anios_esc c.eda i.rama i.gob_supp i.migest [fw=fac] if yr_`x'==1 & migest==1 & risk_averse==0, robust
predict unobs_`x'migrt, residuals
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural i.t_loc c.anios_esc c.eda i.rama i.gob_supp i.migest [fw=fac] if yr_`x'==1 & migest==1 & risk_averse==1, robust
predict unobs_`x'migra, residuals


}

foreach x in 2007 2012 2017{

eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural i.t_loc c.anios_esc c.eda i.rama i.gob_supp i.migest [fw=fac] if yr_`x'==1 & migest==0 & risk_averse==0, robust
predict obs_`x'nomigrt
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural i.t_loc c.anios_esc c.eda i.rama i.gob_supp i.migest [fw=fac] if yr_`x'==1 & migest==0 & risk_averse==1, robust
predict obs_`x'nomigra
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural i.t_loc c.anios_esc c.eda i.rama i.gob_supp i.migest [fw=fac] if yr_`x'==1 & migest==1 & risk_averse==0, robust
predict obs_`x'migrt
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural i.t_loc c.anios_esc c.eda i.rama i.gob_supp i.migest [fw=fac] if yr_`x'==1 & migest==1 & risk_averse==1, robust
predict obs_`x'migra


}

* observed skills graphs
foreach x in 2007 2012 2017{

twoway kdensity obs_`x'nomigrt [fw=fac] if  migest==0 & risk_averse==0, k(epan2) bw(.5) legend(label(1 "Non migrant")) title(" Observed residuals (RT) - `x' ") ytitle("") xtitle("") || kdensity obs_`x'migrt [fw=fac] if  migest==1 & risk_averse==0,  k(epan2) bw(.5) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\rt_obs_skills_`x'.jpg, replace


}
*risk averse
foreach x in 2007 2012 2017{

twoway kdensity obs_`x'nomigra [fw=fac] if  migest==0 & risk_averse==1, k(epan2) bw(.15) legend(label(1 "Non migrant")) title(" Observed residuals (RA) - `x' ") ytitle("") xtitle("") || kdensity obs_`x'migra [fw=fac] if  migest==1 & risk_averse==1,  k(epan2) bw(.15) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\ra_obs_skills_`x'.jpg, replace


}

* Unobserved graphs
foreach x in 2007 2012 2017{

twoway kdensity unobs_`x'nomigrt [fw=fac] if  migest==0 & sex==2 & risk_averse==0, k(epan2) bw(.15) legend(label(1 "Non migrant")) title("Unobserved residuals (RT) - `x' ") ytitle("") xtitle("") || kdensity unobs_`x'migrt [fw=fac] if  migest==1 & sex==2 & risk_averse==0,  k(epan2) bw(.15) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\rt_unobs_skills_`x'.jpg, replace


}
*risk averse
foreach x in 2007 2012 2017{

twoway kdensity unobs_`x'nomigra [fw=fac] if  migest==0 & sex==2 & risk_averse==1, k(epan2) bw(.15) legend(label(1 "Non migrant")) title("Unobserved residuals (RA) - `x' ") ytitle("") xtitle("") || kdensity unobs_`x'migra [fw=fac] if  migest==1 & sex==2 & risk_averse==1, k(epan2) bw(.15)  legend(label(2 "Migrant"))

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\ra__unobs_skills_`x'.jpg, replace


}

**************** Observed skills (risk takers)

* 2007
kdensity obs_2007nomigrt [fw=fac] if  migest==0 & risk_averse==0 & year==2007, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity obs_2007migrt [fw=fac] if  migest==1 & risk_averse==0 & year==2007, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2, ytitle("") title("Observed skills difference 2007 (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\rt_obs_diff_2007.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

* 2012

kdensity obs_2012nomigrt [fw=fac] if  migest==0 & risk_averse==0 & year==2012, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity obs_2012migrt [fw=fac] if  migest==1 & risk_averse==0 & year==2012, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2,  ytitle("") title(" Observed skills difference 2012 (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\rt_obs_diff_2012.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

*2017

kdensity obs_2017nomigrt [fw=fac] if  migest==0 & risk_averse==0 & year==2017, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity obs_2017migrt [fw=fac] if  migest==1 & risk_averse==0 & year==2017, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2,  ytitle("") title("Observed skills difference 2017 (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\rt_obs_diff_2017.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

****************Observed skills - risk averse

* 2007
kdensity obs_2007nomigra [fw=fac] if  migest==0 & risk_averse==1 & year==2007, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity obs_2007migra [fw=fac] if  migest==1 & risk_averse==1 & year==2007, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2,  ytitle("") title(" Observed skills difference 2007 (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\ra_obs_diff_2007.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

* 2012

kdensity obs_2012nomigra [fw=fac] if  migest==0 & risk_averse==1 & year==2012, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity obs_2012migra [fw=fac] if  migest==1 & risk_averse==1 & year==2012, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2,  ytitle("") title("Observed skills difference 2012 (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\ra_obs_diff_2012.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

*2017

kdensity obs_2017nomigra [fw=fac] if  migest==0 & risk_averse==1 & year==2017, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity obs_2017migra [fw=fac] if  migest==1 & risk_averse==1 & year==2017, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2,  ytitle("") title("Observed skills difference 2017 (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\ra_obs_diff_2017.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt




////////////////////////////////////////////////////////////////////////////////

**************** Unobserved skills (risk takers)

* 2007
kdensity unobs_2007nomigrt [fw=fac] if  migest==0 & risk_averse==0 & year==2007, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity unobs_2007migrt [fw=fac] if  migest==1 & risk_averse==0 & year==2007, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2 ,  ytitle("") title("Unobserved skills difference 2007 (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\rt_unobs_diff_2007.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

* 2012

kdensity unobs_2012nomigrt [fw=fac] if  migest==0 & risk_averse==0 & year==2012, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity unobs_2012migrt [fw=fac] if  migest==1 & risk_averse==0 & year==2012, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2 ,  ytitle("") title(" Unobserved skills difference 2012 (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\rt_unobs_diff_2012.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

*2017

kdensity unobs_2017nomigrt [fw=fac] if  migest==0 & risk_averse==0 & year==2017, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity unobs_2017migrt [fw=fac] if  migest==1 & risk_averse==0 & year==2017, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2,  ytitle("") title("Unobserved skills difference 2017 (RT)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\rt_unobs_diff_2017.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

****************Unobserved skills - risk averse

* 2007
kdensity unobs_2007nomigra [fw=fac] if  migest==0 & risk_averse==1 & year==2007 , generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity unobs_2007migra [fw=fac] if  migest==1 & risk_averse==1 & year==2007 , generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2 ,  ytitle("") title(" Unobserved skills difference 2007 (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\ra_unobs_diff_2007.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

* 2012

kdensity unobs_2012nomigra [fw=fac] if  migest==0 & risk_averse==1 & year==2012, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity unobs_2012migra [fw=fac] if  migest==1 & risk_averse==1 & year==2012, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2 ,  ytitle("") title("Unobserved skills difference 2012 (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\ra_unobs_diff_2012.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt

*2017

kdensity unobs_2017nomigra [fw=fac] if  migest==0 & risk_averse==1 & year==2017, generate(kxrt1 kert1) k(epan2) bw(.15)
kdensity unobs_2017migra [fw=fac] if  migest==1 & risk_averse==1 & year==2017, generate(kxrt2 kert2) k(epan2) bw(.15)

gen kdenrest1_rt= kert2 - kert1
tabstat kdenrest1_rt kxrt2 kert1, stats(p50 )
line kdenrest1_rt kxrt2 ,  ytitle("") title("Unobserved skills difference 2017 (RA)") graphregion(color(white)) bgcolor(white)

graph export D:\doctorado\respuesta_tesis\chpt_I\graphs\ra_unobs_diff_2017.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt
