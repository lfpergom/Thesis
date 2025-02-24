
clear

set more off, permanently


cd D:\doctorado\articulo_1\data_1\MMP\main_data\
use mig170


keep crsyr1	crsyr2	crsyr3	crsyr4	crsyr5	crsyr6	crsyr7	crsyr8	crsyr9	crsyr10	crsyr11	crsyr12	crsyr13	crsyr14	crsyr15	crsyr16	crsyr17	crsyr18	crsyr19	crsyr20	crsyr21	crsyr22	crsyr23	crsyr24	crsyr25	crsyr26	crsyr27	crsyr28	crsyr29	crsyr30	crscst1	crscst2	crscst3	crscst4	crscst5	crscst6	crscst7	crscst8	crscst9	crscst10	crscst11	crscst12	crscst13	crscst14	crscst15	crscst16	crscst17	crscst18	crscst19	crscst20	crscst21	crscst22	crscst23	crscst24	crscst25	crscst26	crscst27	crscst28	crscst29	crscst30 w_int

* after the 23rd time there is no data

gen sample=0
gen cont=0

foreach y in 1 2 3  4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30{

*tab crsyr`y'



count  if crsyr`y'==2005
count  if crsyr`y'==2006
count  if crsyr`y'==2007
count  if crsyr`y'==2008
count  if crsyr`y'==2009
count  if crsyr`y'==2010
count  if crsyr`y'==2011
count  if crsyr`y'==2012
count  if crsyr`y'==2013
count  if crsyr`y'==2014
count  if crsyr`y'==2015
count  if crsyr`y'==2016
count  if crsyr`y'==2017

replace crsyr`y'=. if crsyr`y'==8888 | crsyr`y'==9999
replace crscst`y'=. if crscst`y'==8888 | crscst`y'==9999

replace cont=1 if crsyr`y'==2005 
replace cont=2 if crsyr`y'==2006 
replace cont=3 if crsyr`y'==2007 
replace cont=4 if crsyr`y'==2008
replace cont=5 if crsyr`y'==2009 
replace cont=6 if crsyr`y'==2010 
replace cont=7 if crsyr`y'==2011 
replace cont=8 if crsyr`y'==2012 
replace cont=9 if crsyr`y'==2013 
replace cont=10 if crsyr`y'==2014 
replace cont=11 if crsyr`y'==2015 
replace cont=12 if crsyr`y'==2016 
replace cont=13 if crsyr`y'==2017 

}

gen year=2005 if cont==1
replace year=2006 if cont==2
replace year=2007 if cont==3
replace year=2008 if cont==4
replace year=2009 if cont==5
replace year=2010 if cont==6
replace year=2011 if cont==7
replace year=2012 if cont==8
replace year=2013 if cont==9
replace year=2014 if cont==10
replace year=2015 if cont==11
replace year=2016 if cont==12
replace year=2017 if cont==13

keep if cont!=0

local cost_var crscst1 crscst2 crscst3 crscst4 crscst5 crscst6 crscst7 crscst8 crscst9 crscst10 crscst11 crscst12 crscst13 crscst14 crscst15 crscst16 crscst17 crscst18 crscst19 crscst20 crscst21 crscst22 crscst23

foreach x of local cost_var{

tabstat `x' [fw=w_int], stats(N mean p50 sd var min max)
}


collapse crscst1 crscst2 crscst3 crscst4 crscst5 crscst6 crscst7 crscst8 crscst9 crscst10 crscst11 crscst12 crscst13 crscst14 crscst15 crscst16 crscst17 crscst18 crscst19 crscst20 crscst21 crscst22 crscst23 [fw=w_int] , by(year)


local cost_var crscst1 crscst2 crscst3 crscst4 crscst5 crscst6 crscst7 crscst8 crscst9 crscst10 crscst11 crscst12 crscst13 crscst14 crscst15 crscst16 crscst17 crscst18 crscst19 crscst20 crscst21 crscst22 crscst23

foreach x of local cost_var{

tabstat `x', stats(N mean p50 sd var min max)
}


egen mean_cost= rowmean(crscst1 crscst2 crscst3 crscst4 crscst5 crscst6 crscst7 crscst8 crscst9 crscst10 crscst11 crscst12 crscst13 crscst14 crscst15 crscst16 crscst17 crscst18 crscst19 crscst20 crscst21 crscst22 crscst23) 

replace mean_cost=(mean_cost[_n-1]+mean_cost[_n+1])/2 if year==2014
replace mean_cost=(mean_cost[_n-1]+mean_cost[_n+1])/2 if year==2016

egen max_cost= rowmax(crscst1 crscst2 crscst3 crscst4 crscst5 crscst6 crscst7 crscst8 crscst9 crscst10 crscst11 crscst12 crscst13 crscst14 crscst15 crscst16 crscst17 crscst18 crscst19 crscst20 crscst21 crscst22 crscst23) 

replace max_cost=(max_cost[_n-1]+max_cost[_n+1])/2 if year==2014
replace max_cost=(max_cost[_n-1]+max_cost[_n+1])/2 if year==2016

egen median_cost= rowmedian(crscst1 crscst2 crscst3 crscst4 crscst5 crscst6 crscst7 crscst8 crscst9 crscst10 crscst11 crscst12 crscst13 crscst14 crscst15 crscst16 crscst17 crscst18 crscst19 crscst20 crscst21 crscst22 crscst23) 

replace median_cost=(median_cost[_n-1]+median_cost[_n+1])/2 if year==2014
replace median_cost=(median_cost[_n-1]+median_cost[_n+1])/2 if year==2016

keep year mean_cost max_cost median_cost


save mig_cost_ag, replace

clear

import excel using "D:\doctorado\articulo_1\data_1\MMP\exch_rate.xlsx", first

merge 1:1 year using mig_cost_ag

keep if _merge==3
drop _merge

gen mean_mig_cost_pesos=exch_rate_pxd* mean_cost
gen med_mig_cost_pesos=exch_rate_pxd* median_cost
gen max_cost_pesos=exch_rate_pxd* max_cost



save "D:\data\ENOE\Chpt_I_II\final\mig_cost_pxd.dta", replace