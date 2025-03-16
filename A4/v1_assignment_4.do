
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
	*Question 2b
**************************

* Part c(vii)
gen education_numeric = substr(educational_level, 1, 1)
