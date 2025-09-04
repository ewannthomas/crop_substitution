# IBIS Data Cleaning Log

## Data Structure

## Data Issues

After almost two weeks of looking through the data, its evident that all of the previous mentioned files have serious data sanity related issues. Some profound ones are listed below:

- Imagine company "X.Ltd" has 3 plants producing paper, TMT and cement. The cement producing plant has an djoining captive power plant of 3 MW. The data is so designed that all 3 plants will be mentioned across paper, steel and cement directories.

- If two of the above plants are in the same location, then, these entries will have the same identifiers(adress, pincode) and seem like duplicates. They also dont have a differentiator column that helps us identify which amongst the two plants(located next to eachother) produces cement or paper.

- Many a times, the production capacity information is missing in the data file while the same is mentioned in the company description in the PDF file. This description, which is not always avaliable in the PDF file, may also convey information on the kinds of products manufactured.

- The `captive_capacity` column has the unit written in the same column rendering the value a string.

- Parsing Erros - Many entries across data files have parsing related errors where rows of observations are misalingned with columns.

## Measures Taken

To clean the IBIS data, we suggest a two pronged approach:

1. Programatically remove unnecessary columns and noises which are consistent across files. For example, email and telephone details.

2. Manually inspect these files for inconsistent data points. To ensure data sanity and compartmentalization of information across files, a general decision has been taken to retain only plant informations that produces the concerned product. captive power plants and other plants will be removed from the respective directives of each product. So, one can be sure that paper directory file contains only paper producing plants.

### Automotive Directory
Number of observations = 1670 

Missing capacity rows = 1653

No specific major cleaning required except a few string related corrections.

### Breweries and Distilleries
Number of Observations = 750

Number of observations post cleaning = 746

Missing capacity rows = 547

- A B Grain Spirits Ltd
  1. There are two plants in Kiri Afghana Village in Punjab and one is a power plant. This entry has been removed.
  2. The Nellikuppam Power Plant entry has been removed.

- KGS Sugar & Infra Corporation Ltd
  1. The second plant had capcity in MW but its distillery unit. Added the 50 klpd value instead of the MW values.

- Om Sons 
  1. Om Sons are the distributor of steel pipes and structures and the company is planning to set up a
    distillery and a 10 MW captive power plant in Faridkot. This entry has been removed.


### Captive Power Plants

Number of Observations = 3301

Number of observations post cleaning = 

Missing capacity rows = 

The names of columns have been cleaned. we will create a new column called `fuel` to identify the fuel used and another called `type` to identify the type of power plant each entry belongs to.

- Balrampur Chini Mills Ltd
    1. Corrected the pincode of Datauli to 271302

- Manakpur Chinni Mills
    1. Corrected the pincode of Datauli to 271302

- Mankapur Chini Mills
    1. Corrected the pincode of Datauli to 271302


Manual cleaning steps:
1. There are 3301 raw entries. Within these, there are 1969 entries which has valid value in the `captive_power_plant_capacity_and_upcoming_ones` column. These entries are extracted and cleaned separately. These 1969 new entries are tagged with integer 1 in the "data_filter_step" column.

2. The remaining entries in the raw file is  1332 (3301-1969). These entries were manually inspected and one entry belonging Rayana Paper Board Industries Ltd was added to the captive power entries list. This entry is tagged with integer 2 in the "data_filter_step" column.

### Cement Directory
Number of Observations = 623

Number of observations post cleaning = 617

Missing capacity rows = 243

- BLA Power Pvt Ltd

  1. The Niwari power plant is a power generation unit. Removing it from cement directory.

- Deccan Cements Ltd

  1. The Guntur Branch Canal (GBC) power plant has been removed.

- KCP Ltd

  1. Two captive power plants observations were removed

- Rattan India Power Ltd

  1. Is a power generator company with one cement plant near Simanr. Except the cement plant 1.65 mtpa, all units are removed.

- Shalivahana Cement India Ltd
  1. Its a power generator with an upcoming plant in Chincholi for cement. All captive power units are removed.

### Chemical Directory
Number of Observations = 3252

Number of observations post cleaning = 

Missing capacity rows = 

- S R Drugs and Intermediates Pvt Ltd
    1. Patrsing error has been rectified.

- Visen Industries Ltd
    1. Patrsing error has been rectified.

- Aditya Birla Nuvo Ltd
    1. One entry of a captive capacity has been removed.

- Jocil Ltd
    1. Its soap and oil making company that has a captive power unit and just one entry. The capacity column has MW as unit. So we retain this entry and remove the unit value.

- Nuchem Ltd
    1. A chemical company that produces pharmaceuticals and consumer durables. It has one entry and a captive power plant. So we retain this entry and remove the unit value.

- Panoli Intermediates Pvt Ltd
    1. The company priduces chlorinated products. It has one entry and a captive power plant. So we retain this entry and remove the unit value.

- Sree Rayalaseema Alkalies And Allied Chemicals Ltd
    1. The company is involved in the production Chlor-Alkali products.  It has one entry and its a power plant. So we remove this entry.

- TCP Ltd
    1. Entry at Kovilur TN is a captive unit. It has one entry and a captive power plant. So we retain this entry and remove the unit value.

    2. Plant at New Gummidipundi has existing caapcity in "MW". So this entry has been removed.

- The following companies have a power plant entry. This entry has been removed:
    1. Bodal Chemicals Ltd
    2. Brahmaputra Cracker and Polymers Ltd
    3. GAIL India Ltd
    4. Kudos Chemie Ltd
    5. MCPI Pvt Ltd
    6. Petronet LNG Ltd
    7. Philips Carbon Black Ltd
    8. Reliance Syngas Ltd
    9. Responsive Industries Ltd


### Ceramics Directory
Number of Observations = 640

Number of observations post cleaning = 640

Missing capacity rows = 635

### Dairy Directory
Number of Observations = 815

Number of observations post cleaning = 814

Missing capacity rows = 753

- West Assam Milk Producers Cooperative Union Ltd
  1. Parsing error in the entry associated with West Assam Milk was corrected.

- Anik Industries
    1. Plant in Ujjain is a power plant. The entry has been removed.


### Edible Oil Directory
Number of Observations = 917

Number of observations post cleaning = 8916

Missing capacity rows = 510

- Tilam Sangh Raj Bikaner Project
    1. Parsing error in the observation was rectified

- Blue Ocean Biotech Pvt Ltd
    1. The peddapuram plant has a capcity of 150 tpd( provided in description). This information was updated in the observation and the captive capacity values are removed

- Sudha Agro Oil & Chemical Industries Pvt Ltd
    1. Sudha Agro has 3 plants: Samalkok and Bilaspur. The capacity of edible oils production for the two plants have been updated.
    2. The captive planyt entry in Samalkot is removed. 

### Engineering Directory
Number of Observations = 3958

Number of observations post cleaning = 3886

Missing capacity rows = 3710

- Astha Projects (India) Ltd
    1. Its power producing company. These plants are already included in the power directory. Hence the 2 observations are removed.

- Bharat Aluminium Co. Ltd
    1. Their power plant in Korba has been removed from the directory.

- Clarion Power Corp Ltd
    1. Biomass plant in Hyderabad. Removed.

- Dans Energy Pvt Ltd
    1. The hydro electric plant in sikkim was removed.

- Dee Development Engineers Pvt Ltd
    1. A power producing company. Their power plant entry has been removed.

- Dharmshala Hydro Power Ltd
    1. A power producing company. Their power plant entry has been removed.

- Energy Development Co Ltd
    1. A power producing company. It has 4 power plant units and they have been removed.

- GAPS Power & Infrastructure Pvt Ltd
    1. A power producing company. Their power plant entry has been removed.

- GMT Mining & Power Pvt Ltd
    1. A power producing company. Their power plant entry has been removed.

- Graphite India Ltd
    1. The compnay has 8 plants and is the largest producer of graphite rods. Out of these 8 plants, 2 in Shrirangapatnam and Mysore (Karnataka) are power plants. These entries have been removed.

- GVK Power and Infrastructure Ltd
    1. GVK is a large power group and all their entries are power generation units. All 7 power plants have been removed from the engineering directory.

- Himachal Pradesh Power Corp Ltd
    1. All 8 power plant entries have been deleted.

- Tata Power Co Ltd
    1. All 12 power plants has been removed.

- Tarini Infrastructure Ltd
    1. All 3 power plant entries have been removed.

- IL & FS Ltd
    1. A finance company which has financed power plants. 6 entries from IL & FS Ltd has been removed.

- IMP Powers Ltd
    1. Their power plant in J&K has been removed.

- Indian Metals & Ferro Alloys Ltd
    1. Power plant in Odisha removed.

- Jaiprakash Associates Ltd
    1. 7 entries from Jaiprakash Associates Ltd removed.

- Jindal India Thermal Power Ltd
    1. 5 power plant entrie sof Jindal India Thermal Power Ltd have been removed.

- Lanco Kondapalli Power Ltd
    1. One Power plant entry removed.

- Nalco Ltd
    1. An Aluminium maker. Their power plant Odisha has been removed.

- Pioneer Genco Ltd
    1. A power plant entry under their ownership has been removed.

- Servall Engineering Works
    1. Information found in page number 3557 of Engineering directory. This is a manufacturer of paper making machinery and the capacity information from the text has been updated in the data file.


### Fertilizer Directory
Number of Observations = 641

Number of observations post cleaning = 639

Missing capacity rows = 527

- KGS Sugar & Infra Corporation Ltd
    1.  This group's entries are featured in breweries and distilleries directory. So we are removing them from here.


### Food Directory
Number of Observations = 6455

Number of observations post cleaning = 6439

Missing capacity rows = 4920

- A B Grain Spirits Ltd
    1. This group's entries are featured in breweries and distilleries directory. So we are removing them from here.

- Bihar State Sugar Corp Ltd
    1. There are more than 10 plants, out of which the one in Vaishali is a power generator. This entry has been removed. 

- Blue Ocean Biotech Pvt Ltd
    1. This firm  and the same entry is already included in the Edible oil directory. Hence, removed from here.

- EID Parry Ltd
    1. It has many plants. The plant in Nellikuppam is a power plant. Removing this entry

- Gopal Corp Ltd
    1. Two plants have MW outputs units and both are Hydel projects. These entries have been removed.

- KGS Sugar & Infra Corporation Ltd
    1.  This group's entries are featured in breweries and distilleries directory. So we are removing them from here.

- Rajasthan State Ganganagar Sugar Mills
    1. Is a sugar producer and their second plant in Sriganganagar District is a power plant. Hence removing this entry.

- Sri Rayalaseema Sugar & Energy Ltd
    1. The power plant in the Pandipadu has been removed.

- Sudha Agro Oil & Chemical Industries Pvt Ltd
    1. 3 entries from the group is already covered in breweries and distilleries directory. Removing all 3 from here.

- Sukbhir Agro Energy Pvt Ltd
    1. The plant in UP is an integrated unit that has  50 TPH Rice Mill, 500 TPD Solvent Extraction Plant and a 15MW biomass captive plant.
    2. No mention about what is produced in the Karnataka plant. 
    3. I am assiging one more entry in UP for the 500 TPD Solvent Extraction Plant and rectifying the existing for 50 TPH Rice Mill.
    4. Removing the output values from the Karnataka plant and retaining the entry.

- Upper Ganges Sugars & Industries Ltd
    1. The Sidhwalia Cogeneration Plant has been removed.
    
- Vitthal SSK Ltd
    1. Ghursale Captive Power Plant has been removed.

- Chanda Sugar
    1. Had telephone number in capacity column. This has been corrected.

- Sonepat Coop Sugar Mills
    1. Had 2500 tcd in capacity column. This has been parsed correctly.

- Tilam Sangh Raj Bikaner Project
    1. Parsing error has been corrected

- West Assam Milk Producers Cooperative Union Ltd
    1. Parsing error has been corrected.

- Belganga SSK Ltd
    1. Text MW present in upcoming capacity column has been corrected.


### Pharma Directory
Number of observations = 3425

Number of observations post cleaning = 

Missing capacity rows = 

- Deccan Healthcare Ltd
    1. Parsing Error in has been rectified.

- Althea Pharma Pvt Ltd
    1. The capacity column parsing was incorrect. The right numeric value has been updated from the PDF.

- Mepro Pharmaceuticals Pvt Ltd
    1. The capacity column parsing was incorrect. The right numeric value has been updated from the PDF.

### Paper Directory

Number of observations = 899

Number of observations post cleaning = 897

Missing capacity rows = 688

- Rayana Paper Board Industries Ltd
  1. The capacity information has been updated from the plant description.
  2. Captive capacity value has been moved to the corresponding column.

- Shree Papers Ltd
  1. Captive capacity value has been moved to the corresponding column.

- Hanuman Agro Industries Ltd (Paper Mills)
  1. Two plants exist in the same location but one is a captive power plant.The captive power plant observation has been removed.
  2. Paper production capacity has been updated in the retained row from plant description availbale in the PDF file.

- N R Agarwal Industries Ltd
  1. Has 3 different plants in 3 different location in Gujarat. One of the 3, Sarigam Captive Power Plant located in Umbergaon Tehsil is a captive power plant. This row has been removed from the paper directory file.
  2. The remaining two entries are retained without changes.


### Power Plants

Number of observations = 2148

Number of observations post cleaning = 1730

Missing capacity rows = 761

Power Plants directory was very different in terms of entries and column structures compared to other directories. After removing redundant columns lilke email, names etc, it had the following 2 new columns which were not present in other files:
1. fuel_sector 
2. captive_power_plant : Indicates whether the power generation unit is an adjoing captive power generation unit within an existing product manufacturing plant. This will be later reused to indicate actual power plants from captive power plants in the same data frame.

The power directory, like others, involve details of all entries of captive power plants and other products manufacturing units owned by power compnaies and business groups. So filtering out the correct rows become important. The data filtering has been conducted in the following sequence:
1. All entries with a valid MW capacity value has been isolated. This sub frame has 792 records. They are moved to a new sheet and they are tagged by a new column "data_filter_step" with the step number as the indicator from where these values are imported. These 792 observations will be tagged with integer 1.
2. The next indicator is the captive_power_plant column. From the remaining 1356, we isolated all plant entries where captive_power_plant column is non missing. There are 206 entries which mention that the observation is a captive power plant. Out of this 208 entries, 130 entries have a capacity value with a non "MW" unit. Thus ensuring that these observations can be moved to the captive power plant directory. The remaining 78 cases, where captive_power_plant entries have missing capacity can be safely assumed to be similar to the above 130 entries and part of an industry. After removing the 206 captive_power_plant entries, we are left with 1150 entries. These 206 valid captive power plant entries have been cleaned manually tgo remove string based errors.
3. The remaining 1150 observations are entries which have non "MW" capacity, missing capacity and manufacturing units without captive unit associated with them. From this data, we first eliminate all non "MW" capacity. There are 184 such entries and we are left with 966 observations where capacity information is missing.
4. Out of this 966 observations, we searched the word "power" in the company name and found 315 entries. These entries were manually checked and ensured that they belong to power plants. So these can be added to the valid power plants data frame mentioned in step 1, thus bring the number of power plant entries to 1107 (792 + 315). These 315 new entries are tagged with integer 4 in the "data_filter_step" column.
5. Once the 315 observations are moved, we are left with 651 observation which doesn't have a capacity value and doesn't have the word "power" in its company name. From thus 651 observations, we search for the term "Energy" in the company names column. We get 146 results. These entries were manually checked to ensure that they are not product manufacturers and added to the valid power plants data frame. Thus the valid power plant entries become 1253 (1107 + 146). These new 146 entries are tagged with the integer 5 in the "data_filter_step" column.
6. From 651 observations we are left with 505 entires which doesn't have a capacity value and have the word "power" and "energy" in its company name. Now these 505 have been manually inspected to find the remaining valid power plant entries. The results of this manual search are the following:
    1. Out of 505 entries, there are 17 records which had the term "captive power plant" in the add1 column. These record will be added to the valid power plants data frame. These new 17 entries are tagged with the value 6.1 in the "data_filter_step" column. This makes the valid power plant entries 1270 (1253 + 17). These entries will also be flagged with the value 1 in the "captive_power_plant" column.
    2. Out of the remmaining 488 entries (505 - 17), we have 117 entries which has the word "power" in its address line 1 under column add1. Out of these 117, there are a 28 captive and 89 non captive entries. Certain special cases noted are mentioned as under:
        - SPIC Ltd (EPC)
        - SPIC Ltd (Fertilizers) - SPIC Ltd has EPC and Fertilizers part of the same company and the thermal palnt in Tuticorin is shared by both units. So the first one is removed.

    The remaining 116 entries are tagged with the value 6.2 in the "data_filter_step" column. This makes the valid power plant entries 1386 (1270 + 116). These entries will also be flagged with the value 1 in the "captive_power_plant" column.

    3. From the remaing 371 (488-117). These entries are manually checked for captive vs non-captive. The file contains  233 entires that are non plant power and have been removed. The remaining 138 valid entries are tagged with the integer 6.3 in the "data_filter_step" column. Currently there are 1524 (1386+138) valid power plant entries.

7. From step 2, the 206 cleaned captive power plant entries will be added to the valid entries. These entries are tagged with the value 7 in the "data_filter_step" column. This makes the valid power plant entries 1730 (1524 + 206). These entries will also be flagged with the value 1 in the "captive_power_plant" column.

8. While cleaning the Steel Directory, we found two captive power plants that were not in the Power Plant Directory. The following changes were made:

- Sakthi Sugars Ltd 
    1. A plant with a captive capacity of 25 MW was added. The same is also present in the Steel directory because in the same plant, it produces 4000 tcd of steel. 

- Shanti Gopal Concast Ltd
    1. A plant with an upcoming captive capacity of 25 MW was added. The same is also present in the Steel directory because in the same plant, it produces 90000 tpa of steel. 


These observations are tagged with the integer 8.1 in the "data_filter_step" column. Currently there are 1732 (1730+2) valid power plant entries.

9. There are the following cement grinding units which were identified and removed:
    1. J K Cement Ltd
        Two cement grinding unit in Jharli and Aligarh have been removed.

    2. Aditya Birla Nuvo Ltd
        The chemical plant in Raigad is removed.

    3. Star Light Energy Ltd
        The company is described as a power company producing solar panles but they are tagged as a distillery with 90 klpd. Hence, this entry is removed.

Currently there are 1730 valid power plant entries which includes 288 captive power plants.

As the last stage, the `fuel_sector` column has been separated in to fuel and type.


### Steel Directory

Number of observations = 5134

Number of observations post cleaning = 5066

Missing capacity rows = 3681

The steel directory needs to be cleaned manually in all aspects. There are many parsing errors that needs to be corrected manully.

- Agarwal Sponge & Energy Pvt Ltd
    1. Parsing Error has been corrected.

- B S Ispat Ltd
    1. Parsing Error has been corrected.

- Anindita Steels Ltd
    1. Cleaned capacity column of strings and added the correct values.

- Crest Steel & Power Ltd
    1. Cleaned capacity column of strings and added the correct values.

- Ennore Coke Ltd
    1. Cleaned capacity column of strings and added the correct values.

- Gandhamardan Sponge Industries Pvt Ltd
    1. Cleaned capacity column of strings and added the correct values.

- N R Sponge Pvt Ltd
    1. Cleaned capacity column of strings and added the correct values.

- Rajdhani Castings Pvt Ltd
    1. Cleaned capacity column of strings and added the correct values.

- Uttam Galva Steels Ltd
    1. Cleaned capacity column of strings and added the correct values.

- Tata Metaliks Ltd
    1. This entry has a captive plant. Since the same is present in the power directory, we will correct this entry here. The entry will be retained in steels because it produces 0.345 mtpa of steel as well.

- There are 30 power plant entries identified from the `capacity` column. These observations were removed.

| Company Name                          | Power Plant / Location                                         |
|---------------------------------------|----------------------------------------------------------------|
| Aarti Sponge & Power Ltd              | Bakhesar Road, Village Munrethi                                |
| Bengal Energy Pvt Ltd                 | Mouza: Dauka                                                   |
| Bharat Aluminium Co. Ltd              | Balco Nagar Power Plant (4x300 + 4x135+4x67.5 MW)              |
| Bhatia Coke & Energy Ltd              | Gummidipoondi                                                  |
| Durgapur Projects Ltd                 | Durgapur (3 x 75 MW)(1 x 110 MW) (1 x 300 MW)                  |
| Graphite India Ltd                    | K.R. Nagar Taluk, Dist. Mysore,                                |
| Graphite India Ltd                    | Mini Hydel Power Plant                                         |
| Greta Energy Pvt Ltd                  | Plot No.A-28, MIDC Growth Centre                               |
| HEG Ltd                               | Tawa Hydel Electric Project                                    |
| Hind Energy And Coal Benefication India Ltd | Village Kanberi, Korba                                   |
| Hindalco Ltd-Metals Division          | Hirakud Power Plant                                            |
| Hindalco Ltd-Metals Division          | Renusagar Power Plant                                          |
| Indian Metals & Ferro Alloys Ltd      | Choudwar                                                       |
| Indo Lahari Biopower Ltd              | Jaraouda Vilage                                                |
| Inland Power Ltd                      | Inland Nagar, Village - Tonagatu                               |
| JSW Steel Ltd                         | Toraganallu Power Plant                                        |
| Maithon Power Ltd                     | MA-5 Gogana Colony Post (2 x 525 MW)                           |
| Nalco Ltd                             | Angul Power Plant (10 x 120 MW)                                |
| Sai Chemicals Pvt Ltd                 | Tedesara                                                       |
| SAIL Ltd                              | Bhilai Steel -Captive Power Plant (2 x 500 MW)                 |
| SAIL Ltd                              | Bokaro Steel -Captive Power Plant                              |
| SAIL Ltd                              | Rourkela -Captive Power Plant ( 2 x 60 MW)                     |
| Sarda Energy & Minerals Ltd           | Loharkheth Hydel Power Plant                                   |
| Sarda Energy & Minerals Ltd           | Ferro Alloys Plant                                             |
| Shivalay Ispat And Power Pvt Ltd      | Guma Urla Road                                                 |
| Shree Nakoda Ispat Ltd                | Plot No. 109, Siltara Industrial Estate                        |
| Team Ferro Alloys Pvt Ltd             | Gondia Biomass Power Plant                                     |
| The Sandur Manganese & Ore Ltd        | Vysankare Captive Power Plant                                  |
| V M Ispat Pvt Ltd                     | Belur                                                          |
| Vedanta Aluminum Ltd                  | PMO Office, Bhurkahamunda Captive Power Plant                  |

- There are 38 Power plant entries. These were cross checked wiht the power plant directory and removed from Steel.

| Company Name                           | Power Plant / Location                             |
|----------------------------------------|----------------------------------------------------|
| Aarti Steels Ltd                       | Ghantikal Power Plant                              |
| Andhra Ferro Alloys Ltd                | Garbham Village                                    |
| Anik Industries Ltd                    | Ujjain                                             |
| Atha Mines Pvt Ltd                     | Tarkabeda                                          |
| Balasore Alloys Ltd                    | Balagopalpur                                       |
| Corporate Ispat Alloys Ltd             | Chitarpur Power Plant                              |
| Goa Carbon Ltd                         | Paradip Captive Power Plant                        |
| Godawari Power & Ispat Pvt Ltd         | Dharmajaigarh Power Plant                          |
| Graphite India Ltd                     | P.O. Sagarbhanga Colony                            |
| Gujarat NRE Coke Ltd                   | Bhachau Power Plant                                |
| J K Lakshmi Cement Ltd                 | Torniya Power Plant                                |
| J K Lakshmi Cement Ltd                 | Durg Power Plant                                   |
| Jai Balaji Industries Ltd              | Raghunathpur                                       |
| Jayaswals Neco Ltd                     | Hamirpur                                           |
| Jindal Steel & Power Ltd               | Krishnapatinam Thermal Power Project               |
| Jindal Steel & Power Ltd               | Malibrahamani ( 2 x 525 MW)                        |
| Mahanadi Coalfields Ltd                | Sundergarh Power Plant                             |
| Mineral Enterprises Ltd                | Dutanurkaval & Kanave Aladahalli                   |
| Nalco Ltd                              | Sundergarh District                                |
| Narbheram Power And Steel Pvt Ltd      | Gundichapada Power Plant                           |
| Parekh Aluminex Ltd                    | Barabanki Thermal Power Project                    |
| Prakash Sponge & Power Pvt Ltd         | Sy.No. 42 & 43, Heggere                            |
| Sarda Energy & Minerals Ltd            | Godhi, Raigarh District                            |
| Shiva Shankar Minerals Ltd             | Burigapally & Ghanpur Village                      |
| Shyam Sel & Power Ltd                  | Sodmal                                             |
| Singareni Colleries Ltd                | Jaipur Power Project                               |
| SKS Ispat & Power Ltd                  | Binjkote/Darramura Power Project(4x300 MW)         |
| Sree Metaliks Ltd                      | Rajeswarpalli, Chardia Block                       |
| Sree Metaliks Ltd                      | Anra Captive Power Plant                           |
| Tata Sponge Iron Ltd                   | Nandichod Power Plant                              |
| Tata Steel BSL Ltd                     | Angul Power Plant                                  |
| Topworth Steels & Power Ltd-Steel Div. | Sapnai Power Project                               |
| Tulsyan NEC Ltd                        | Sinthoornatham Captive Power Plant                 |
| Uniworth Textiles Ltd                  | Deogarh Power Plant                                |
| Usha Martin Ltd                        | Kahalgaon (Nandlalpur)                             |
| Usha Martin Ltd                        | Tatisilwai Captive Power Plant                     |
| Visa Steel Ltd                         | Kalinganagar Captive Power Plant                   |
| Welspun Maxsteel Ltd                   | Salav Captive Power Plant                          |


### Sugar Directory

Number of observations = 1364

Number of observations post cleaning = 1357

Missing capacity rows = 436


- Chanda Sugar
    1. Telephone number in `capacity` column has been removed.

- Balrampur Chini Mills Ltd
    1. Corrected the pincode of Datauli to 271302

- Manakpur Chinni Mills
    1. Corrected the pincode of Datauli to 271302



- The following entries with MW units capacity are present in the power plants directory. So these entries are removed:

| Company Name                           | Power Plant / Location                                      |
|----------------------------------------|-------------------------------------------------------------|
| Bihar State Sugar Corp Ltd             | Motipur                                                     |
| EID Parry Ltd                          | Nellikuppam Power Plant                                     |
| KGS Sugar & Infra Corporation Ltd      | Gat No. 147/4, 148/1/2A & 148/1/1B Pimpalgaon (Nipani)      |
| Sri Rayalaseema Sugar & Energy Ltd     | Aswathapuram                                                |
| Upper Ganges Sugars & Industries Ltd   | Sidhwalia Cogeneration Plant                                |
| Vitthal SSK Ltd                        | Ghursale Captive Power Plant                                |



### Textile Directory

Number of observations = 2226

Number of observations post cleaning = 2226

Missing capacity rows = 2145

- GTN Textiles Ltd
    1. Parsing error has been corrected.

The following entires are captive power plants that have only one plant. These plants are assumed to have production along with the captive plant uses. For these reasons, we are removing the capacity values of these plants and retaining them in the textil directory.


| Company Name                   | Power Plant / Location         |
|--------------------------------|--------------------------------|
| Sai Lakshmi Industries Pvt Ltd | Nanjangud                      |
| Suryavanshi Cotton Mills Ltd   | Jangaon Captive Power Plant    |
| Yash Agro Pvt Ltd              | Chimur                         |


## DATA COMPILATION


### Power plants and Captive plants
