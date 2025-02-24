clear
set more off, permanently

cd "D:\data\ENOE\Chpt_I_II\final"
////////////////////////////////////////////////////////////////////////////////
/* preparing both data sets for Chpy I and II
clear
use ra_2007_allQ.dta
append using ra_2008_allQ
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

*/
* box graphs
use ra_allyears

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
    
graph box ingocup [fw=fac] if anios_esc<99 & year==`x' , over(migest_30)  medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc))  noout

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\boxgraph_noout_wage_mig_`x'.jpg, replace

}

*box graphs by gender

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
    
graph box ingocup [fw=fac] if anios_esc<99 & year==`x' ,  over(year) over(migest_30) over(sex) medtype(marker) medmarker(msymbol(diamond) msize(medium)) ylabel(,format(%9.0fc))  noout

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\boxgraph_noout_wage_mig_sex_`x'.jpg, replace


}

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{

clear
use ra_`x'_allQ.dta

gen wage_earners=0
replace wage_earners=1 if ingocup_1>0

*replace ingocup_1=0 if ingocup_1==.
*replace ing_x_hrs_1=0 if ing_x_hrs_1==. 

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

gen yr_`x'=(year==`x')

gen rural=(ur==2)

gen anios_esc_1=anios_esc[_n-1] if time_wp!=1
replace anios_esc_1=anios_esc if time_wp==1

gen eda7c_1=eda7c[_n-1] if time_wp!=1
replace eda7c_1=eda7c if time_wp==1

gen rama_1=rama[_n-1] if time_wp!=1
replace rama_1=rama if time_wp==1

save, replace
}



* kdensities

* general

clear
use ra_07_17_Q4

twoway kdensity ln_ingocup [fw=fac] if migest_30==0 , k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income")|| kdensity ln_ingocup [fw=fac] if migest_30==1 , k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities\freqw_lningocup_mignomig_general.jpg, replace 

*risk averse
twoway kdensity ln_ingocup [fw=fac] if migest_30==0 & risk_averse==1 , k(ep) legend(label(1 "Non migrant")) title("Kernel densities (RA)") ytitle("") xtitle("log income")|| kdensity ln_ingocup [fw=fac] if migest_30==1 & risk_averse==1, k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities\RA_freqw_lningocup_mignomig_general.jpg, replace 

* risk taker
twoway kdensity ln_ingocup [fw=fac] if migest_30==0 & risk_averse==0, k(ep) legend(label(1 "Non migrant")) title("Kernel densities (RT)") ytitle("") xtitle("log income")|| kdensity ln_ingocup [fw=fac] if migest_30==1 & risk_averse==0, k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities\RT_freqw_lningocup_mignomig_general.jpg, replace 


* por año



foreach x in  2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 {

twoway kdensity ln_ingocup [fw=fac] if migest_30==0 & year==`x', k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income")|| kdensity ln_ingocup [fw=fac] if migest_30==1 & year==`x', k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities\freqw_lningocup_mignomig_`x'.jpg, replace 

}


* Kernel Densities, basic and by pRA profile


foreach x in  2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 {
twoway kdensity ln_ingocup [fw=fac] if migest_30==0 & year==`x', k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (`x')") ytitle("") xtitle("log monthly income") xscale(range(0 15))|| kdensity ln_ingocup [fw=fac] if migest_30==1 & year==`x', k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\kdensities\KD_lningocup_mignomig_`x'.jpg, replace 

}



* por año y risk position


*RA

foreach x in  2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 {
twoway kdensity ln_ingocup [fw=fac] if migest_30==0 & year==`x' & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("RA Kernel densities (`x')") ytitle("") xtitle("log monthly income") xscale(range(0 15))|| kdensity ln_ingocup [fw=fac] if migest_30==1 & year==`x' & risk_averse==1, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\kdensities\KD_lningocup_mignomig_RA_`x'.jpg, replace 

}




* RT

foreach x in  2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 {
twoway kdensity ln_ingocup [fw=fac] if migest_30==0 & year==`x' & risk_averse==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("RA Kernel densities (`x')") ytitle("") xtitle("log monthly income") xscale(range(0 15))|| kdensity ln_ingocup [fw=fac] if migest_30==1 & year==`x' & risk_averse==0, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\kdensities\KD_lningocup_mignomig_RT_`x'.jpg, replace 

}



* por año y genero

foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
    
    foreach y in 1 2{

twoway kdensity ln_ingocup [fw=fac] if migest_30==0 & year==`x' & sex==`y', k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income")|| kdensity ln_ingocup [fw=fac] if migest_30==1 & year==`x' & sex==`y', k(ep) legend(label(2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities\freqw_lningxhr_mignomig_sex_`y'_`x'.jpg, replace 

}
}



/* por año por genero por risk aversion (este cruce ya no pude hacerse)
*RT
foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
    
    foreach y in 1 2{
		twoway kdensity ln_ingocup [fw=fac] if migest_30==0 & year==`x' & sex==`y' & risk_averse==0, k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income")|| kdensity ln_ingocup [fw=fac] if migest_30==1 & year==`x' & sex==`y' & risk_averse==0, k(ep) legend(label(2 "Migrant"))

		graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities\RT_freqw_lningxhr_mignomig_sex_`y'_`x'.jpg, replace 
						}

}

*RA
foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
    
    foreach y in 1 2{
		twoway kdensity ln_ingocup [fw=fac] if migest_30==0 & year==`x' & sex==`y' & risk_averse==1, k(ep) legend(label(1 "Non migrant")) title("Kernel densities") ytitle("") xtitle("log income")|| kdensity ln_ingocup [fw=fac] if migest_30==1 & year==`x' & sex==`y' & risk_averse==1, k(ep) legend(label(2 "Migrant"))

		graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities\RA_freqw_lningxhr_mignomig_sex_`y'_`x'.jpg, replace 
						}

}

*/



eststo clear
eststo: reg ln_ingocup i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex [fw=fac] if migest_30==0  
predict obs_nm_all
eststo: reg ln_ingocup i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex [fw=fac] if migest_30==1 
predict obs_m_all

kdensity obs_nm_all [fw=fac] if  migest_30==0  , generate(kx1 ke1)
kdensity obs_m_all [fw=fac] if  migest_30==1 , generate(kx2 ke2)

gen kdenrest1= ke2 - ke1
tabstat ln_ingocup , stats(p50 )

line kdenrest1 kx2, xline( 8.548692  ) yline(0) title("K-densities difference (All)")

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\gen_obs_diff.jpg, replace
drop kx1 ke1 kx2 ke2 kdenrest1


* all risk takers
eststo clear
eststo: reg ln_ingocup i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex [fw=fac] if migest_30==0  & risk_averse==0
predict rt_obs_nm_all
eststo: reg ln_ingocup i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex [fw=fac] if migest_30==1 & risk_averse==0
predict rt_obs_m_all

kdensity rt_obs_nm_all [fw=fac] if  migest_30==0 & risk_averse==0 , generate(kxrt1 kert1)
kdensity rt_obs_m_all [fw=fac] if  migest_30==1 & risk_averse==0 , generate(kxrt2 kert2)

gen kdenrest1_rt= kert2 - kert1
tabstat ln_ingocup if risk_averse==0, stats(p50 )

line kdenrest1_rt kxrt2, xline( 8.325548  ) yline(0) title("K-densities difference (RT)")

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_obs_diff.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt


* all risk averse

eststo clear
eststo: reg ln_ingocup i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex [fw=fac] if migest_30==0 & risk_averse==1
predict ra_obs_nm_all
eststo: reg ln_ingocup i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex [fw=fac] if migest_30==1 & risk_averse==1
predict ra_obs_m_all

kdensity ra_obs_nm_all [fw=fac] if  migest_30==0 & risk_averse==1 , generate(kxrt1 kert1)
kdensity ra_obs_m_all [fw=fac] if  migest_30==1 & risk_averse==1 , generate(kxrt2 kert2)

gen kdenrest1_rt= kert2 - kert1
tabstat ln_ingocup if risk_averse==1, stats(p50 )

line kdenrest1_rt kxrt2, xline( 8.548692  ) yline(0) title("K-densities difference (RA)")

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff.jpg, replace
drop kxrt1 kert1 kxrt2 kert2 kdenrest1_rt




*by year


foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ.dta
sum year if year==`x'
eststo clear
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex#i.risk_averse [fw=fac] if migest==0   & year==`x'
predict obs_nm_`x'
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex#i.risk_averse  [fw=fac] if migest==1  & year==`x'
predict obs_m_`x'

}

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ.dta

drop kx1_`x' ke1_`x' kx2_`x' ke2_`x' kdenrest1_`x'
kdensity obs_nm_`x' [fw=fac] if  migest==0 & year==`x' & ln_ingocup>0, generate(kx1_`x' ke1_`x') nograph k(epan2) bw(1)
kdensity obs_m_`x' [fw=fac] if  migest==1 & year==`x'& ln_ingocup>0, generate(kx2_`x' ke2_`x') nograph k(epan2) bw(1) 

gen kdenrest1_`x'= ke2_`x' - ke1_`x'
save, replace
}


*foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
*sum year if year==`x'
*clear
*use ra_`x'_allQ.dta

*tabstat ln_ingocup if  year==`x' , stats(p50 )

*}

clear
use ra_2007_allQ.dta
append using ra_2008_allQ
append using ra_2009_allQ
append using ra_2010_allQ
append using ra_2011_allQ
append using ra_2012_allQ
append using ra_2013_allQ
append using ra_2014_allQ
append using ra_2015_allQ
append using ra_2016_allQ
append using ra_2017_allQ

*save ra_allyears.dta, replace

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ.dta

line kdenrest1_`x' kx2_`x' if year==`x', xline(  7.6 ) yline(0) title("K-densities difference - `x'") ytitle("KD diff")  graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_`x'.jpg, replace

}


line kdenrest1_2007 kx2_2007 if year==2007, xline(  7.855932 ) yline(0) title("K-densities difference - 2007") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2007.jpg, replace
line kdenrest1_2008 kx2_2008 if year==2008, xline(  7.78364  ) yline(0) title("K-densities difference - 2008") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2008.jpg, replace
line kdenrest1_2009 kx2_2009 if year==2009, xline(  7.673688 ) yline(0) title("K-densities difference - 2009") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2009.jpg, replace
line kdenrest1_2010 kx2_2010 if year==2010, xline(  7.673688 ) yline(0) title("K-densities difference - 2010") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2010.jpg, replace
line kdenrest1_2011 kx2_2011 if year==2011, xline(  7.632885 ) yline(0) title("K-densities difference - 2011") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2011.jpg, replace
line kdenrest1_2012 kx2_2012 if year==2012, xline( 7.568379  ) yline(0) title("K-densities difference - 2012") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2012.jpg, replace
line kdenrest1_2013 kx2_2013 if year==2013, xline(  7.632885 ) yline(0) title("K-densities difference - 2013") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2013.jpg, replace
line kdenrest1_2014 kx2_2014 if year==2014, xline(  7.632885 ) yline(0) title("K-densities difference - 2014") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2014.jpg, replace
line kdenrest1_2015 kx2_2015 if year==2015, xline(  7.650169 ) yline(0) title("K-densities difference - 2015") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2015.jpg, replace
line kdenrest1_2016 kx2_2016 if year==2016, xline(  7.568379 ) yline(0) title("K-densities difference - 2016") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2016.jpg, replace
line kdenrest1_2017 kx2_2017 if year==2017, xline(  7.418781 ) yline(0) title("K-densities difference - 2017") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_obs_diff_2017.jpg, replace

/////////////////////////////////////////////////////////////////////////////////
* unobserved

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ.dta
drop kdenrest1_`x' kx1_`x' ke1_`x' kx2_`x' ke2_`x'
sum year if year==`x'
eststo clear
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex#i.risk_averse [fw=fac] if migest==0   & year==`x'
predict unobs_nm_`x', residuals
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex#i.risk_averse  [fw=fac] if migest==1  & year==`x'
predict unobs_m_`x', residuals

kdensity unobs_nm_`x' [fw=fac] if  migest==0 & year==`x' & ln_ingocup>0, generate(kx1_`x' ke1_`x') nograph k(epan2) bw(1)
kdensity unobs_m_`x' [fw=fac] if  migest==1 & year==`x'& ln_ingocup>0, generate(kx2_`x' ke2_`x') nograph k(epan2) bw(1) 

gen kdenrest1_`x'= ke2_`x' - ke1_`x'
save, replace
}

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ.dta

drop kx1_`x' ke1_`x' kx2_`x' ke2_`x' kdenrest1_`x'

kdensity unobs_nm_`x' [fw=fac] if  migest==0 & year==`x' & ln_ingocup>0, generate(kx1_`x' ke1_`x') nograph k(epan2) bw(1)
kdensity unobs_m_`x' [fw=fac] if  migest==1 & year==`x'& ln_ingocup>0, generate(kx2_`x' ke2_`x') nograph k(epan2) bw(1) 




gen kdenrest1_`x'= ke2_`x' - ke1_`x'
save, replace
}

 

clear
use ra_2007_allQ.dta
append using ra_2008_allQ
append using ra_2009_allQ
append using ra_2010_allQ
append using ra_2011_allQ
append using ra_2012_allQ
append using ra_2013_allQ
append using ra_2014_allQ
append using ra_2015_allQ
append using ra_2016_allQ
append using ra_2017_allQ

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ.dta

line kdenrest1_`x' kx2_`x' if year==`x', xline(  7.6 ) yline(0) title("K-densities difference - `x'") ytitle("KD diff")  graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_`x'.jpg, replace

}

drop per r_def loc mun est est_d ageb cd_a ent con upm d_sem n_pro_viv v_sel n_hog h_mud n_ent c_res par_c nac_dia nac_mes nac_anio l_nac_c cs_p12 cs_p13_2 cs_p14_c cs_p15 cs_p16 cs_p17 cs_nr_mot cs_p22_des cs_nr_ori zona salario  clase3 pos_ocu seg_soc all_sample c_ocu11c ing7c dur9c emple7c medica5c buscar5c rama_est1 rama_est2 ambito1 ambito2 tue1 tue2 tue3 busqueda d_ant_lab d_cexp_est dur_des sub_o s_clasifi remune2c pre_asa tip_con dispo nodispo c_inac5c pnea_est niv_ins eda5c eda12c eda19c hij5c domestico tcco cp_anoc ma48me1sm t_tra emp_ppal tue_ppal trans_ppal mh_fil2 mh_col sec_ins


save ra_allyears, replace

foreach x in  2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
*sum year if year==`x'
clear
use ra_`x'_allQ.dta


tabstat ln_ingocup if  year==`x' , stats(p50 )
save, replace
}

clear 
use ra_allyears

line kdenrest1_2007 kx2_2007 if year==2007, xline(  7.855932 ) yline(0) title("K-densities difference - 2007") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2007.jpg, replace
line kdenrest1_2008 kx2_2008 if year==2008, xline(  7.78364  ) yline(0) title("K-densities difference - 2008") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2008.jpg, replace
line kdenrest1_2009 kx2_2009 if year==2009, xline(  7.673688 ) yline(0) title("K-densities difference - 2009") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2009.jpg, replace
line kdenrest1_2010 kx2_2010 if year==2010, xline(  7.673688 ) yline(0) title("K-densities difference - 2010") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2010.jpg, replace
line kdenrest1_2011 kx2_2011 if year==2011, xline(  7.632885 ) yline(0) title("K-densities difference - 2011") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2011.jpg, replace
line kdenrest1_2012 kx2_2012 if year==2012, xline( 7.568379  ) yline(0) title("K-densities difference - 2012") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2012.jpg, replace
line kdenrest1_2013 kx2_2013 if year==2013, xline(  7.632885 ) yline(0) title("K-densities difference - 2013") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2013.jpg, replace
line kdenrest1_2014 kx2_2014 if year==2014, xline(  7.632885 ) yline(0) title("K-densities difference - 2014") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2014.jpg, replace
line kdenrest1_2015 kx2_2015 if year==2015, xline(  7.650169 ) yline(0) title("K-densities difference - 2015") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2015.jpg, replace
line kdenrest1_2016 kx2_2016 if year==2016, xline(  7.568379 ) yline(0) title("K-densities difference - 2016") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2016.jpg, replace
line kdenrest1_2017 kx2_2017 if year==2017, xline(  7.418781 ) yline(0) title("K-densities difference - 2017") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\gen_unobs_diff_2017.jpg, replace


////////////////////////////////////////////////////////////////////////////////







////////////////////////////////////////////////////////////////////////////////

* risk takers
* 2007 2008 2009 2010 2011 2012 2013 2014 2015 
/*clear
use ra_allyears.dta
sum ln_ingocup ingocup_1 fac time_wp risk_averse year ingocup migest family married rural anios_esc_1 eda7c_1 edo_mig rama_1 sex wage_earners gob_supp clase2 eda
keep ln_ingocup ingocup_1 fac time_wp risk_averse year ingocup migest family married rural anios_esc_1 eda7c_1 edo_mig rama_1 sex wage_earners gob_supp clase2 eda
save raw_for_graphs, replace

clear
use raw_for_graphs
replace ingocup_1=ingocup[_n-1] if time_wp!=1
replace ingocup_1=ingocup if time_wp==1

drop ln_ingocup

gen ln_ingocup=ln(ingocup_1)
*/

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 {
clear
use ra_`x'_allQ
replace ingocup_1=ingocup[_n-1] if time_wp!=1
replace ingocup_1=ingocup if time_wp==1

drop ln_ingocup

gen ln_ingocup=ln(ingocup_1)

eststo clear
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex  [fw=fac] if migest==0   & year==`x' & risk_averse==0 
predict rt_obs_nm_`x'
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex  [fw=fac] if migest==1   & year==`x' & risk_averse==0 
predict rt_obs_m_`x'

eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex  [fw=fac] if migest==0   & year==`x' & risk_averse==1 
predict ra_obs_nm_`x'
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex  [fw=fac] if migest==1   & year==`x' & risk_averse==1 
predict ra_obs_m_`x'

save, replace
}



foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015  2016 2017{
clear
use ra_`x'_allQ  
kdensity rt_obs_nm_`x' [fw=fac] if  migest==0  & year==`x' , generate(kxrt1_`x' kert1_`x')  k(epan2) bw(1)
kdensity rt_obs_m_`x' [fw=fac] if  migest==1 & year==`x' , generate(kxrt2_`x' kert2_`x')  k(epan2) bw(1)

gen kdenrest1_rt_`x'= kert2_`x' - kert1_`x'

kdensity ra_obs_nm_`x' [fw=fac] if  migest==0  & year==`x' , generate(kxra1_`x' kera1_`x')  k(epan2) bw(1)
kdensity ra_obs_m_`x' [fw=fac] if  migest==1  & year==`x' , generate(kxra2_`x' kera2_`x')  k(epan2) bw(1)

gen kdenrest1_ra_`x'= kera2_`x' - kera1_`x'

save, replace

}


foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ

tabstat  kxra2_`x'  , stats(p50)

}



* risk averse
clear
use ra_2007_allQ
line kdenrest1_ra_2007 kxra2_2007 if  year==2007, xline( 9.7 ) yline(0) ytitle("") title("K-densities difference - 2007") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2007.jpg, replace
clear
use ra_2008_allQ
line kdenrest1_ra_2008 kxra2_2008 if  year==2008, xline( 11.8 ) yline(0) ytitle("") title("K-densities difference - 2008") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2008.jpg, replace
clear
use ra_2009_allQ
line kdenrest1_ra_2009 kxra2_2009 if  year==2009, xline( 9.9 ) yline(0) ytitle("") title("K-densities difference - 2009") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2009.jpg, replace
clear
use ra_2010_allQ
line kdenrest1_ra_2010 kxra2_2010 if  year==2010, xline( 11.49 ) yline(0) ytitle("") title("K-densities difference - 2010") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2010.jpg, replace
clear
use ra_2011_allQ
line kdenrest1_ra_2011 kxra2_2011 if  year==2011, xline( 9.9 ) yline(0) ytitle("") title("K-densities difference - 2011") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2011.jpg, replace
clear
use ra_2012_allQ
line kdenrest1_ra_2012 kxra2_2012 if  year==2012, xline( 10.8 ) yline(0) ytitle("") title("K-densities difference - 2012") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2012.jpg, replace
clear
use ra_2013_allQ
line kdenrest1_ra_2013 kxra2_2013 if  year==2013, xline( 8.6 ) yline(0) ytitle("") title("K-densities difference - 2013") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2013.jpg, replace
clear
use ra_2014_allQ
line kdenrest1_ra_2014 kxra2_2014 if  year==2014, xline( 8.3 ) yline(0) ytitle("") title("K-densities difference - 2014") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2014.jpg, replace
clear
use ra_2015_allQ
line kdenrest1_ra_2015 kxra2_2015 if  year==2015, xline( 8.9 ) yline(0) ytitle("") title("K-densities difference - 2015") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2015.jpg, replace
clear
use ra_2016_allQ
line kdenrest1_ra_2016 kxra2_2016 if  year==2016, xline( 10.9 ) yline(0) ytitle("") title("K-densities difference - 2016") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2016.jpg, replace
clear
use ra_2017_allQ
line kdenrest1_ra_2017 kxra2_2017 if  year==2017, xline( 10.2 ) yline(0) ytitle("") title("K-densities difference - 2017") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_obs_diff_2017.jpg, replace





* risk taker

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ

tabstat  kxrt2_`x', stats(p50)

}


clear
use ra_2007_allQ
line kdenrest1_rt_2007 kxrt2_2007 if  year==2007, xline( 7.6 ) yline(0) ytitle("") title("K-densities difference - 2007") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2007.jpg, replace
clear
use ra_2008_allQ
line kdenrest1_rt_2008 kxrt2_2008 if  year==2008, xline( 9.16 ) yline(0) ytitle("") title("K-densities difference - 2008") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2008.jpg, replace
clear
use ra_2009_allQ
line kdenrest1_rt_2009 kxrt2_2009 if  year==2009, xline( 9.8 ) yline(0) ytitle("") title("K-densities difference - 2009") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2009.jpg, replace
clear
use ra_2010_allQ
line kdenrest1_rt_2010 kxrt2_2010 if  year==2010, xline( 10.3 ) yline(0) ytitle("") title("K-densities difference - 2010") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2010.jpg, replace
clear
use ra_2011_allQ
line kdenrest1_rt_2011 kxrt2_2011 if  year==2011, xline( 10 ) yline(0) ytitle("") title("K-densities difference - 2011") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2011.jpg, replace
clear
use ra_2012_allQ
line kdenrest1_rt_2012 kxrt2_2012 if  year==2012, xline( 7.2 ) yline(0) ytitle("") title("K-densities difference - 2012") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2012.jpg, replace
clear
use ra_2013_allQ
line kdenrest1_rt_2013 kxrt2_2013 if  year==2013, xline( 7.5 ) yline(0) ytitle("") title("K-densities difference - 2013") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2013.jpg, replace
clear
use ra_2014_allQ
line kdenrest1_rt_2014 kxrt2_2014 if  year==2014, xline( 8.7 ) yline(0) ytitle("") title("K-densities difference - 2014") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2014.jpg, replace
clear
use ra_2015_allQ
line kdenrest1_rt_2015 kxrt2_2015 if  year==2015, xline( 7.2 ) yline(0) ytitle("") title("K-densities difference - 2015") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2015.jpg, replace
clear
use ra_2016_allQ
line kdenrest1_rt_2016 kxrt2_2016 if  year==2016, xline( 13.07 ) yline(0) ytitle("") title("K-densities difference - 2016") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2016.jpg, replace
clear
use ra_2017_allQ
line kdenrest1_rt_2017 kxrt2_2017 if  year==2017, xline( 8 ) yline(0) ytitle("") title("K-densities difference - 2017") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2017.jpg, replace



********************************************************************************
* unobserved
foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 {
clear
use ra_`x'_allQ
replace ingocup_1=ingocup[_n-1] if time_wp!=1
replace ingocup_1=ingocup if time_wp==1

drop ln_ingocup

gen ln_ingocup=ln(ingocup_1)

eststo clear
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex  [fw=fac] if migest==0   & year==`x' & risk_averse==0
predict rt_unobs_nm_`x', residuals
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex  [fw=fac] if migest==1   & year==`x' & risk_averse==0 
predict rt_unobs_m_`x', residuals

eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex  [fw=fac] if migest==0   & year==`x' & risk_averse==1 
predict ra_unobs_nm_`x', residuals
eststo: reg ln_ingocup i.family i.married i.rural c.anios_esc_1 i.eda7c_1 i.edo_mig i.rama_1 i.sex  [fw=fac] if migest==1   & year==`x' & risk_averse==1 
predict ra_unobs_m_`x', residuals

save, replace
}



foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015  2016 2017{
clear
use ra_`x'_allQ  
drop kxrt1_`x' kert1_`x' kxrt2_`x' kert2_`x' kdenrest1_rt_`x' kxra1_`x' kera1_`x' kxra2_`x' kera2_`x' kdenrest1_ra_`x'
kdensity rt_unobs_nm_`x' [fw=fac] if  migest==0  & year==`x' , generate(kxrt1_`x' kert1_`x')  k(epan2) bw(1)
kdensity rt_unobs_m_`x' [fw=fac] if  migest==1 & year==`x' , generate(kxrt2_`x' kert2_`x')  k(epan2) bw(1)

gen kdenrest1_rt_`x'= kert2_`x' - kert1_`x'

kdensity ra_unobs_nm_`x' [fw=fac] if  migest==0  & year==`x' , generate(kxra1_`x' kera1_`x')  k(epan2) bw(1)
kdensity ra_unobs_m_`x' [fw=fac] if  migest==1  & year==`x' , generate(kxra2_`x' kera2_`x')  k(epan2) bw(1)

gen kdenrest1_ra_`x'= kera2_`x' - kera1_`x'

save, replace

}


foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ

tabstat  kxra2_`x'  , stats(p50)

}


* risk averse
clear
use ra_2007_allQ
line kdenrest1_ra_2007 kxra2_2007 if  year==2007, xline(-2 ) yline(0) ytitle("") title("K-densities difference - 2007") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2007.jpg, replace
clear
use ra_2008_allQ
line kdenrest1_ra_2008 kxra2_2008 if  year==2008, xline( -.5 ) yline(0) ytitle("") title("K-densities difference - 2008") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2008.jpg, replace
clear
use ra_2009_allQ
line kdenrest1_ra_2009 kxra2_2009 if  year==2009, xline( -1.2) yline(0) ytitle("") title("K-densities difference - 2009") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2009.jpg, replace
clear
use ra_2010_allQ
line kdenrest1_ra_2010 kxra2_2010 if  year==2010, xline( -.7 ) yline(0) ytitle("") title("K-densities difference - 2010") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2010.jpg, replace
clear
use ra_2011_allQ
line kdenrest1_ra_2011 kxra2_2011 if  year==2011, xline( -.9 ) yline(0) ytitle("") title("K-densities difference - 2011") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2011.jpg, replace
clear
use ra_2012_allQ
line kdenrest1_ra_2012 kxra2_2012 if  year==2012, xline( -.6 ) yline(0) ytitle("") title("K-densities difference - 2012") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2012.jpg, replace
clear
use ra_2013_allQ
line kdenrest1_ra_2013 kxra2_2013 if  year==2013, xline( -1 ) yline(0) ytitle("") title("K-densities difference - 2013") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2013.jpg, replace
clear
use ra_2014_allQ
line kdenrest1_ra_2014 kxra2_2014 if  year==2014, xline( .7 ) yline(0) ytitle("") title("K-densities difference - 2014") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2014.jpg, replace
clear
use ra_2015_allQ
line kdenrest1_ra_2015 kxra2_2015 if  year==2015, xline( -.4 ) yline(0) ytitle("") title("K-densities difference - 2015") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2015.jpg, replace
clear
use ra_2016_allQ
line kdenrest1_ra_2016 kxra2_2016 if  year==2016, xline( -.6 ) yline(0) ytitle("") title("K-densities difference - 2016") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2016.jpg, replace
clear
use ra_2017_allQ
line kdenrest1_ra_2017 kxra2_2017 if  year==2017, xline( -2.3) yline(0) ytitle("") title("K-densities difference - 2017") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RA_gen_unobs_diff_2017.jpg, replace





* risk taker

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
clear
use ra_`x'_allQ

tabstat  kxrt2_`x', stats(p50)

}


clear
use ra_2007_allQ
line kdenrest1_rt_2007 kxrt2_2007 if  year==2007, xline( .21 ) yline(0) ytitle("") title("K-densities difference - 2007") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2007.jpg, replace
clear
use ra_2008_allQ
line kdenrest1_rt_2008 kxrt2_2008 if  year==2008, xline( .2 ) yline(0) ytitle("") title("K-densities difference - 2008") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2008.jpg, replace
clear
use ra_2009_allQ
line kdenrest1_rt_2009 kxrt2_2009 if  year==2009, xline( -1.2 ) yline(0) ytitle("") title("K-densities difference - 2009") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2009.jpg, replace
clear
use ra_2010_allQ
line kdenrest1_rt_2010 kxrt2_2010 if  year==2010, xline( .3 ) yline(0) ytitle("") title("K-densities difference - 2010") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2010.jpg, replace
clear
use ra_2011_allQ
line kdenrest1_rt_2011 kxrt2_2011 if  year==2011, xline( -1.3) yline(0) ytitle("") title("K-densities difference - 2011") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2011.jpg, replace
clear
use ra_2012_allQ
line kdenrest1_rt_2012 kxrt2_2012 if  year==2012, xline( 1.2 ) yline(0) ytitle("") title("K-densities difference - 2012") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2012.jpg, replace
clear
use ra_2013_allQ
line kdenrest1_rt_2013 kxrt2_2013 if  year==2013, xline( .2 ) yline(0) ytitle("") title("K-densities difference - 2013") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2013.jpg, replace
clear
use ra_2014_allQ
line kdenrest1_rt_2014 kxrt2_2014 if  year==2014, xline( -.1 ) yline(0) ytitle("") title("K-densities difference - 2014") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2014.jpg, replace
clear
use ra_2015_allQ
line kdenrest1_rt_2015 kxrt2_2015 if  year==2015, xline( .5 ) yline(0) ytitle("") title("K-densities difference - 2015") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2015.jpg, replace
clear
use ra_2016_allQ
line kdenrest1_rt_2016 kxrt2_2016 if  year==2016, xline( .3 ) yline(0) ytitle("") title("K-densities difference - 2016") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2016.jpg, replace
clear
use ra_2017_allQ
line kdenrest1_rt_2017 kxrt2_2017 if  year==2017, xline( .6 ) yline(0) ytitle("") title("K-densities difference - 2017") graphregion(color(white)) bgcolor(white)
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_unobs_diff_2017.jpg, replace


***********************************************************************************











line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2008, xline( 7.0 ) yline(0) title("K-densities difference - 2008")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2008.jpg, replace
line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2009, xline( 7.0 ) yline(0) title("K-densities difference - 2009")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2009.jpg, replace
line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2010, xline( 7.0 ) yline(0) title("K-densities difference - 2010")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2010.jpg, replace
line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2011, xline( 7.0 ) yline(0) title("K-densities difference - 2011")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2011.jpg, replace
line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2012, xline( 7.0 ) yline(0) title("K-densities difference - 2012")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2012.jpg, replace
line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2013, xline( 7.0 ) yline(0) title("K-densities difference - 2013")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2013.jpg, replace
line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2014, xline( 7.0 ) yline(0) title("K-densities difference - 2014")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2014.jpg, replace
line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2015, xline( 7.0 ) yline(0) title("K-densities difference - 2015")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2015.jpg, replace
line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2016, xline( 7.0 ) yline(0) title("K-densities difference - 2016")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2016.jpg, replace
line kdenrest1_rtun_2008 kxrt2un_2008 if risk_averse==0 & year==2017, xline( 7.0 ) yline(0) title("K-densities difference - 2017")
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\RT_gen_obs_diff_2017.jpg, replace


*unobservable skills ***********************************************************


clear 
use ra_07_17_Q4
foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
tabstat  kxrt2un_`x'  if risk_averse==1 & year==`x' , stats(p50 )
}
line kdenrest1_rtun_2008 kxrt2un_2008, xline(8.36637 ) yline(0) title("K-densities difference (RT) - 2008")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2008.jpg, replace
line kdenrest1_rtun_2009 kxrt2un_2009, xline( 8.389359  ) yline(0) title("K-densities difference (RT) - 2009")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2009.jpg, replace
line kdenrest1_rtun_2010 kxrt2un_2010, xline(  8.433811 ) yline(0) title("K-densities difference (RT) - 2010")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2010.jpg, replace
line kdenrest1_rtun_2011 kxrt2un_2011, xline( 8.49699  ) yline(0) title("K-densities difference (RT) - 2011")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2011.jpg, replace
line kdenrest1_rtun_2013 kxrt2un_2013, xline(  8.548692 ) yline(0) title("K-densities difference (RT) - 2013")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2013.jpg, replace
line kdenrest1_rtun_2014 kxrt2un_2014, xline( 8.548692  ) yline(0) title("K-densities difference (RT) - 2014")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2014.jpg, replace
line kdenrest1_rtun_2015 kxrt2un_2015, xline( 8.589514  ) yline(0) title("K-densities difference (RT) - 2015")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2015.jpg, replace
line kdenrest1_rtun_2016 kxrt2un_2016, xline(  8.675905  ) yline(0) title("K-densities difference (RT) - 2016")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2016.jpg, replace






* Kernel Densities, basic and by pRA profile


foreach x in  2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 {
clear
use ra_`x'_allQ

twoway kdensity ln_ingocup [fw=fac] if migest==0 & year==`x', k(epan2) bw(1) legend(label(1 "Non migrant")) title("Kernel densities (`x')") ytitle("") xtitle("log monthly income") xscale(range(0 15))|| kdensity ln_ingocup [fw=fac] if migest==1 & year==`x', k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\kdensities\KD_lningocup_mignomig_`x'.jpg, replace 

}



* por año y risk position


*RA

foreach x in  2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 {
clear
use ra_`x'_allQ
	
twoway kdensity ln_ingocup [fw=fac] if migest==0 & year==`x' & risk_averse==1, k(epan2) bw(1) legend(label(1 "Non migrant")) title("RA Kernel densities (`x')") ytitle("") xtitle("log monthly income") xscale(range(0 15))|| kdensity ln_ingocup [fw=fac] if migest==1 & year==`x' & risk_averse==1, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\kdensities\KD_lningocup_mignomig_RA_`x'.jpg, replace 

}




* RT

foreach x in  2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 {
clear
use ra_`x'_allQ
twoway kdensity ln_ingocup [fw=fac] if migest==0 & year==`x' & risk_averse==0, k(epan2) bw(1) legend(label(1 "Non migrant")) title("RT Kernel densities (`x')") ytitle("") xtitle("log monthly income") xscale(range(0 15))|| kdensity ln_ingocup [fw=fac] if migest==1 & year==`x' & risk_averse==0, k(epan2) bw(1) legend(label(2 "Migrant")) graphregion(color(white)) bgcolor(white) xscale(range(0 15))
graph export D:\doctorado\respuesta_tesis\chpt_II\graphs\kdensities\KD_lningocup_mignomig_RT_`x'.jpg, replace 

}







//////////////////////////////////////////////////////////////////////////////////
************************

clear
use ra_07_17_Q4
foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
	sum year if year==`x'
eststo clear
eststo: reg ln_ingocup i.familia i.married i.rural c.anios_esc i.eda7c i.edo_mig i.rama i.sex#i.risk_averse [fw=fac] if migest_30==0  & risk_averse==1 & year==`x'
predict ra_obs_nm_`x'
predict ra_unobs_nm_`x', residuals
eststo: reg ln_ingocup i.familia i.married i.rural c.anios_esc i.eda7c i.edo_mig i.rama i.sex#i.risk_averse  [fw=fac] if migest_30==1 & risk_averse==1 & year==`x'
predict ra_obs_m_`x'
predict ra_unobs_m_`x', residuals
}



* observavble skills 

clear
use ra_07_17_Q4
foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
kdensity ra_obs_nm_`x' [fw=fac] if  migest_30==0 & risk_averse==1 & year==`x', generate(kxra1_`x' kera1_`x') nograph 
kdensity ra_obs_m_`x' [fw=fac] if  migest_30==1 & risk_averse==1 & year==`x', generate(kxra2_`x' kera2_`x') nograph 

gen kdenrest1_ra_`x'= kera2_`x' - kera1_`x'
}

save, replace

clear
use ra_07_12_17_Q4
foreach x in  2007 2012 2017 {
kdensity ra_obs_nm_`x' [fw=fac] if  migest_30==0 & risk_averse==1 & year==`x', generate(kxra1_`x' kera1_`x') nograph 
kdensity ra_obs_m_`x' [fw=fac] if  migest_30==1 & risk_averse==1 & year==`x', generate(kxra2_`x' kera2_`x') nograph 

gen kdenrest1_ra_`x'= kera2_`x' - kera1_`x'
}

save, replace

*unobservable skills 


clear
use ra_07_17_Q4
foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
kdensity ra_unobs_nm_`x' [fw=fac] if  migest_30==0 & risk_averse==1 & year==`x', generate(kxra1un_`x' kera1un_`x') nograph 
kdensity ra_unobs_m_`x' [fw=fac] if  migest_30==1 & risk_averse==1 & year==`x', generate(kxra2un_`x' kera2un_`x') nograph 
*tabstat ln_ingocup if risk_averse==0 & year==`x'
gen kdenrest1_raun_`x'= kera2un_`x' - kera1un_`x'
}

save, replace

clear
use ra_07_12_17_Q4
foreach x in  2007 2012 2017 {
kdensity ra_unobs_nm_`x' [fw=fac] if  migest_30==0 & risk_averse==1 & year==`x', generate(kxra1un_`x' kera1un_`x') nograph 
kdensity ra_unobs_m_`x' [fw=fac] if  migest_30==1 & risk_averse==1 & year==`x', generate(kxra2un_`x' kera2un_`x') nograph 
*tabstat ln_ingocup if risk_averse==1 & year==`x'
gen kdenresa1_rtun_`x'= kera2un_`x' - kera1un_`x'
}

save, replace

/*
clear 
use ra_07_17_Q4
drop if year==2007 | year==2012 | year==2017
append using ra_07_12_17_Q4
save, replace
*/

* obs skills

clear 
use ra_07_17_Q4
foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
*sum year if year==`x'
tabstat ln_ingocup if risk_averse==1 & year==`x' , stats(p50 )
}
line kdenrest1_ra_2008 kxra2_2008, xline(8.36637 ) yline(0) title("K-densities difference (RA) - 2008")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2008.jpg, replace
line kdenrest1_ra_2009 kxra2_2009, xline( 8.389359 ) yline(0) title("K-densities difference (RA) - 2009")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2009.jpg, replace
line kdenrest1_ra_2010 kxra2_2010, xline( 8.433811  ) yline(0) title("K-densities difference (RA) - 2010")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2010.jpg, replace
line kdenrest1_ra_2011 kxra2_2011, xline( 8.49699 ) yline(0) title("K-densities difference (RA) - 2011")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2011.jpg, replace
line kdenrest1_ra_2013 kxra2_2013, xline( 8.548692  ) yline(0) title("K-densities difference (RA) - 2013")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2013.jpg, replace
line kdenrest1_ra_2014 kxra2_2014, xline( 8.548692  ) yline(0) title("K-densities difference (RA) - 2014")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2014.jpg, replace
line kdenrest1_ra_2015 kxra2_2015, xline( 8.589514  ) yline(0) title("K-densities difference (RA) - 2015")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2015.jpg, replace
line kdenrest1_ra_2016 kxra2_2016, xline( 8.675905  ) yline(0) title("K-densities difference (RA) - 2016")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2016.jpg, replace



clear
use ra_07_12_17_Q4
foreach x in  2007 2012 2017 {
*sum year if year==`x'
tabstat ln_ingocup if risk_averse==1 & year==`x' , stats(p50 )
}
line kdenrest1_ra_2007 kxra2_2007, xline( 8.386173  ) yline(0) title("K-densities difference (RA) - 2007")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2007.jpg, replace
line kdenrest1_ra_2012 kxra2_2012, xline( 8.49699  ) yline(0) title("K-densities difference (RA) - 2012")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2012.jpg, replace
line kdenrest1_ra_2017 kxra2_2017, xline( 8.702843  ) yline(0) title("K-densities difference (RA) - 2017")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RA_gen_obs_diff_2017.jpg, replace



*unobservable skills ***********************************************************

/*
clear 
use ra_07_17_Q4
foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
tabstat  kxrt2un_`x'  if risk_averse==1 & year==`x' , stats(p50 )
}
line kdenrest1_rtun_2008 kxrt2un_2008, xline(8.36637 ) yline(0) title("K-densities difference (RT) - 2008")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2008.jpg, replace
line kdenrest1_rtun_2009 kxrt2un_2009, xline( 8.389359  ) yline(0) title("K-densities difference (RT) - 2009")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2009.jpg, replace
line kdenrest1_rtun_2010 kxrt2un_2010, xline(  8.433811 ) yline(0) title("K-densities difference (RT) - 2010")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2010.jpg, replace
line kdenrest1_rtun_2011 kxrt2un_2011, xline( 8.49699  ) yline(0) title("K-densities difference (RT) - 2011")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2011.jpg, replace
line kdenrest1_rtun_2013 kxrt2un_2013, xline(  8.548692 ) yline(0) title("K-densities difference (RT) - 2013")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2013.jpg, replace
line kdenrest1_rtun_2014 kxrt2un_2014, xline( 8.548692  ) yline(0) title("K-densities difference (RT) - 2014")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2014.jpg, replace
line kdenrest1_rtun_2015 kxrt2un_2015, xline( 8.589514  ) yline(0) title("K-densities difference (RT) - 2015")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2015.jpg, replace
line kdenrest1_rtun_2016 kxrt2un_2016, xline(  8.675905  ) yline(0) title("K-densities difference (RT) - 2016")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2016.jpg, replace



clear
use ra_07_12_17_Q4
foreach x in  2007 2012 2017 {
tabstat ln_ingocup  if risk_averse==1 & year==`x' , stats(p50 )
}
line kdenrest1_rtun_2007 kxrt2un_2007, xline(  8.386173 ) yline(0) title("K-densities difference (RT) - 2007")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2007.jpg, replace
line kdenrest1_rtun_2012 kxrt2un_2012, xline(  8.49699 ) yline(0) title("K-densities difference (RT) - 2012")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2012.jpg, replace
line kdenrest1_rtun_2017 kxrt2un_2017, xline( 8.702843  ) yline(0) title("K-densities difference (RT) - 2017")
graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\kdensities_diff\RT_gen_unobs_diff_2017.jpg, replace


*/





* for cfd

clear
use ra_07_17_Q4
keep ln_ingocup year risk_averse migest_30 fac
save ra_07_17_Q4_CFD, replace 

clear
use ra_07_12_17_Q4
keep ln_ingocup year risk_averse migest_30 fac
save ra_07_12_17_Q4_CFD, replace 


* Cumulative funtion graphs


clear
use ra_07_17_Q4_CFD

cumul ln_ingocup [fw=fac] if  migest_30==0 , gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 , gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Cumulatives:" "2007 - 2017 log income p/hour") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\CFD\CFD_mignomig_general.jpg, replace

*risk averse

clear
use ra_07_17_Q4_CFD

cumul ln_ingocup [fw=fac] if  migest_30==0 & risk_averse==1 , gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & risk_averse==1 , gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Cumulatives:" "2007 - 2017 log income (RA)") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\CFD\RA_CFD_mignomig_general.jpg, replace

*risk takers

clear
use ra_07_17_Q4_CFD

cumul ln_ingocup [fw=fac] if  migest_30==0 & risk_averse==0 , gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & risk_averse==0 , gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("Cumulatives:" "2007 - 2017 log income (RT)") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\CFD\RT_CFD_mignomig_general.jpg, replace

* cumulatives by year


foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
clear
use ra_07_17_Q4_CFD

cumul ln_ingocup [fw=fac] if  migest_30==0 & year==`x' , gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & year==`x' , gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("CFD `x'") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export  D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\CFD\by_year\CFD_mignomig_`x'.jpg, replace

}

foreach x in  2007 2012 2017 {
clear
use ra_07_12_17_Q4_CFD

cumul ln_ingocup [fw=fac] if  migest_30==0 & year==`x' , gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & year==`x' , gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("CFD `x'") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export  D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\CFD\by_year\CFD_mignomig_`x'.jpg, replace
}


**
* cumulatives by risk aversion profile  and year

* risk averse 


foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
clear
use ra_07_17_Q4_CFD

cumul ln_ingocup [fw=fac] if  migest_30==0 & year==`x' & risk_averse==1, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & year==`x' & risk_averse==1, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("CFD `x' - (RA)") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export  D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\CFD\by_year_RA_RT\CFD_mignomig_`x'.jpg, replace
}

foreach x in  2007 2012 2017 {
clear
use ra_07_12_17_Q4_CFD

cumul ln_ingocup [fw=fac] if  migest_30==0 & year==`x' & risk_averse==0, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & year==`x' & risk_averse==0, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("CFD `x' - (RA)") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export  D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\CFD\by_year_RA_RT\RA_CFD_mignomig_`x'.jpg, replace
}




* risk takers

foreach x in  2008 2009 2010 2011  2013 2014 2015 2016 {
clear
use ra_07_17_Q4_CFD

cumul ln_ingocup [fw=fac] if  migest_30==0 & year==`x' & risk_averse==0, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & year==`x' & risk_averse==0, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("CFD `x' - (RT)") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export  D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\CFD\by_year_RA_RT\RT_CFD_mignomig_`x'.jpg, replace
}

foreach x in  2007 2012 2017 {
clear
use ra_07_12_17_Q4_CFD

cumul ln_ingocup [fw=fac] if  migest_30==0 & year==`x' & risk_averse==0, gen(ln_ing_nomig) 
line ln_ing_nomig ln_ingocup, sort

cumul ln_ingocup [fw=fac] if  migest_30==1 & year==`x' & risk_averse==0, gen(ln_ing_mig) 
line ln_ing_mig ln_ingocup, sort

stack ln_ing_nomig ln_ingocup ln_ing_mig ln_ingocup, into(c ing) wide clear

line ln_ing_nomig ln_ing_mig ing,  sort xtitle("Log monthly income") title("CFD `x' - (RT)") subtitle("migrants and non-migrants") legend(label(1 "Non migrant") label( 2 "Migrant"))

graph export  D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\grphs\CFD\by_year_RA_RT\RT_CFD_mignomig_`x'.jpg, replace
}
