clear
set more off, permanently

log close _all

cd D:\data\ENOE\paper_1\raw_a1\paneles

log using desc_stats_V1.log, replace
 



*xtset key_var time


* frecuencies of migration estrategies


clear
local years 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017
foreach x of local years{

	use ra_`x'Q4
	sum year
	

	*tab migest_30 sex, chi2
	*tab migest_30 sex [fw=fac] , chi2
	
	
	*mean anios_esc if year==`x' & migest_30==0 & risk_averse==0 & sex==1
	*mean anios_esc if year==`x' & migest_30==1 & risk_averse==0 & sex==1
	
	*mean anios_esc if year==`x' & migest_30==0 & risk_averse==1 & sex==1
	*mean anios_esc if year==`x' & migest_30==1 & risk_averse==1 & sex==1
	
	*mean anios_esc if year==`x' & migest_30==0 & risk_averse==0 & sex==2
	*mean anios_esc if year==`x' & migest_30==1 & risk_averse==0 & sex==2
	
	*mean anios_esc if year==`x' & migest_30==0 & risk_averse==1 & sex==2
	*mean anios_esc if year==`x' & migest_30==1 & risk_averse==1 & sex==2
	
	*logit migest_30 ln_ingocup i.risk_averse i.sex i.rural i.cs_p13_1 
	

	save, replace
clear	
}


*fisrt table 
* general table

gen wage_earners=0
replace wage_earners=1 if ingocup>0

foreach x in {
prop migest_30 [fw=fac] if year==`x'
prop migest_30 if sex==1 & year==`x'
prop migest_30 if sex==2 & year==`x'

prop migest_30 [fw=fac] if year==`x'

prop sex [fw= fac] if migest_30==0 & year==`x'
prop sex [fw= fac] if migest_30==1 & year==`x'

mean eda [fw= fac] if sex==2 & migest_30==0 & year==`x'
mean eda [fw= fac] if sex==2 & migest_30==1 & year==`x'

mean eda [fw= fac] if sex==1 & migest_30==0 & year==`x'
mean eda [fw= fac] if sex==1 & migest_30==1 & year==`x'


tabstat eda  if sex==2 & migest_30==0 & year==`x', stats(N p50 min max)
tabstat eda  if sex==2 & migest_30==1 & year==`x', stats(N p50 min max)

tabstat eda  if sex==1 & migest_30==0 & year==`x', stats(N p50 min max)
tabstat eda  if sex==1 & migest_30==1 & year==`x', stats(N p50 min max)


prop rural [fw=fac] if sex==2 & migest_30==0 & year==`x'
prop rural [fw=fac] if sex==2 & migest_30==1 & year==`x'

prop rural [fw=fac] if sex==1 & migest_30==0 & year==`x'
prop rural [fw=fac] if sex==1 & migest_30==1 & year==`x'


mean anios_esc [fw= fac] if sex==2 & migest_30==0 & year==`x'
mean anios_esc [fw= fac] if sex==2 & migest_30==1 & year==`x'

mean anios_esc [fw= fac] if sex==1 & migest_30==0 & year==`x'
mean anios_esc [fw= fac] if sex==1 & migest_30==1 & year==`x'


prop clase2 [fw=fac] if sex==2 & migest_30==0 & year==`x'
prop clase2 [fw=fac] if sex==2 & migest_30==1 & year==`x'

prop clase2 [fw=fac] if sex==1 & migest_30==0 & year==`x'
prop clase2 [fw=fac] if sex==1 & migest_30==1 & year==`x'



prop wage_earners [fw=fac] if sex==2 & migest_30==0 & year==`x'
prop wage_earners [fw=fac] if sex==2 & migest_30==1 & year==`x'

prop wage_earners [fw=fac] if sex==1 & migest_30==0 & year==`x'
prop wage_earners [fw=fac] if sex==1 & migest_30==1 & year==`x'

mean ing_x_hrs [fw= fac] if sex==2 & migest_30==0 & year==`x'
mean ing_x_hrs [fw= fac] if sex==2 & migest_30==1 & year==`x'

mean ing_x_hrs [fw= fac] if sex==1 & migest_30==0 & year==`x'
mean ing_x_hrs [fw= fac] if sex==1 & migest_30==1 & year==`x'

}

tab migest_30 risk_averse  if sex==2 & year==2007 
tab migest_30 risk_averse  if sex==1 & year==2007 


tab migest_30 risk_averse  if sex==2 & year==2011
tab migest_30 risk_averse  if sex==1 & year==2011

tab migest_30 risk_averse  if sex==2 & year==2017
tab migest_30 risk_averse  if sex==1 & year==2017 



* table for risk lovers and risk averse individuals


prop sex [fw= fac] if migest_30==0 & risk_averse==0
prop sex [fw= fac] if migest_30==1 & risk_averse==0

mean eda [fw= fac] if sex==2 & migest_30==0 & risk_averse==0
mean eda [fw= fac] if sex==2 & migest_30==1 & risk_averse==0

mean eda [fw= fac] if sex==1 & migest_30==0 & risk_averse==0
mean eda [fw= fac] if sex==1 & migest_30==1 & risk_averse==0


tabstat eda if sex==2 & migest_30==0 & risk_averse==0, stats(N p50 min max)
tabstat eda if sex==2 & migest_30==1 & risk_averse==0, stats(N p50 min max)

tabstat eda if sex==1 & migest_30==0 & risk_averse==0, stats(N p50 min max)
tabstat eda if sex==1 & migest_30==1 & risk_averse==0, stats(N p50 min max)


prop rural if sex==2 & migest_30==0 & risk_averse==0
prop rural if sex==2 & migest_30==1 & risk_averse==0

prop rural if sex==1 & migest_30==0 & risk_averse==0
prop rural if sex==1 & migest_30==1 & risk_averse==0

mean anios_esc [fw= fac] if sex==2 & migest_30==0 & risk_averse==0
mean anios_esc [fw= fac] if sex==2 & migest_30==1 & risk_averse==0

mean anios_esc [fw= fac] if sex==1 & migest_30==0 & risk_averse==0
mean anios_esc [fw= fac] if sex==1 & migest_30==1 & risk_averse==0


mean ing_x_hrs [fw= fac] if sex==2 & migest_30==0 & risk_averse==0
mean ing_x_hrs [fw= fac] if sex==2 & migest_30==1 & risk_averse==0

mean ing_x_hrs [fw= fac] if sex==1 & migest_30==0 & risk_averse==0
mean ing_x_hrs [fw= fac] if sex==1 & migest_30==1 & risk_averse==0



* comparaqción escolaridad y grupos de edad

tab cs_p13_1 eda7c if migest_30==0
tab cs_p13_1 eda7c if migest_30==1

tab cs_p13_1 eda7c if migest_30==0 & sex==1
tab cs_p13_1 eda7c if migest_30==1 & sex==1

tab cs_p13_1 eda7c if migest_30==0 & sex==2
tab cs_p13_1 eda7c if migest_30==1 & sex==2


tab cs_p13_1 eda7c if migest_30==0 & risk_averse==1
tab cs_p13_1 eda7c if migest_30==1 & risk_averse==1

tab cs_p13_1 eda7c if migest_30==0 & sex==1 & risk_averse==1
tab cs_p13_1 eda7c if migest_30==1 & sex==1 & risk_averse==1

tab cs_p13_1 eda7c if migest_30==0 & sex==2 & risk_averse==1
tab cs_p13_1 eda7c if migest_30==1 & sex==2 & risk_averse==1

tab cs_p13_1 eda7c if migest_30==0 & risk_averse==0
tab cs_p13_1 eda7c if migest_30==1 & risk_averse==0

tab cs_p13_1 eda7c if migest_30==0 & sex==1 & risk_averse==0
tab cs_p13_1 eda7c if migest_30==1 & sex==1 & risk_averse==0

tab cs_p13_1 eda7c if migest_30==0 & sex==2 & risk_averse==0
tab cs_p13_1 eda7c if migest_30==1 & sex==2 & risk_averse==0

clear 
set more off, permanently
use ra_07_17_Q4

*gen ln_ingocup=ln(ingocup)
cumul ln_ingocup  if  migest_30==0 & sex==1 & risk_averse==1, gen(ra_nm_lning) 
cumul ln_ingocup  if  migest_30==1 & sex==1 & risk_averse==1, gen(ra_m_lning) 

stack ra_nm_lning ln_ingocup ra_m_lning ln_ingocup, into(c ln_ing) clear

line ra_nm_lning  ra_m_lning ln_ing

title("Income distribution (Log)") subtitle("2007 - 2017")  || cumul ln_ingocup  if  migest_30==1 & sex==1 & risk_averse==1



clear
use ra_07_17_Q4

ksmirnov anios_esc if  risk_averse==1 & sex==1, by(migest_30) 
ksmirnov anios_esc if  risk_averse==0 & sex==1, by(migest_30) 
ksmirnov anios_esc if  risk_averse==1 & sex==2, by(migest_30) 
ksmirnov anios_esc if  risk_averse==0 & sex==2, by(migest_30) 


gen edo_mig=0
replace edo_mig=1 if ent==14 | ent==16 | ent==11 | ent==30 | ent==15 | ent==2 | ent==8 | ent==20 | ent==12 | ent==21 | ent==13 | ent==26 | ent==32
* los diez estados con mas numero de migrantes registrados a EEUU: 14 Jalisco 16 Michoacán de Ocampo 11 Guanajuato 30 Veracruz de Ignacio de la Llave 15 México 02 Baja California 08 Chihuahua 20 Oaxaca 12 Guerrero 21 Puebla 13 Hidalgo 26 Sonora (source: https://www.inegi.org.mx/programas/ccpv/2010/#Tabulados)

gen familia=0
replace familia=1 if n_hij>0

gen apoyo_gob=0
replace apoyo_gob=1 if p14apoyos==1

gen married=0
replace married=1 if e_con==5



gen ln_ing_x_hrs=ln(ing_x_hrs)


label define migracion 0 "No mig" 1 "Mig"
label values migest_30 migracion

label define genero 1 "Male" 2 "Female"
label values sex genero

label define aversion 0 "Risk taker" 1 "Risk averse"
label values risk_averse aversion


foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
gen yr_`x'=0
replace yr_`x'=1 if year==`x'



}



save , replace

clear 
use ra_07_17_Q4


* skills vs risk aversion

foreach x in 1 5 11{
sum panel if panel==`x'	
	
mean anios_esc if migest_30==0 & panel==`x'
mean anios_esc if migest_30==1 & panel==`x'


mean anios_esc if migest_30==0 & panel==`x' & sex==1
mean anios_esc if migest_30==1 & panel==`x' & sex==1
mean anios_esc if migest_30==0 & panel==`x' & sex==2
mean anios_esc if migest_30==1 & panel==`x' & sex==2


mean anios_esc if migest_30==0 & panel==`x' & sex==1 & risk_averse==1
mean anios_esc if migest_30==1 & panel==`x' & sex==1 & risk_averse==1
mean anios_esc if migest_30==0 & panel==`x' & sex==2 & risk_averse==1
mean anios_esc if migest_30==1 & panel==`x' & sex==2 & risk_averse==1

mean anios_esc if migest_30==0 & panel==`x' & sex==1 & risk_averse==0
mean anios_esc if migest_30==1 & panel==`x' & sex==1 & risk_averse==0
mean anios_esc if migest_30==0 & panel==`x' & sex==2 & risk_averse==0
mean anios_esc if migest_30==1 & panel==`x' & sex==2 & risk_averse==0

}


foreach x in 1 {
sum panel if panel==`x'		
ksmirnov anios_esc if  risk_averse==1 & sex==1 & panel==`x', by(migest_30) 
ksmirnov anios_esc if  risk_averse==0 & sex==1 & panel==`x', by(migest_30) 
ksmirnov anios_esc if  risk_averse==1 & sex==2 & panel==`x', by(migest_30) 
ksmirnov anios_esc if  risk_averse==0 & sex==2 & panel==`x', by(migest_30) 

}


foreach x in 1 {
sum panel if panel==`x'		
ksmirnov ln_ing_x_hrs if  risk_averse==1 & sex==1 & panel==`x', by(migest_30) 
ksmirnov ln_ing_x_hrs if  risk_averse==0 & sex==1 & panel==`x', by(migest_30) 
ksmirnov ln_ing_x_hrs if  risk_averse==1 & sex==2 & panel==`x', by(migest_30) 
ksmirnov ln_ing_x_hrs if  risk_averse==0 & sex==2 & panel==`x', by(migest_30) 

}



foreach x in 1 {
sum panel if panel==`x'		
ksmirnov ln_ing_x_hrs if  risk_averse==1 & sex==1 & panel==`x', by(migest_30) 
ksmirnov ln_ing_x_hrs if  risk_averse==0 & sex==1 & panel==`x', by(migest_30) 
ksmirnov ln_ing_x_hrs if  risk_averse==1 & sex==2 & panel==`x', by(migest_30) 
ksmirnov ln_ing_x_hrs if  risk_averse==0 & sex==2 & panel==`x', by(migest_30) 

}

twoway kdensity ln_ing_x_hrs if migest_30==0 , k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income p/hour")|| kdensity ln_ing_x_hrs if migest_30==1 , k(ep) legend(label(2 "Migrant"))


twoway kdensity ln_ingocup if migest_30==0 , k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("Income p/hour")|| kdensity ln_ingocup if migest_30==1 , k(ep) legend(label(2 "Migrant"))



/*
kdensity ln_ing_x_hrs if migest_30==0 , k(ep) legend(label(1 "Non migrant")) generate(p_nomig_all d_nomig_all)
kdensity ln_ing_x_hrs if migest_30==1 , k(ep) legend(label(2 "Migrant")) generate(p_mig_all d_mig_all)



kdensity ln_ingocup if migest_30==0 , k(ep) legend(label(1 "Non migrant")) generate(p_nomig_all d_nomig_all)
kdensity ln_ingocup if migest_30==1 , k(ep) legend(label(2 "Migrant")) generate(p_mig_all d_mig_all)


gen d_den_all= d_mig_all - d_nomig_all
gen p_den_all= p_mig_all - p_nomig_all

egen median_ln_ingxhrs=median(ln_ing_x_hrs)

line d_mig_all p_mig_all
line d_nomig_all p_nomig_all

twoway line d_mig_all p_mig_all || line d_nomig_all p_nomig_all

twoway line d_nomig_all p_nomig_all, legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income p/hour")|| line d_mig_all p_mig_all, legend(label(2 "Migrant"))


line d_den_all p_den_all 

*/

twoway kdensity ln_ing_x_hrs if migest_30==0 , k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income p/hour")|| kdensity ln_ing_x_hrs if migest_30==1 , k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\lningxhr_mignomig.jpg, replace 

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
gen yr_`x'=0
replace yr_`x'=1 if year==`x'
twoway kdensity ln_ing_x_hrs if migest_30==0 & yr_`x'==1, k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income p/hour")|| kdensity ln_ing_x_hrs if migest_30==1 & yr_`x'==1, k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\lningxhr_mignomig_`x'.jpg, replace 




}






twoway kdensity ln_ingocup if migest_30==0 , k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income")|| kdensity ln_ingocup if migest_30==1 , k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\ln_ingocup_mignomig.jpg, replace 

kdensity ln_ingocup if migest_30==0 , k(ep) generate(knmmX knmmeY)
kdensity ln_ingocup if migest_30==1 , k(ep) generate(kmmX kmmeY)
gen kres=kmmeY-knmmeY
sum kmmX
tabstat kmmX, stats(p50 mean)

twoway line kres kmmX , xline(7.201648 , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference") xtitle("Log monthly income")

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ingocup_mignomig.jpg, replace 



foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
kdensity ln_ingocup if migest_30==0 & yr_`x'==1, k(ep) generate(knmmX_`x' knmmeY_`x')
kdensity ln_ingocup if migest_30==1 & yr_`x'==1, k(ep) generate(kmmX_`x' kmmeY_`x')
gen kres_`x'=kmmeY_`x'-knmmeY_`x'
sum kmmX_`x' 

}

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
tabstat kmmX_`x', stats(p50 mean)
}


twoway line kres_2007 kmmX_2007 , xline(7.201648 , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2007") xtitle("Log monthly income")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ingocup_mignomig_2007.jpg, replace 

twoway line kres_2012 kmmX_2012 , xline(7.915207 , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2012") xtitle("Log monthly income")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ingocup_mignomig_2012.jpg, replace 


twoway line kres_2017 kmmX_2017 , xline(7.983636  , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2017") xtitle("Log monthly income")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ingocup_mignomig_2017.jpg, replace 





foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
	
	
twoway kdensity ln_ingocup if migest_30==0 & yr_`x'==1, k(ep) legend(label(1 "Non migrant")) title("Kernel densities `x'") ytitle("") xtitle("log income") || kdensity ln_ingocup if migest_30==1 & yr_`x'==1, k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\ln_ingocup_mignomig_`x'.jpg, replace 

}







foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
kdensity ln_ing_x_hrs if migest_30==0 & yr_`x'==1, k(ep) generate(knmmX_ixh_`x' knmmeY_ixh_`x')
kdensity ln_ing_x_hrs if migest_30==1 & yr_`x'==1, k(ep) generate(kmmX_ixh_`x' kmmeY_ixh_`x')
gen kresixh_`x'=kmmeY_ixh_`x'-knmmeY_ixh_`x'
sum kmmX_ixh_`x' 

}

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
tabstat kmmX_ixh_`x', stats(p50 mean)
}


twoway line kresixh_2007 kmmX_ixh_2007 , xline(2.430681 , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2007") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2007.jpg, replace 

twoway line kresixh_2008 kmmX_ixh_2008 , xline(2.566643  , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2008") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2008.jpg, replace 

twoway line kresixh_2009 kmmX_ixh_2009 , xline(2.740374  , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2009") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2009.jpg, replace 

twoway line kresixh_2010 kmmX_ixh_2010 , xline(2.309567  , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2010") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2010.jpg, replace 

twoway line kresixh_2011 kmmX_ixh_2011 , xline(2.473819 , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2011") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2011.jpg, replace 

twoway line kresixh_2012 kmmX_ixh_2012 , xline(3.520886  , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2012") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2012.jpg, replace 

twoway line kresixh_2013 kmmX_ixh_2013 , xline(3.050639 , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2013") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2013.jpg, replace 

twoway line kresixh_2014 kmmX_ixh_2014 , xline(2.276955 , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2014") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2014.jpg, replace 

twoway line kresixh_2015 kmmX_ixh_2015 , xline(3.032463 , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2015") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2015.jpg, replace 

twoway line kresixh_2016 kmmX_ixh_2016 , xline(2.185367  , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2016") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2016.jpg, replace 

twoway line kresixh_2017 kmmX_ixh_2017 , xline(2.681063    , lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )  ytitle("Density difference 2017") xtitle("Log income p/hour")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\DIFF_ln_ing_x_hrs_mignomig_2017.jpg, replace 



foreach x in 2007 2012 2017{
	
	
twoway kdensity ln_ing_x_hrs if migest_30==0 & yr_`x'==1, k(ep) legend(label(1 "Non migrant")) title("Kernel densities `x'") ytitle("") xtitle("log income p/hour") || kdensity ln_ing_x_hrs if migest_30==1 & yr_`x'==1, k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\ln_ing_x_hrs_mignomig_`x'.jpg, replace 

}





gen ln_ingocup=ln(ingocup)

egen mean_ln_ingocup= mean(ln_ingocup), by(year)
gen r_ln_ingocup=ln_ingocup/mean_ln_ingocup

sum ln_ingocup, meanonly
gen n_ln_ingocup = (ln_ingocup - r(min)) / (r(max) - r(min)) 
gen ln_n_ingocup=ln(n_ingocup)

twoway kdensity ln_ingocup if migest_30==0 & panel_cp1==1 & sex==1 , k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income p/hour") xline(8.470196, lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) ) || kdensity ln_ingocup if migest_30==1 & panel_cp1==1 & sex==1, k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\ln_ingocup_mignomig_male.jpg, replace 


kdensity ln_ingocup if migest_30==0 & panel_cp1==1 & sex==1, k(ep) generate(knmmX knmmeY)
kdensity ln_ingocup if migest_30==1 & panel_cp1==1 & sex==1, k(ep) generate(kmmX kmmeY)

gen kres=kmmX-knmmX

twoway line  kmmeY kres, xline(8.189514, lwidth(thin) lcolor(red) ) yline(0, lwidth(thin) lcolor(red) )

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
	
	
twoway kdensity ln_ingocup if migest_30==0 & yr_`x'==1 & sex==1, k(ep) legend(label(1 "Non migrant")) title("Kernel densities `x'") ytitle("") xtitle("log income p/hour") || kdensity ln_ingocup if migest_30==1 & yr_`x'==1 & sex==1, k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\ln_ingocup_mignomig_male_`x'.jpg, replace 

}

twoway kdensity ln_ingocup if migest_30==0 & panel_cp1==1 & sex==2, k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income p/hour") yline(|| kdensity ln_ingocup if migest_30==1 & panel_cp1==1 & sex==2, k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\ln_ingocup_mignomig_female.jpg, replace 

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
	 
	
twoway kdensity ln_ingocup if migest_30==0 & yr_`x'==1 & sex==2, k(ep) legend(label(1 "Non migrant")) title("Kernel densities `x'") ytitle("") xtitle("log income p/hour") || kdensity ln_ingocup if migest_30==1 & yr_`x'==1 & sex==2, k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\ln_ingocup_mignomig_female_`x'.jpg, replace 

}


twoway kdensity ln_ingocup if migest_30==0 & sex==2, k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income p/hour")|| kdensity ln_ingocup if migest_30==1 & sex==2, k(ep) legend(label(2 "Migrant"))


* introduction graphs



graph box ing_x_hrs [fw=fac] if  ing_x_hrs>0, over(sex) over(year) over(migest_30)  medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\boxgraph_noout_wage_mig_VF.jpg, replace

graph box ing_x_hrs [fw=fac] if  ing_x_hrs>0 & migest_30==0, over(sex) over(year) over(risk_averse) medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\boxgraph_noout_wage_nomig_ra_VF.jpg, replace

graph box ing_x_hrs [fw=fac] if  ing_x_hrs>0 & migest_30==1, over(sex) over(year) over(risk_averse) medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\boxgraph_noout_wage_mig_ra_VF.jpg, replace





foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
    
graph box ing_x_hrs [fw=fac] if sex==1 & anios_esc<99 & yr_`x'==1 , over(migest_30) over(risk_averse) medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc))  noout

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\boxgraph_noout_wage_mig_ra_male_`x'.jpg, replace


graph box ing_x_hrs [fw=fac] if sex==2 & anios_esc<99 & yr_`x'==1 ,  over(year) over(migest_30) over(risk_averse) medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc))  noout

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\boxgraph_noout_wage_mig_ra_female_`x'.jpg, replace


}











/*eststo clear

eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob  if migest_30==0 & risk_averse==0 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob   if migest_30==1 & risk_averse==0 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob   if migest_30==0 & risk_averse==1 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob   if migest_30==1 & risk_averse==1 

eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007 if migest_30==0 & risk_averse==0 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007  if migest_30==1 & risk_averse==0 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007  if migest_30==0 & risk_averse==1 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007  if migest_30==1 & risk_averse==1  

eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007 yr_2011 if migest_30==0 & risk_averse==0 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007 yr_2011 if migest_30==1 & risk_averse==0 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007 yr_2011 if migest_30==0 & risk_averse==1 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007 yr_2011 if migest_30==1 & risk_averse==1 

eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007 yr_2011 yr_2017 if migest_30==0 & risk_averse==0 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007 yr_2011 yr_2017 if migest_30==1 & risk_averse==0 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007 yr_2011 yr_2017 if migest_30==0 & risk_averse==1 
eststo: reg ing_x_hrs i.familia i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.rama i.apoyo_gob yr_2007 yr_2011 yr_2017 if migest_30==1 & risk_averse==1 



esttab using D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\hrlyincome_mignomig_yrdummy.csv, replace ///
    se pr2 ///
    label                               ///
title(Results, Hourly income regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)

*/

* hourly wage regressions 


* general table of regression

eststo clear
eststo: reg ing_x_hrs i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex i.migest_30 
eststo: reg ing_x_hrs i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex i.migest_30 i.risk_averse

eststo: reg ing_x_hrs i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.migest_30 i.sex#i.risk_averse
eststo: reg ing_x_hrs i.familia i.married i.rural c.anios_esc c.eda i.rama i.migest_30 i.risk_averse i.sex#i.edo_mig 

eststo: reg ing_x_hrs i.familia i.married i.rural c.anios_esc c.eda i.rama i.migest_30 i.sex#i.edo_mig i.sex#i.risk_averse

esttab using D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\hrlyincome_mignomig_byyr_winteractions.tex, replace ///
    se r2 ///
    label                               ///
title(Results, Hourly income regressions (female))       ///
starlevels( + .1 * 0.05 ** 0.01)

eststo clear
eststo: reg ing_x_hrs i.familia i.married i.rural c.anios_esc c.eda i.rama i.migest_30 i.sex#i.edo_mig i.sex#i.risk_averse i.yr_2007
eststo: reg ing_x_hrs i.familia i.married i.rural c.anios_esc c.eda i.rama i.migest_30 i.sex#i.edo_mig i.sex#i.risk_averse i.yr_2012
eststo: reg ing_x_hrs i.familia i.married i.rural c.anios_esc c.eda i.rama i.migest_30 i.sex#i.edo_mig i.sex#i.risk_averse i.yr_2017
eststo: reg ing_x_hrs i.familia i.married i.rural c.anios_esc c.eda i.rama i.migest_30 i.sex#i.edo_mig i.sex#i.risk_averse i.yr_2007 i.yr_2012 i.yr_2017 

esttab using D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\hrlyincome_mignomig_byyr_wyears.tex, replace ///
    se r2 ///
    label                               ///
title(Results, Hourly income regressions (female))       ///
starlevels( + .1 * 0.05 ** 0.01)


   eststo clear
foreach i in 0 1{
 foreach y in 0 1{
eststo: reg ln_ingocup i.familia i.married i.rural c.anios_esc i.eda7c i.edo_mig i.sex if migest_30==`i' & risk_averse==`y'

 }
esttab using D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\lnincome_byyr_wyears_ctrlmig_4.csv, replace ///
    se r2 ///
    label                               ///
title(Results, Log monthly income regressions)       ///
starlevels( + .1 * 0.05 ** 0.01)
	
}





* Unobserved skills *********************************************************************************************

clear 
use ra_07_11_17_Q4
xtset key_var per
eststo clear

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{

eststo: reg ln_ingocup c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama [fw=fac] if yr_`x'==1 & migest_30==0 & risk_averse==0 & sex==1
predict unobs_`x'nomigrtmen, residuals
eststo: reg ln_ingocup c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama [fw=fac]  if yr_`x'==1 & migest_30==0 & risk_averse==1 & sex==1
predict unobs_`x'nomigramen, residuals
eststo: reg ln_ingocup c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama  [fw=fac] if yr_`x'==1 & migest_30==1 & risk_averse==0 & sex==1
predict unobs_`x'migrtmen, residuals
eststo: reg ln_ingocup c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama  [fw=fac] if yr_`x'==1 & migest_30==1 & risk_averse==1 & sex==1
predict unobs_`x'migramen, residuals

eststo clear
}

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{

eststo: reg ln_ingocup c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama  [fw=fac] if yr_`x'==1 & migest_30==0 & risk_averse==0 & sex==1
predict obs_`x'nomigrtmen
eststo: reg ln_ingocup c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama  [fw=fac] if yr_`x'==1 & migest_30==0 & risk_averse==1 & sex==1
predict obs_`x'nomigramen
eststo: reg ln_ingocup c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama  [fw=fac] if yr_`x'==1 & migest_30==1 & risk_averse==0 & sex==1
predict obs_`x'migrtmen
eststo: reg ln_ingocup c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama  [fw=fac] if yr_`x'==1 & migest_30==1 & risk_averse==1 & sex==1
predict obs_`x'migramen

eststo clear
}


eststo clear

eststo: reg ln_ingxhrs1 c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob [fw=fac] if migest_30==0 & sex==1 & risk_averse==0
predict unobs_nomigrtmen, residuals
eststo: reg ln_ingxhrs1 c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob [fw=fac] if migest_30==1 & sex==1 & risk_averse==0
predict unobs_migrtmen, residuals

twoway kdensity unobs_nomigrtmen [fw=fac] if  migest_30==0 & sex==1 & risk_averse==0, k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("Unobserved skills")|| kdensity unobs_migrtmen [fw=fac] if  migest_30==1 & sex==1 & risk_averse==0, k(ep) legend(label(2 "Migrant"))

kdensity unobs_nomigrtmen [fw=fac] if  migest_30==0 & sex==1 & risk_averse==0, generate(kxurt1 keurt1)
kdensity unobs_migrtmen [fw=fac] if  migest_30==1 & sex==1 & risk_averse==0, generate(kxurt2 keurt2)

gen kdenrest1_urt= keurt2 - keurt1
line kdenrest1_urt kxurt2


twoway kdensity unobs_2007nomigrtmen [fw=fac] if  migest_30==0 & sex==1 & risk_averse==0, k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("Unobserved skills")|| kdensity unobs_2007migrtmen [fw=fac] if  migest_30==1 & sex==1 & risk_averse==0, k(ep) legend(label(2 "Migrant"))


kdensity unobs_2007nomigramen [fw=fac] if  migest_30==0 & sex==1 & risk_averse==0, generate(kx1 ke1)
kdensity unobs_2007migramen [fw=fac] if  migest_30==1 & sex==1 & risk_averse==0, generate(kx2 ke2)

gen kdenrest1= ke2 - ke1
line kdenrest1 kx2

kdensity unobs_2007nomigrtmen [fw=fac] if  migest_30==0 & sex==1 & risk_averse==0, generate(kxrt1 kert1)
kdensity unobs_2007migrtmen [fw=fac] if  migest_30==1 & sex==1 & risk_averse==0, generate(kxrt2 kert2)

gen kdenrest1_rt= kert2 - kert1
line kdenrest1_rt kxrt2 




cumul obs_2007nomigramen [fw=fac] if  migest_30==0 & sex==1 & risk_averse==0  , gen(obs_skill_nomig) 
line obs_skill_nomig obs_2007nomigramen, sort
cumul obs_2007migramen [fw=fac] if  migest_30==1 & sex==1 & risk_averse==0  , gen(obs_skill_mig) 
line obs_skill_mig obs_2007migramen, sort


stack obs_skill_nomig ingocup obs_skill_mig ln_ingocup, into(c ing) wide clear

line obs_skill_nomig obs_skill_mig ing,  sort xtitle("Unobserved skills distribution") title("Cumulatives:" "Male unobserved skills") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

************************************************************************************************************



xtset key_var per
foreach x in 2007 2012 2017{
eststo clear
eststo: xtreg ln_ing_x_hrs c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob  if yr_`x'==1 & migest_30==0 & risk_averse==0 & sex==2, fe
predict unobs_`x'nomigrtwomen, residuals
eststo: xtreg ln_ing_x_hrs c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob  if yr_`x'==1 & migest_30==0 & risk_averse==1 & sex==2, fe
predict unobs_`x'nomigrawomen, residuals
eststo: xtreg ln_ing_x_hrs c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob  if yr_`x'==1 & migest_30==1 & risk_averse==0 & sex==2, fe
predict unobs_`x'migrtwomen, residuals
eststo: xtreg ln_ing_x_hrs c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob  if yr_`x'==1 & migest_30==1 & risk_averse==1 & sex==2, fe
predict unobs_`x'migrawomen, residuals


}


save, replace



clear
use ra_07_17_Q4

cumul unobs_07nomigrtmen [fw=fac] if  migest_30==0 & sex==1 & risk_averse==0  , gen(ln_ing_nomig) 
line ln_ing_nomig unobs_07nomigrtmen, sort

cumul unobs_07nomigrtmen [fw=fac] if  migest_30==1 & sex==1 & risk_averse==0  , gen(ln_ing_mig) 
line ln_ing_mig unobs_07migrtmen, sort

stack ln_ing_nomig ln_ing_x_hrs ln_ing_mig ln_ing_x_hrs, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log hourly income") title("Cumulatives:" "Male unobserved skills") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))




eststo clear

eststo: xtreg ing_x_hrs c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob i.sex i.migest_30 i.risk_averse, fe
predict unobs_skill, residuals
eststo: xtreg ing_x_hrs c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob i.sex i.migest_30 i.risk_averse i.yr_2007, fe
eststo: xtreg ing_x_hrs c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob i.sex i.migest_30 i.risk_averse i.yr_2012, fe
eststo: xtreg ing_x_hrs c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob i.sex i.migest_30 i.risk_averse i.yr_2017, fe
eststo: xtreg ing_x_hrs c.anios_esc i.familia i.edo_mig i.married i.rural c.eda i.rama i.apoyo_gob i.sex i.migest_30 i.risk_averse i.yr_2007 i.yr_2012 i.yr_2017, fe


esttab using D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\hrlyincome_mignomig_panel.csv, replace ///
    se pr2  ///
    label                               ///
title(Results, Hourly income regressions (female))       ///
starlevels( + .1 * 0.05 ** 0.01)



* reg for the risk aversion index


gen empleo=0
replace empleo=1 if clase2==1

gen panel_cp1=0
replace panel_cp1=1 if year==2007 | year==2012 | year==2017

eststo clear
foreach x in 0 1{
*eststo: reg rs_index i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda  i.rama i.apoyo_gob i.migest_30  if year==2007
*eststo: reg rs_index i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda  i.rama i.apoyo_gob i.migest_30  if year==2011
*eststo: reg rs_index i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda  i.rama i.apoyo_gob i.migest_30  if year==2017
*eststo: reg rs_index i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.apoyo_gob [fw=fac] if migest_30==`x' & panel_cp1==1
*eststo: reg rs_index i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.apoyo_gob i.yr_2007 [fw=fac] if migest_30==`x' & panel_cp1==1
*eststo: reg rs_index i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.apoyo_gob i.yr_2012 [fw=fac] if migest_30==`x' & panel_cp1==1
*eststo: reg rs_index i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.apoyo_gob i.yr_2017 [fw=fac] if migest_30==`x' & panel_cp1==1
eststo: reg rs_index i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.apoyo_gob i.yr_2007 i.yr_2012 i.yr_2017[fw=fac]if migest_30==`x' & panel_cp1==1

*eststo: reg risk_averse i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.apoyo_gob i.yr_2007 i.yr_2012 i.yr_2017 [fw=fac]  if migest_30==`x' & panel_cp1==1

esttab using D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\reg_simple_RAindex_mig.tex, replace ///
    se pr2 ///
    label                               ///
title(Results, Risk aversion index regressions (migrants & non-migrants))       ///
starlevels( + .1 * 0.05 ** 0.01)
}


/*eststo clear
eststo: probit risk_averse i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda  i.rama i.apoyo_gob i.migest_30 
eststo: probit risk_averse i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda  i.rama i.apoyo_gob i.migest_30  i.yr_2007 
eststo: probit risk_averse i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda  i.rama i.apoyo_gob i.migest_30  i.yr_2007 i.yr_2012 
eststo: probit risk_averse i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda  i.rama i.apoyo_gob i.migest_30  i.yr_2007 i.yr_2012 i.yr_2017 

esttab using D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\RAindex_mignomig_probit.csv, replace ///
    se pr2 ///
    label                               ///
title(Results, Risk aversion index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)
*/

* reg for migration probablity



eststo clear
eststo: probit migest_30 i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.apoyo_gob c.ln_ing_x_hrs c.rs_index [fw=fac] if risk_averse==0 & panel_cp1==1
eststo: probit migest_30 i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.apoyo_gob c.ln_ing_x_hrs c.rs_index [fw=fac] if risk_averse==1 & panel_cp1==1


*
*foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
*    
*eststo: probit migest_30 i.familia i.sex i.edo_mig i.married i.rural c.anios_esc c.eda c.rs_index i.rama i.apoyo_gob  i.yr_`x'

*}
esttab using D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\mignomig_probit_RS_simple.tex, replace ///
    se pr2 ///
    label                               ///
title(Results, Risk aversion index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)








tab migest_30 risk_averse if year==2007 & eda7c==2

**********************************************************************************************************

* Cummulative density function graphs

* por grupo de dad
foreach i in 1 0{
foreach y in 2007 2012 2017{

clear
use ra_07_17_Q4

cumul ln_ingocup [fw=fac] if  migest_30==0 & risk_averse==`i' & year==`y', gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & risk_averse==`i'  & year==`y', gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Cumulatives:" "`y' average log monthly income") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\CFD_mignomig_RP`i'_`y'.jpg, replace

}
}
}

*************************************************************************************************************
/*clear
use ra_07_17_Q4

cumul ln_ingocup [fw=fac] if  migest_30==0 & risk_averse==1 , gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & risk_averse==1 , gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Cumulatives:" "2007 - 2017 average log monthly income") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\CFD_mignomig_RA.jpg, replace

*/



foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_07_17_Q4

cumul ln_ingocup [fw=fac] if  migest_30==0 & risk_averse==0  & yr_`x'==1 , gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & risk_averse==0  & yr_`x'==1 , gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Cumulatives:" "`x' average log monthly income") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\CFD_mignomig_RA_`x'.jpg, replace
}

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_07_17_Q4

cumul ln_ingocup [fw=fac] if  migest_30==0 & risk_averse==1  & yr_`x'==1 , gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & risk_averse==1  & yr_`x'==1 , gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Cumulatives:" "`x' average log monthly income") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\CFD_mignomig_RT_`x'.jpg, replace
}





ksmirnov anios_esc if  risk_averse==1 & sex==1, by(migest_30) 




clear
use ra_07_17_Q4

gen ln_anios_esc=ln(anios_esc)

cumul ln_anios_esc [fw=fac] if  migest_30==0 & sex==1 & risk_averse==0  , gen(sch_ra_nomig) 
line sch_ra_nomig ln_anios_esc, sort

cumul ln_anios_esc [fw=fac] if  migest_30==1 & sex==1 & risk_averse==0  , gen(sch_ra_mig) 
line sch_ra_mig ln_anios_esc, sort

stack sch_ra_nomig ln_anios_esc sch_ra_mig ln_anios_esc, into(c sch) wide clear

line sch_ra_nomig sch_ra_mig sch,  sort xtitle("log Schooling") title("Cumulatives:" "Male average log schooling") subtitle("migrants and non-migrants")


foreach z in 1{
foreach y in 2007 2012 2017{
clear
use ra_07_17_Q4

cumul ln_ing_x_hrs [fw=fac] if migest_30==1 & year==`y' & sex==`z', gen(ln_ing_x_hrs_mig_`y') 
line ln_ing_x_hrs_mig_`y' ln_ing_x_hrs, sort

cumul ln_ing_x_hrs [fw=fac] if migest_30==0 & year==`y' & sex==`z', gen(ln_ing_x_hrs_nomig_`y') 
line ln_ing_x_hrs_mig_`y' ln_ing_x_hrs, sort

stack ln_ing_x_hrs_mig ln_ing_x_hrs ln_ing_x_hrs_nomig ln_ing_x_hrs, into(c ing) wide clear

line ln_ing_x_hrs_mig_`y' ln_ing_x_hrs_nomig_`y' ing, sort xtitle("Log hourly income (weekly)") title("Cumulatives:" "Average log hourly income (`y')") subtitle("Male migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\CFD_male_mignomig_`y'.jpg, replace

}


foreach y in 2007 2012 2017{
clear
use ra_07_17_Q4

cumul ln_ing_x_hrs [fw=fac] if migest_30==1 & risk_averse==1 & year==`y' & sex==`z', gen(ln_ing_x_hrs_mig_`y') 
line ln_ing_x_hrs_mig_`y' ln_ing_x_hrs, sort

cumul ln_ing_x_hrs [fw=fac] if migest_30==0 & risk_averse==1 & year==`y' & sex==`z', gen(ln_ing_x_hrs_nomig_`y') 
line ln_ing_x_hrs_mig_`y' ln_ing_x_hrs, sort

stack ln_ing_x_hrs_mig ln_ing_x_hrs ln_ing_x_hrs_nomig ln_ing_x_hrs, into(c ing) wide clear

line ln_ing_x_hrs_mig_`y' ln_ing_x_hrs_nomig_`y' ing, sort xtitle("Log hourly income (weekly)") title("Cumulatives:" "Average log hourly income (`y')") subtitle("RA male migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\CFD_male_RA_mignomig_`y'.jpg, replace

}


foreach y in 2007 2012 2017{
clear
use ra_07_17_Q4

cumul ln_ing_x_hrs [fw=fac] if migest_30==1 & risk_averse==0 & year==`y' & sex==`z' , gen(ln_ing_x_hrs_mig_`y') 
line ln_ing_x_hrs_mig_`y' ln_ing_x_hrs, sort

cumul ln_ing_x_hrs [fw=fac] if migest_30==0 & risk_averse==0 & year==`y' & sex==`z', gen(ln_ing_x_hrs_nomig_`y') 
line ln_ing_x_hrs_mig_`y' ln_ing_x_hrs, sort

stack ln_ing_x_hrs_mig ln_ing_x_hrs ln_ing_x_hrs_nomig ln_ing_x_hrs, into(c ing) wide clear

line ln_ing_x_hrs_mig_`y' ln_ing_x_hrs_nomig_`y' ing, sort xtitle("Log hourly income (weekly)") title("Cumulatives:" "Average log hourly income (`y')") subtitle("RL male migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\CFD_male_RL_mignomig_`y'.jpg, replace

}

}




* FOSD and SOSD tests


* neccesary consditions
* 1) sotchastic dominance, with the proof that is intermediate FOSD it is enough


* sufficient conditions



