



clear

use "/home/ewan/work_isb/projects/crop_subs_updated/data/coc/coc.dta"

keep if state_name=="Maharashtra" 
// & dist_name=="Latur"  & tehsil_code == 39 year == 2019

tab crop



keep if crop == "Sugarcane" | crop =="Wheat" | crop =="Paddy" | crop =="Soyabean" | crop =="Maize" | crop =="Jowar" 

bysort crop: egen y = mean(yield)

collapse (mean) yield, by(crop)

gen yield_per_tonne = yield/10

export delimited using "/home/ewan/work_isb/projects/crop_subs_updated/data/workspace/crop_yield_coc_per_year/crop_yield.csv", replace
