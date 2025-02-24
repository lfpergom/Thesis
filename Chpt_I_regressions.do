* regressions


gen eda2=eda^2
gen anios_esc2=anios_esc_1^2



eststo clear
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.migest  [fw=fac]
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==0 & risk_averse==0 
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==1 & risk_averse==0 
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==0 & risk_averse==1 
eststo: reg ln_ingocup i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==1 & risk_averse==1 

esttab using D:\doctorado\respuesta_tesis\chpt_I\regressions\ln_ingocup_mignomig.tex, replace ///
    se pr2 ///
    label                               ///
title(Results, RA index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)

eststo clear
eststo: reghdfe ln_ingocup i.family i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.migest i.risk_averse [fw=fac] , a(year sex)
eststo: reghdfe ln_ingocup i.family i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.risk_averse [fw=fac] if migest==0 , a(year sex) 
eststo: reghdfe ln_ingocup i.family i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.risk_averse [fw=fac] if migest==1 , a(year sex) 

esttab using D:\doctorado\respuesta_tesis\chpt_I\regressions\ln_ingocup_FE_mignomig.tex, replace ///
    se r2 ar2 ///
    label                               ///
title(Results, RA index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)


* reg for the risk aversion index



eststo clear
eststo: reg risk_a i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc c.eda i.gob_supp i.migest [fw=fac]
eststo: reg risk_a i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==0 & risk_averse==0 
eststo: reg risk_a i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==1 & risk_averse==0 
eststo: reg risk_a i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==0 & risk_averse==1 
eststo: reg risk_a i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==1 & risk_averse==1 

esttab using D:\doctorado\respuesta_tesis\chpt_I\regressions\RA_V1_index_mignomig.tex, replace ///
    se r2 ///
    label                               ///
title(Results, RA index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)


eststo clear

eststo: reghdfe risk_a i.family i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.migest i.risk_averse [fw=fac] , a(year sex)
eststo: reghdfe risk_a i.family i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.risk_averse [fw=fac] if migest==0 , a(year sex) 
eststo: reghdfe risk_a i.family i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.risk_averse [fw=fac] if migest==1 , a(year sex) 

esttab using D:\doctorado\respuesta_tesis\chpt_I\regressions\RA_V1_index_FE_mignomig_test.tex, replace ///
    se r2 ar2 ///
    label                               ///
title(Results, RA index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)

sum risk_a
gen riska_index=risk_a+.7456914

sum risk_a
sum riska_index


eststo clear
eststo: reg riska_index i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.migest [fw=fac]
eststo: reg riska_index i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==0 & risk_averse==0 
eststo: reg riska_index i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==1 & risk_averse==0 
eststo: reg riska_index i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==0 & risk_averse==1 
eststo: reg riska_index i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp [fw=fac] if migest==1 & risk_averse==1 

esttab using D:\doctorado\respuesta_tesis\chpt_I\regressions\RA_V2_index_mignomig.tex, replace ///
    se r2 ///
    label                               ///
title(Results, RA index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)


eststo clear

eststo: reghdfe riska_index i.family i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.migest i.risk_averse [fw=fac] , a(year sex)
eststo: reghdfe riska_index i.family i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.risk_averse [fw=fac] if migest==0 , a(year sex) 
eststo: reghdfe riska_index i.family i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.gob_supp i.risk_averse [fw=fac] if migest==1 , a(year sex) 

esttab using D:\doctorado\respuesta_tesis\chpt_I\regressions\RA_V2_index_FE_mignomig_test.tex, replace ///
    se r2 ar2 ///
    label                               ///
title(Results, RA index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)

 

eststo clear

eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest i.yr_2007 [fw=fac]
eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest i.yr_2012 [fw=fac]
eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest i.yr_2017 [fw=fac]
eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest i.yr_2007 i.yr_2012 i.yr_2017 [fw=fac]
eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest [fw=fac], vce(cl year)

esttab using D:\doctorado\respuesta_tesis\chpt_I\regressions\RA_dummy_mignomig_simple.tex, replace ///
    se pr2 ///
    label                               ///
title(Results, RA index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)

eststo clear

eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest i.yr_2007 [fw=fac], robust
eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest i.yr_2012 [fw=fac], robust
eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest i.yr_2017 [fw=fac], robust
eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest i.yr_2007 i.yr_2012 i.yr_2017 [fw=fac], robust
eststo: probit risk_averse i.family i.sex i.edo_mig i.e_con i.rural c.anios_esc_1 c.eda i.rama i.gob_supp i.migest [fw=fac], vce(cl year)

esttab using D:\doctorado\respuesta_tesis\chpt_I\regressions\RA_dummy_mignomig_robust.tex, replace ///
    se pr2 ///
    label                               ///
title(Results, RA index regressions (all))       ///
starlevels( + .1 * 0.05 ** 0.01)


