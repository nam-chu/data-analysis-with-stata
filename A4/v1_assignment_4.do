
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
	append using "assignment_4_data_`j'.dta"
}
save "$input/assignment_4_data.dta", replace

**************************
	*Question 2a
**************************

**************************
	*Question 2b
**************************

foreach var in varlist {
	replace ".a" == ""
}
