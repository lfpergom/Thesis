clear
set more off, permanently


cd D:\data\ENOE\paper_1\raw_a1\paneles


use ra_07_17_Q4

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
    gen year_`x'=0
	replace year_`x'=1 if year==`x'
}



eststo clear
foreach y in 1 {
    eststo clear
eststo: reg ln_ingocup i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex i.migest_30 i.risk_averse if migest_30==`y'
/*
esttab using D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\reg_simple.csv, replace ///
    se r2 ///
    label                               ///
title(Results, Hourly income regressions (female))       ///
starlevels( + .1 * 0.05 ** 0.01)
*/

foreach x in 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017{
eststo: reg ln_ingocup i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex i.risk_averse i.year_`x' if migest_30==`y'

}
eststo: reg ln_ingocup i.familia i.edo_mig i.married i.rural c.anios_esc c.eda i.rama i.sex i.risk_averse i.year_2007 i.year_2008 i.year_2009 i.year_2010 i.year_2011 i.year_2012 i.year_2013 i.year_2014 i.year_2015 i.year_2016 i.year_2017 if migest_30==`y'


}
esttab using D:\doctorado\tesis_reestrutura\borrador_ChptII_2023\reg_migall_complete.tex, replace ///
    se r2 ///
    label                               ///
title(Results, Hourly income regressions (female))       ///
starlevels( + .1 * 0.05 ** 0.01)