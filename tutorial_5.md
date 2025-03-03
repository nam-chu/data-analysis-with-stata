# Tutorial 5 / Lecture Practice

## Question 1

### a) What is the unit of observation in this dataset?
- you can use `codebook` to determine whether or not there are the same number of observations are there are observation
- you can also use `sort block month`
- further can be refined with `duplicates report block month`

### b) Rename variables so that they all have names in English.
- barrio = neighbourhood
- calle = street
- altura = height

### c) Make a list of all the dummy/indicator variables (those that take values of 0 or 1 only). Use any command in Stata that you may find useful to guarantee that these are dummy variables.
- first `summarize`, then based on these you can `tabulate varlist`.
- You can use a loop for this ie `for var in varlist ... {
  tab 'var' }`

### d) What is the treatment and the control group in this study? What is the dummy variable that identifies the treatment group? What is the dummy that identifies the before/after observations? What is our outcome variable?

- outcome: `thefts`
- treatment: `sameblock`
- before: `Before July`
- after: `After July`

### e) Are there any variables that you could use as additional control variables for the difference-in-differences (DID) analysis?
- control variables: potentially bank would affect car thefts since there are cameras, also gas stations there are a lot cars to potentially steal, public building also because there are more people traffic and maybe more cars to be stolen 

## Question 2
### Part a)
- generate a dummy variable using `gen var = ()`
- could also use `gen var = inlist(var, conditions)`

### Part b)
- to prepare the table you can check the means before the treatment 
- then you can run a t-test for a difference in means
- ideally you want to fail to reject as this would mean that the difference between the means are the same statistically speaking. There is too much noise in the data.

## Question 3
### Part a)
- need to evaluate the sign (positve or negative), the magnitude of the sign and whether or not its statistically significant.
- -0.087 / 0.1 * 100 this is the drop in the average number of 
### Part b)
- also make sure to look at the $$R^2$$, since the model is not really good. 
## 


