
clear
set more off, permanently

log close _all

cd "D:\data\ENOE\Chpt_I_II\final"
////////////////////////////////////////////////////////////////////////////////
* preparing both data sets for Chpy I and II
clear
use ra_2007_allQ.dta
append using ra_2009_allQ
append using ra_2009_allQ
append using ra_2010_allQ
append using ra_2011_allQ
append using ra_2012_allQ
append using ra_2013_allQ
append using ra_2014_allQ
append using ra_2015_allQ
append using ra_2016_allQ
append using ra_2017_allQ

save ra_allyears.dta, replace

clear
use ra_2007_allQ.dta
append using ra_2012_allQ
append using ra_2017_allQ

save ra_071217_years.dta, replace

////////////////////////////////////////////////////////////////////////////////

clear
use ra_071217_years
* setting all vars

gen wage_earners=0
replace wage_earners=1 if ingocup_1>0

replace ingocup_1=0 if ingocup_1==.
replace ing_x_hrs_1=0 if ing_x_hrs_1==. 

gen edo_mig=0
replace edo_mig=1 if ent==14 | ent==16 | ent==11 | ent==30 | ent==15 | ent==2 | ent==8 | ent==20 | ent==12 | ent==21 | ent==13 | ent==26 | ent==32
* los diez estados con mas numero de migrantes registrados a EEUU: 14 Jalisco 16 Michoacán de Ocampo 11 Guanajuato 30 Veracruz de Ignacio de la Llave 15 México 02 Baja California 08 Chihuahua 20 Oaxaca 12 Guerrero 21 Puebla 13 Hidalgo 26 Sonora (source: https://www.inegi.org.mx/programas/ccpv/2010/#Tabulados)

gen family=0
replace family=1 if n_hij>0

gen gob_supp=0
replace gob_supp=1 if p14apoyos==1

gen married=0
replace married=1 if e_con==5

gen ln_ing_x_hrs=ln(1+ing_x_hrs_1)
gen ln_ingocup=ln(1+ingocup_1)


label define migracion 0 "No mig" 1 "Mig"
label values migest migracion

label define genero 1 "Man" 2 "Woman"
label values sex genero

label define aversion 0 "Risk taker" 1 "Risk averse"
label values risk_averse aversion

gen yr_2007=(year==2007)
gen yr_2012=(year==2012)
gen yr_2017=(year==2017)

gen rural=(ur==2)

save, replace

*Si las variables son continuas, aplica la prueba Kolmogorov-Smirnov; si 
*las variables son discretas y toman m‡s de dos valores, aplica una prueba Ji 
*cuadrada de Pearson

* test for groups 
log close _all
log using "D:\data\ENOE\Chpt_I_II\final\data_tests.log", replace
foreach x in 07 12 17{
tab year if year==20`x'

ksmirnov ingocup_1 if year==20`x', by(migest)
ksmirnov ing_x_hrs_1 if year==20`x', by(migest)
ksmirnov anios_esc if year==20`x', by(migest)
ksmirnov eda if year==20`x', by(migest)
}


foreach x in 07 12 17{
tab year if year==20`x'
tab clase2 migest if year==20`x', chi2
tab clase3 migest if year==20`x', chi2
tab cs_p13_1 migest if year==20`x', chi2
tab eda7c migest if year==20`x', chi2
tab eda12c migest if year==20`x', chi2
tab n_hij migest if year==20`x', chi2
}

foreach x in 07 12 17{
tab year if year==20`x'
ttest risk_averse if year==20`x', by(migest)
ttest sex if year==20`x', by(migest)
ttest rural if year==20`x', by(migest)
ttest wage_earners if year==20`x', by(migest)
ttest edo_mig  if year==20`x', by(migest)
ttest family  if year==20`x', by(migest)
ttest married  if year==20`x', by(migest)
}

local vars_enoe risk_averse sex eda rural anios_esc clase2  clase3 wage_earners cs_p13_1 eda7c eda12c edo_mig married family n_hij


foreach x of local vars_enoe{

sum `x'

*b)

ttest `x', by(migest) 

*c)

reg `x' migest

*d)

reg `x' migest, robust



********************************************************************************

}








*gen ln_ingocup=ln(ingocup)
cumul ln_ingocup  if  migest==1 & risk_averse==0, gen(rt_m_lning) 
cumul ln_ingocup  if  migest==1 & risk_averse==1, gen(ra_m_lning) 

stack rt_m_lning ln_ingocup ra_m_lning ln_ingocup, into(c ln_ing) clear

line rt_m_lning  ra_m_lning ln_ing, title("Income distribution (Log)") subtitle("2007 - 2017")  


|| cumul ln_ingocup  if  migest_30==1 & sex==1 & risk_averse==1



clear
use ra_071217_years

ksmirnov anios_esc if  risk_averse==1 & sex==1, by(migest) 
ksmirnov anios_esc if  risk_averse==0 & sex==1, by(migest) 
ksmirnov anios_esc if  risk_averse==1 & sex==2, by(migest) 
ksmirnov anios_esc if  risk_averse==0 & sex==2, by(migest) 



label var ing_x_hrs "Income by hour (pesos)"

graph box ing_x_hrs [fw=fac] if  ing_x_hrs>0, over(migest) over(sex) over(year)   medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\graphs\chpt_I\finalboxgraph_inxhrs_VF.jpg", replace

graph box ing_x_hrs [fw=fac] if  risk_averse==1, over(migest) over(year) medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\respuesta_tesis\graphs\chpt_I\finalboxgraph_inxhrs_nomig_VF.jpg", replace

graph box ing_x_hrs [fw=fac] if  ing_x_hrs>0 & ==1, over(migest) over(year) over(risk_averse) medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc)) noout graphregion(color(white)) bgcolor(white)

graph export "D:\doctorado\tesis_reestrutura\borrador_ChptI_2023\finalboxgraph_inxhrs_mig_VF.jpg", replace


