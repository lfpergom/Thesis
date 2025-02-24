clear
set more off, permanently


cd D:\data\ENOE\paper_1\raw_a1\paneles

use ra_07_17_Q4

fre sex


prop migest_30 [fw=fac] if sex==2, over(year)
prop migest_30 [fw=fac] if sex==1, over(year)

prop sex [fw=fac] if migest_30==0, over(year)
prop sex [fw=fac] if migest_30==1, over(year)





mean anios_esc [fw=fac] if sex==2 & migest_30==0, over(year)
mean anios_esc [fw=fac] if sex==2 & migest_30==1, over(year)

mean anios_esc [fw=fac] if sex==1 & migest_30==0, over(year)
mean anios_esc [fw=fac] if sex==1 & migest_30==1, over(year)



mean ing_x_hrs [fw=fac] if sex==2 & migest_30==0, over(year)
mean ing_x_hrs [fw=fac] if sex==2 & migest_30==1, over(year)

mean ing_x_hrs [fw=fac] if sex==1 & migest_30==0, over(year)
mean ing_x_hrs [fw=fac] if sex==1 & migest_30==1, over(year)

mean ingocup [fw=fac] if sex==2 & migest_30==0, over(year)
mean ingocup [fw=fac] if sex==2 & migest_30==1, over(year)

mean ingocup [fw=fac] if sex==1 & migest_30==0, over(year)
mean ingocup [fw=fac] if sex==1 & migest_30==1, over(year)



mean eda [fw=fac] if sex==2 & migest_30==0, over(year)
mean eda [fw=fac] if sex==2 & migest_30==1, over(year)

mean eda [fw=fac] if sex==1 & migest_30==0, over(year)
mean eda [fw=fac] if sex==1 & migest_30==1, over(year)




