
# CROP SUBSTITUTION

Crop Substitution is a research endeavour to identify measures to reduce urban water stress. it aims to replace a portion of water-guzzling crops with less water-intensive alternatives, such as sorghum, potentially freeing up significant water resources for urban needs. To address potential income loss for farmers, a compensation model is suggested wherein urban beneficiaries directly contribute. The research methodology includes estimating urban water demand and deficit at the city level, particularly during the summer months.

## URBAN WATER DEMAND ESTIMATION
This repository contains the codes used to estimate the urban water demand estimation (work-in-progress) as part of the crop substitution project. 

### Data

#### Annual Survey of Industries (2019-20) (ASI)
Using the Annual Survey of Industries (2019-20) (ASI) we estimate the water demand in production process by industrial units per unit of production.  Block J of the ASI provides the quantity of production for 2019-20. Similarly, Block H of the ASI lists the various inputs to production process and coded using the National Product Classification for Manufacturing Sector, 2011(NPCMS).  One may download ASI raw data from the [MoSPI micro data catalogue](https://microdata.gov.in/NADA/index.php/catalog/ASI/?page=1&sort_order=desc&ps=15&repo=ASI) 

#### IBIS
IBIS is privately owned data product which lists the details of all industrial units operating within India and engaged in production of various products including power. There are industry directory across states and 25 sectors of production. One may find the data directories at [IBIS website](https://www.industry-focus.net/)

### Codes

#### ASI
This folder under `src` directory contains codes associated with cleaning the ASI 2019-20 data files and creating the industry standard average water based inputs parameters. The detailed description of the changes made to the raw data, necessary calculations and assumptions are provided in the [documentation file](https://github.com/ewannthomas/crop_substitution/blob/master/docs/data_docs/ASI_calculations.md). 


#### IBIS data
This folder under `src` directory contains Jupyter notebooks associated with cleaning IBIS industrial directories. The cleaned product was used to estimate urban industrial water demand. The detailed description of the changes made to the raw data, necessary calculations and assumptions are provided in the [documentation file](https://github.com/ewannthomas/crop_substitution/blob/master/docs/data_docs/ibis_changes.md). 
