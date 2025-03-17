
clear 
set more off
set type double
capture log close


global path "/Users/home_folder/ECON 2708/Deliverables/Assignments/2708_A4/Data"
global input "$path/Input" 
global output "$path/Output"
global temp "$path/Temp"

log using "$path/Logs/v1_assignment_4", text replace


**************************
	*Question 1b and c*
**************************


/*
The first loop brings all the excel sheets into stata and then saves them as .dta. The second loop then appends them onto the first dataset and renames it.
*/

	forvalues i = 1/4 {
		import excel "/Users/home_folder/ECON 2708/Deliverables/Assignments/2708_A4/Data/Input/EVSdata.xlsx", sheet("Wave `i'") firstrow
		save "$temp/assignment_4_data_`i'.dta", replace
		clear
	} 

	use "$temp/assignment_4_data_1.dta", clear

	forvalues j = 2/4 {
		append using "$temp/assignment_4_data_`j'.dta"
	}
	save "$input/assignment_4_data.dta", replace


**************************
	*Question 2a
**************************

* group renaming everything
	use "$input/assignment_4_data", clear
	rename (S002EVS S003 S006 A009 A170 C036 C037 C038 C039 C041 X001 X003 X007 X011_01 X025A X028 X047D) (evs_wave country resp_num state_of_health /// 
	satisfaction_life talents_job receive_money work_lazy work_duty work_spare_time sex ///
	age marital_status children educational_level employment_status month_income)


**************************
	*Question 2b
**************************

* checking whether the first four columns have .a in any observations

	tabulate(evs_wave) 
	tabulate (country) 

	foreach var of varlist state_of_health-month_income {
	replace `var' = "" if `var' == ".a"
	}



**************************
	*Question 2c
**************************

* (i)
	
	// replace all instances of 10 and 1 with satisfied and dissatisfied, respectivly. Destring all instances in satisfaction life 
	replace satisfaction_life = "10" if satisfaction_life == "Satisfied"
	replace satisfaction_life = "1" if satisfaction_life == "Dissatisfied"
	destring satisfaction_life, replace
	
	
* (ii)
	
	// go through varlist and replace each instance of each variable accordingly
	foreach var of varlist talents_job-work_spare_time {
		replace `var' = "1" if `var' == "Strongly disagree"
		replace `var' = "2" if `var' == "Disagree"
		replace `var' = "3" if `var' == "Neither agree nor disagree"
		replace `var' = "4" if `var' == "Agree"
		replace `var' = "5" if `var' == "Strongly agree"
	}
	// destringing every string in the above varlist
	foreach var of varlist talents_job-work_spare_time {
		destring `var', replace
	}

* (iii)
	// replace all instances of entry accordingly.
	replace state_of_health = "1" if state_of_health == "Very poor"
	replace state_of_health = "2" if state_of_health == "Poor"
	replace state_of_health = "3" if state_of_health == "Fair"
	replace state_of_health = "4" if state_of_health == "Good"
	replace state_of_health = "5" if state_of_health == "Very good"
	// destring the variable
	destring state_of_health, replace

* (iv)

	// defines value labels 
	label define wave_label 1 "1981-1984" 2 "1990-1993" 3 "1999-2001" 4 "2008-2010"
	
	// encode all values 
	encode evs_wave, gen(wave_num) label(wave_label) 
	
	// dropping, renaming, and reordering
	drop evs_wave
	rename wave_num evs_wave
	order evs_wave, before (country)
	
	// generates a sex dummy if sex is equal to male (1) otherwise, assignment 0 
	gen sex_dummy = (sex == "Male") if inlist(sex, "Male", "Female")
	
	// check to see if anything is missing 
	tab sex sex_dummy, missing
	
	// drops the sex variable and renames the sex_dummy to align with data dictionary. 
	drop sex
	rename sex_dummy sex
	order sex, after (work_spare_time) // moves the sex value to appropriate place to match data dictionary
	
* (v)
	// destringing
	destring month_income age, replace 
	*codebook month_income age

* (vi)
	// replace and destring
	replace children = "0" if children == "No children"
	destring children, replace
	
* (vii)

	// creates a substring that separates the first number and the text part of the answer
	gen education_numeric = substr(educational_level, 1, 1)
	destring education_numeric, replace
	order education_numeric, before(educational_level)

* (viii)

	// creating a dummy variable 
	gen married = (marital_status == "Married" | marital_status == "Living together as married") ///
    if inlist(marital_status, "Married", "Living together as married", "Divorced", "Separated", "Single/Never married", "Widowed")
	
	tab married marital_status, missing
	
**************************
	*Question 2d
**************************
	
	// needs some work 
	egen indiv_work_ethic = rowmean(talents_job-work_spare_time)

	egen work_ethic = mean(indiv_work_ethic), by(country evs_wave)
	egen work_ethic_ = mean(indiv_work_ethic), by(country evs_wave)


**************************
	*Question 2e
**************************
	
	* Generate full-time dummy 
 	gen full_time_dummy = (employment_status == "Full time") if employment_status != ""

* Generate unemployed dummy
	gen unemployed_dummy = (employment_status == "Unemployed") if employment_status != ""

* Generate other employed dummy (Part time or Self employed)
	gen other_employed_dummy = (employment_status == "Part time" | employment_status == "Self employed") if employment_status != ""

	
