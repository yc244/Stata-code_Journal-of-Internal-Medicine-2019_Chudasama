
* Stata-code_Journal-of-Internal-Medicine-2019_Chudasama
* Yogini V Chudasama
* Leisure-time Physical Activity and Life Expectancy in people with Cardiometabolic 
* Multimorbidity and Depression 2019


*----------------*
* Baseline data  *
*----------------*
count
tab disease
tab dead
tab disease dead, row
tab disease if dead==1
centile years, centile(50,25,75)
sum age, d
tab  ltpa_500
tab  ltpa_500 disease, col

* How many in stroke, mi, hf, etc
tab stroke if (diabetes==0 & depression==0 )
tab mi if (diabetes==0 & depression==0 )
tab heartf if  (diabetes==0 & depression==0 )
tab angina if  (diabetes==0 & depression==0 )
tab pvd if  (diabetes==0 & depression==0 )

* Baseline table
tab disease 

*Age
forval i= 0/7 {
	centile age if disease==`i' , centile(50,25,75)
	 display "`i'"
	}
	
forval i= 0/7 {
	centile age if disease==`i' & ltpa_500==0 , centile(50,25,75)
	 display "`i'"
	}
	
	forval i= 0/7 {
	centile age if disease==`i' & ltpa_500==1 , centile(50,25,75)
	 display "`i'"
	}

* sex
forval i= 0/7 {
	tab sex if disease==`i' 
	 display "`i'"
	} 
			
forval i= 0/7 {
	tab sex if disease==`i'  & ltpa_500==0
	 display "`i'"
	} 
	
	forval i= 0/7 {
	tab sex if disease==`i'  & ltpa_500==1
	 display "`i'"
	} 
	
*newethnic 
forval i= 0/7 {
	tab newethnic if disease==`i' 
	 display "`i'"
	} 
			
forval i= 0/7 {
	tab newethnic if disease==`i'  & ltpa_500==0
	 display "`i'"
	} 
	
	forval i= 0/7 {
	tab newethnic if disease==`i'  & ltpa_500==1
	 display "`i'"
	} 
	
* twn2 
forval i= 0/7 {
	tab twn2 if disease==`i' 
	 display "`i'"
	} 
			
forval i= 0/7 {
	tab twn2 if disease==`i'  & ltpa_500==0
	 display "`i'"
	} 
	
	forval i= 0/7 {
	tab twn2 if disease==`i'  & ltpa_500==1
	 display "`i'"
	} 	
	
* empcat 
forval i= 0/7 {
	tab empcat if disease==`i' 
	 display "`i'"
	} 
			
forval i= 0/7 {
	tab empcat if disease==`i'  & ltpa_500==0
	 display "`i'"
	} 
	
	forval i= 0/7 {
	tab empcat if disease==`i'  & ltpa_500==1
	 display "`i'"
	} 	
	
	
* excess_alcohol 
forval i= 0/7 {
	tab excess_alcohol if disease==`i' 
	 display "`i'"
	} 
			
forval i= 0/7 {
	tab excess_alcohol if disease==`i'  & ltpa_500==0
	 display "`i'"
	} 
	
	forval i= 0/7 {
	tab excess_alcohol if disease==`i'  & ltpa_500==1
	 display "`i'"
	} 	
	
*  smoke
forval i= 0/7 {
	tab smoke if disease==`i' 
	 display "`i'"
	} 
			
forval i= 0/7 {
	tab smoke if disease==`i'  & ltpa_500==0
	 display "`i'"
	} 
	
	forval i= 0/7 {
	tab smoke if disease==`i'  & ltpa_500==1
	 display "`i'"
	} 	
	
	
*   guideline_fruitveg  
forval i= 0/7 {
	tab guideline_fruitveg if disease==`i' 
	 display "`i'"
	} 
			
forval i= 0/7 {
	tab guideline_fruitveg if disease==`i'  & ltpa_500==0
	 display "`i'"
	} 
	
	forval i= 0/7 {
	tab guideline_fruitveg if disease==`i'  & ltpa_500==1
	 display "`i'"
	} 	
	
	
*  bmi  
forval i= 0/7 {
	sum bmi if disease==`i' 
	 display "`i'"
	}
	
	forval i= 0/7 {
	sum bmi if disease==`i'  & ltpa_500==0
	 display "`i'"
	 }
	 
	forval i= 0/7 {
	sum bmi if disease==`i'  & ltpa_500==1
	 display "`i'"
	}
	
* sedtime  
forval i= 0/7 {
	sum sedtime if disease==`i' 
	 display "`i'"
	}
	
	forval i= 0/7 {
	sum sedtime if disease==`i'  & ltpa_500==0
	 display "`i'"
	 }
	 
	forval i= 0/7 {
	sum sedtime if disease==`i'  & ltpa_500==1
	 display "`i'"
	}
	
	
**********************************************************************************

*------------------*
* FP Hazard Ratios *
*------------------*
tab disease 
tab disease dead, row
tab disease if dead==1

// set age as time timescale 
stset currentag, failure(dead == 1) enter(age)  

* using strate
 strate disease , per(1000)  
 
  //flexible parametric surival regression model 
stpm2 i.disease, df(4) scale(hazard) eform nolog   
stpm2 i.disease cancer sex newethnic twn2 i.empcat , df(4) scale(hazard) eform nolog  
stpm2 i.disease cancer sex	newethnic twn2 i.empcat bmi  sedtime  excess_alcohol i.smoke guideline_fruitveg  , df(4) scale(hazard) eform nolog   
 
  
 ** ltpa_500
tab  ltpa_500 disease, col  
tab  disease dead if ltpa_500==0, row
tab  disease dead if ltpa_500==1, row

 strate disease if ltpa_500==0 , per(1000)  
 strate disease if ltpa_500==1, per(1000)  
  	
forval i= 0/7 {
stpm2 i.ltpa_500 if disease==`i', df(4) scale(hazard) eform nolog
	 display "`i'"
	} 
 
forval i= 0/7 {
stpm2 i.ltpa_500 cancer sex newethnic twn2 i.empcat if disease==`i', df(4) scale(hazard) eform nolog
	 display "`i'"
	} 
	
	forval i= 0/7 {
stpm2 i.ltpa_500 cancer sex newethnic twn2 i.empcat bmi  sedtime  excess_alcohol i.smoke guideline_fruitveg if disease==`i', df(4) scale(hazard) eform nolog
	 display "`i'"
	}  
	
	
********************************************************************************	
* Example of life expectancy calculation 

set more off 
clear
cd "\\uol.le.ac.uk\root\staff\home\y\yc244\My Documents\1 PhD Folder\7 Data\Data"
use "UKKBB_CMMH_07March2019.dta", clear

stset currentag, failure(dead == 1) enter(age)  

// create an empty file to save the yll results - run
stpm2 i.disease cancer sex	newethnic twn2 i.empcat bmi  sedtime  excess_alcohol i.smoke guideline_fruitveg, df(4) scale(hazard) eform nolog   

preserve
clear
tempfile results1
save `results1', emptyok replace
restore
timer clear 1
// create the conditional age and the time variable
forval d= 0/7 {
foreach i  of num 45(1)100 {
		timer on 1
		preserve
		gen t`i'= `i' in 1/100  
		range tt`i' `i' 100 100
	    predictnl d`i'`d' = predict(meansurv timevar(tt`i') at(disease `d')) / predict(meansurv timevar(t`i') at(disease `d'))  
		integ d`i'`d' tt`i'
	    scalar area_d`i'`d' = r(integral)
		clear
		set obs 1
		gen cond = `i'
		gen erl`d' = area_d`i'`d'
		append using `results1'
		save `results1', replace
		restore
		timer off 1
	  }
	  }
timer list 1    
use `results1', clear
save "yll_lifestyle_March2019.dta", replace

********************************************************************************




	
	
	
	
	
	
	