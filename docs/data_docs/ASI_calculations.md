# ASI Calcluations

Annual Survey of Industries 2019-20 was used for estimating the industrial water demand in Indian cities. From the survey raw data, 3 Blocks (A, H, J) were utilized for the estimation.

- Block A - Basic details of industrial unit
- Block H - Inputs and factors of production
- Block J - Production and by products

## Cleaning Block A
Block A contains the basic information pertaining to a firm including the state of location and the National Industry Classification (NIC) 5-digit code.

Please note that firm "119769" is a coal based power generating unit (producing 976809 megawatts of electricty) which has a NIC code of 35301. This NIC code refers to firms that produce steam and hot water. Instead this firm must come under NIC code 35102 which corresponts to units producing energy from thermal power using coal. So the firm's NIC is replaced to 35102.

## Cleaning Block J 
Block J contains information on products and by products manufactured by the industrial unit.

The columns were renamed using the schedule. The column `output_unit_qty_code` contains the unit of measurement of the final product and by products. These values were recoded using the values from the schedule. Please note that these metric codes are exactly same as National Product Classification for Manufacturing Sector (NPCMS) 2011. The unit codes are as follows:

    1: "Bags",
    3: "Cubic Meter",
    4: "Carat",
    6: "Gramme",
    7: "K.Litres & Th. Litres",
    8: "Km",
    9: "Kg",
    12: "Litres",
    13: "Megawatt",
    14: "Metres",
    15: "Nos.",
    16: "Pair",
    17: "Ream",
    18: "Roll",
    20: "Sq. Metre",
    22: "Th. Nos",
    23: "Th. Cubic Metre",
    24: "Th. K. Litre",
    25: "Th. Pair",
    27: "Tonne",
    28: "K. Watt",
    31: "Feet",
    38: "Cubic Cm"

The column `output_item_code` contains NPCMS 7 digit codes of the product and by products. Out of these codes, '9921100' and '9995000' denot "Other products or by products" and "Total" respectively. Observations containing these two codes were removed from the data frame. 


## Cleaning Block H 
Block H contains information on the inputrs and factors of production whioch were part of creating the final products and by products. 

The columns were renamed to reflect the questions from the schedule. The column `input_unit_qty_code` was replaced with the unit codes as mentioned above. Further, the entire dataframe was subset to only include inputs having NPCMS codes pertaining to the following inputs.

    "1730001":"Hot water",
    "1730002":"Steam",
    "1730099":"Steam and hot water nec",
    "1740000":"Ice and snow",
    "1800001":"Water for industrial use",
    "1800002":"Water for domestic use",
    "1800099":"Natural water nec"

All the above are inouts pertaining to water and its different forms. This filter was applied to the `input_npcms_item_code` column.

The quantity of water based input consumed is mentioned under the column `input_qty_consumed`. The values in this column are measured in "Th. K. Litre" which is Thousand Kilo Litres or 1 thousand kilo litres or 1,000,000 litres. To convert the same to cubic meter or 1000 litres, we need to multiply each input quantity consumed by 1000.

However, within the inputs, NPCMS code 1740000 stands for Ice and Snow which is measured in tonnes. So we convert it to cubic meters by multiplying the quantity consumed by 2.831685.

So all inputs marked as 1740000 is multiplied by 2.831685 and the remaining by 1000 so that all inputs are measured in cubic meters or 1000 litres.

Four industrialm units with DSL is equal to "110687", "110689", "117314", and "205714" have input "1800001":"Water for industrial use" marked as 0. 

Within Block H, there are currently records of 493 inudstrial units using water and water based inputs.

## Merging Blocks J & H
We merged the frames of J and H and retained entries from 493 firms. The merger was done to isolate all production details of all 493 industrial units that uses water as an input in production. From now onwards, this data frame shall be called "Water_JH"


## Finding the Main Product
In order to estimate the usage of water per unit of production, we have to isolate all the main outputs produced. To acheive this, we take the following measures:

- Step 1: Counting the Number of Outputs Recorded  

A separate frame was created with the `dsl` column and the number of outputs recorded. Industrial units with multiple outputs are marked with an indicator under the new column `multi_prod_indic`.  

| Number of products | Number of firms |  
|-------------------:|----------------:|  
|                  1 |             378 |  
|                  2 |              44 |  
|                  3 |              22 |  
|                  0 |              21 |  
|                  4 |              13 |  
|                  5 |               8 |  
|                  6 |               2 |  
|                  7 |               2 |  
|                 10 |               2 |  
|                  9 |               1 |  

As per the above table we have 378 firms with only one output, 21 firms with 0 output and and 2 firms with 10 outputs. 


- Step 2: Removing industrial units with 0 output

An output count of 0 is recorded in case where output is marked as NaN. It happens because Block J initially has information only on 45,708 industrial units while ASI covers, according to Block A, 66,853 industrial units. So while merging blocks J and H, firms which are not recorded in J has entered via block H and hence their production information has been marked as NaN across columns of Block J. We have taken measures to remove these 21 firms from further analysis.


- Step 3: Identifying the industry type

To isolate final product or products, we need two sets of information:
1. Type of industry which the firm belongs to.
2. Type of product produced by the firm.

Information 1 can be obtained by adding the NIC 2008 codes and infoirmation 2 can be obatined by bringing in the NPCMS 2011 codes.

We merge the Water_JH with Block A inorder to bring in the location and NIC codes associated with the industrial unit. From now onwards, this data frame shall be called "Water_JHA"



- Step 4: Merging Water_JHA to NIC code data frame.

We have scraped the NIC 2008 codes (all levels) and their respective descriptions from the [DGE, Ministry of Labour & Employment, GoI](https://dge.gov.in/dge/national-industrial-classification?field_division_nic_target_id=All&title=) website. The subsequent data frame of NIC codes was then merged to Water_JHA using the NIC 5 digit code to create "Water_JHA_NIC". This will add information 1 to the data frame.

- Step 5: Merging Water_JHA_NIC with NPCMS data frame.

Information 2, that is, the description of the product(s) produced by the firm is imported from the NPCMS 2011 codes. We dowloaded the NPCMS 2011 file from the [Ministry of Statistics and Programme Implementation, Government of India](https://www.mospi.gov.in/classification/national-product-classification) website. We add the product decsriptions from the NPCMS to the outputs produced. This merged frame shall be called "Water_JHA_NIC_NPCMS".

- Step 6: Manual marking

Using the `multi_prod_indic` from step 1, we extract all firms and their necessary information as a data frame. This frame is then manually inspected to remove all by products and other prodcuts produced that are not in tandem with NIC industry description.

For example, Firm "119769" is power plant and its contains electricty, hot water and steam as products. Since its a power plant under NIC code 35102, we shopuld retaimn electricty measured in megawatts and remove hot water and steam from calculation of water consumption per unit of production.

To acheive this, we create a new column `valid_outputs` which i sequal to 1 for valid outputs that shall be considered for further analysis and 0 otherwise. All the multi product firms are thus inspected and marked manually and then merged to the Water_JHA_NIC_NPCMS from step 5. 


## Output Standardization

In the current data frame, each observation corresponds to a product produced by an industrial unit. Each industrial unit may have multiple products. Our unit of analysis is at state-NIC code level. So, across firms and products, the unit of measurement of output must be uniform. Meaurement of water input in the production process is available at firm resolution. 

The following sub section details how such output standardization was achieved across prodcuts and firms.

### NIC code 10501
NIC code 10501 corresponds to firms enaged in manufacture of pasteurised milk whether or not in bottles/ polythene packs etc. (plain or flavoured). Products were measured in Kilograms, Thousand Liters, and Kilo Litres. All products werre standardized to metric ton or tonnes.

According to [University of Guelph Open Books](https://books.lib.uoguelph.ca/dairyscienceandtechnologyebook/chapter/physical-properties-of-milk/#:~:text=With%20all%20of%20this%20in,m3%20at%2020%C2%B0%20C.), density of milk ranges between 1027 to 1033 kg /m3 at 20°C. The average of the range at 1030 kg/ cubic meter assumed to be teh density of milk for further calculations. 

1 cubic meter is 1000 liters.

For example, industrial unit 119791 produces 3345.57 thousand litres of toned milk.

Production = 3345.57 Kilo litres


Mass of prodcution = Density * Volume

                   = 1030 * 3345.57

                   = 3445937.1 tonnes

Conversion factor = 1030


### NIC code 10504
NIC code 10504 corresponds to firms engaged in the manufacture of cream, butter, cheese, curd, ghee, khoya etc. and prodcution is measured in kilograms and kilo litres. Hence, for the sake of calculation, the density of milk is assumed to be the density of variety fo milk based products consiodered under this set of mkanufacturing firms.

So conversion factor = 1030 kg/cubic meter

### NIC code 10799

NIC code 10799 correpsonds to firms engaged in the manufacture of other semi-processed, processed or instant foods n.e.c. except farinaceous products and malted foods and manufacturing activities like manufacture of egg powder, sambar powder etc. (this excludes the activities covered under 10619).

Within this NIC code, we are considering firm 209474 which produces extracts, essences and concentrates of tea or mate, and preparations with a basis thereof or with a basis of tea or mat‚; n.e.c. According to [Tea Density](https://kg-m3.com/material/tea-liquid), the density of tea is assumed to be 1000 kg/cubic meter, which is 1 kilogram per litre. 

Mass of essence = Density * Volume

                = 1 kg/L * 20460 litres 

                = 20460 kgs / 1000

                = 20.46 tonnes

So conversion factor = 0.001


### NIC code 11043
NIC code 11043 corresponds to firms engaged in the manufacture of mineral water.

Firm 110694 measures ice produced in kilograms. From an [online converter](https://conversion.website.yandexcloud.net/convert-kg-ice-to-liters-online.html) and [other sources](https://www.google.com/search?q=ice+kg+to+liter&ie=UTF-8), we have confirmed that the density of ice to be  917 kg/cubic meter. 

Volume of ice = Mass / Density
              
              = 286153.06 / 917 

              = 312.053500545 cubic meters * 1000 

              = 312053.500545 litres

Conversion factor = Converted Output / Actual Output

                  = 312053.500545 / 286153.06 

                  = 1.09051254089422


### NIC code 11044
NIC code 11044 pertains to firms engaged in the manufacture of ice. 

Firm 120597 produces ice candy and measures in number of candies or popsicles prodcued. From our online search, we understand that the most common popsicle mold has a volume of 70ml. The firm has recorded a production of 72205.42 number of popsciles. 

Volume of total production = Number of popsicles * unit volume

                           = 72205.42 * 70

                           = 5054379.4 ml / 1000,0000

                           = 0.50543794 cubic meters

Mass of Ice candy = Density * Volume

                  = 917 * 0.50543794

                  = 463.48659098 kgs /1000

                  = 0.46348659098 tonnes

Conversion factor = Converted Output / Actual Output

                  = 0.46348659098 / 72205.42

                  = 0.000006419


### NIC code 20111
NIC code 20111 refers to industrial units engaged in the manufacture of liquefied or compressed inorganic industrial or medical gases (elemental gases, liquid or compressed air, refrigerant gases, mixed industrial gases etc.). 

Within this NIC code, Firm 128295 produced 3 products and measures them as follows:
1. Oxygen liquid: Measured in Cubic meters. 
2. Nitrogen Liquid: Meaured in Litres
3. Argon Gas: Measured in Thousand Cubic Meters

These products were converted to tonnes based on the information available in [Aqua-Calc](https://www.aqua-calc.com/calculate/volume-to-weight/substance/argon). To reproduce my calculations, use Aqua-Calc and the corresponding values for each chemical.

### NIC Code 20116
NIC code 20116 refers to industrial units engaged in the manufacture of basic chemical elements.

Frim 138579 produces "Ethyl alcohol and other spirits, denatured, of any strength n.e.c" measured in litres. Using [Aqua-Calc](https://www.aqua-calc.com/calculate/volume-to-weight/substance/argon), we calculated the volume of the two products as:

- product 1: Volume in litres = 14336180
             Mass in tonnes = 11315.55
             Conversion factor = 11315.55 / 14336180
                               = 0.0007893

Since product 2 is also ethyl alcohol, we followed the procedure and arrived at the same conversion factor.


### NIC Code 20119
NIC code 20119 concerns with firms engaged in the manufacture of organic and inorganic chemical compounds n.e.c. Using [Aqua-Calc](https://www.aqua-calc.com/calculate/volume-to-weight/substance/argon), we calculated the volume of the two products for:

For firm 207128, we have three products:
- Product 1: Oxygen gas
Volume in Cubic meters = 26949927.01
Mass in tonnes = 38511.45
Conversion Factor = 38511.45 / 26949927.01
                  = 0.001429

- Product 2: Nitrogen Gas
Volume in Cubic meters = 633880.98
Mass in tonnes = 792.99
Conversion Factor = 792.99 / 633880.98
                  = 0.001251008

- Product 3: Argon Gas
Volume in Thousand Cubic meters = 2046.79
Volume in cubic meters = 2046.79 * 1000
                       = 2046790
Mass in tonnes = 3651.06
Conversion Factor = 3651.06 / 2046.79
                  = 1.783798045


### NIC Code 20121
NIC code 20121 deals with firms engaged in the manufacture of urea and other organic fertilizers. 

Firm 125594 among other products, produces "Fertilizers n.e.c." and Argon gas which are measured in cubic meter and thousand cubic meters.

Argon gas is converted at mentgioned under NIC code 20119 (also for firm 131467). 

"Fertilizers n.e.c." is rather a very ambigous term and we couldn't find any fetrlizer compound measured in cubic meters except argon gas. But the manufactured value doesn't seem to match with the argon gas production from other firms. Since we cant identify a specific product, we are going to use the generic cubic meter conversion to [tonne value](https://www.unitconverters.net/volume/cubic-meter-to-ton-register.htm) , that is 

1 cubic meter = 0.3531466672 tonnes

So this becomes the conversion factor for "Fertilizers n.e.c." for firm 125594.


### NIC Code 20221

Firms under NIC code 20221 are engaged in the manufacture of paints and varnishes, enamels or lacquers.

Firm 100180 produces Paints epoxy, Epoxy powder and liquid and measured in litres. We use the density information available [here](https://polyestershoppen.com/epoxy/epoxy-giethars-202.html#:~:text=1%20kg%20epoxy%20is%20approx,0.9%20litres) to convert the same into tonnes. The source says that "1 kg epoxy is approx. 0.9 litres"

Volume of product = 4289059 litres

Mass of product = 4289059 / 0.9

                = 4765621.111111111 kgs

                = 4765.621111111 tonnes

Conversion factor = 4765.621111111 / 4289059
                  
                  = 0.001111111


### NIC Code 35201
NIC Code 35201 contains firms engaged in the manufacture of gas.

Firm 154253 produces Oxygen liquid, Medical Oxygen,  and Nitrogen gas measured in cubic meter, kilograms, cubic meters respectively. Using [Aqua-Calc](https://www.aqua-calc.com/calculate/volume-to-weight/substance/argon), we calculated the volume of the products. 

Nitrogen gas is calculated as mentioned under NIC Code 20119.

For Liquid Oxygen,
Volume = 431219 cubic meters

Mass in tonnes = 492020.88

Conversion factor = 492020.88 / 431219
                  = 1.141000002

### NIC code 23955
For NIC code 23955, we have 3 units producing hume pipe made of Reinforced Cement Concrete. Out of the 3 firms, 1 firm (DSL = 216841) is measuring output units in meters and the other two in tonnes. So we need to convert the meters to tonnes. From my primary research, I have noticed the following:
- The most common RCC hume pipe available is the NP3 quality.
- The per unit sales value is 854.18, and based on my primary research I know that NP3 is the most common hume pipes.
- NP3 pipes which costs INR 800 – 900 have an internal diameter of 400mm and barewall thickness of 75mm. 
- Density of RCC is 2500kg/cu.mtr.
- The length of each pipe is fixed at 2.5 meters or 2500mm.

Now to calculate the weight of the pipe, we must first calculate the volume of the RCC or concrete. To do so follow the steps:

Volume of cylinder = π r² h

- Internal volume of pipe =   (200)²×2500×3.142 = 314200000 cubic milimmeters
- External volume of pipe = ((400+75)/2)² ×2500 ×3.142 = 443071093.75 cubic milimmeters

- Volume of concrete per pipe = External - Internal volume

                              = 443071093.75 - 314200000

                              = 128871093.75 cubic millimeters

                              = 128871093.75/1000000000

                              = 0.128871094 cubic meter

- Mass of concrete per pipe = Volume * Density

                            = 0.128871094 * 2500kg/cubic meter

                            = 322.177735 kgs

                            = 0.322177735 tonnes

The firm has sold 9968 meters of hume pipes, that is given a length of 2.5 meters per pipe, we can calulate the,

Number of NP3 pipes sold by the firm = 9968/2.5

                                     = 3987.2 pipes of NP3 400mm

Total mass of pipes sold by the firms = Mass of one pipe * Total number of pipes

                                      = 0.322177735 * 3987.2

                                      = 1284.587064992 tonnes

So the conversion factor for the excel column = 1284.587064992 tonnes / 9968 meters

                                              = 0.128871094 tonnes per meter


Useful links:
- https://balajispunpipe.com/weight-of-rcc-pipes/
- https://www.google.com/search?q=rcc+hume+pipe+np3+price+list
- https://www.brhcpipes.com/blog/RCC-Pipe-NP2-Class-Price-List/
- https://www.brhcconcreteindustries.com/rcc-pipe-np3-class.html


----


### NIC code 14309
For NIC code 14309, we have two firms 146035, 146277 which produce read made garments. Out of the 5 puts from the two firms, two are measured in Kilograms, two in numbers and one in meters. First we will consider the outputs mentioned using number of garments produced. On average, men's shirts, trousers, jackets and shorts require 2.5 meters of fabric. From one [online source](https://www.onlineclothingstudy.com/2017/06/how-many-meters-of-cloth-do-i-need-for.html), we are informed that clothes of 4 sizes Small, Medium, Large, and XL are produced in the ratio 1:2:2:1. Since we couldn't find anyother source for this information, we are going ahead a with uniform size and fabric requirement. We will convert the unit of measurement to meters of material/fabric produced. To do so, follow the below steps:

For firm 146035,
- Quantity of fabric used = Number of clothing items * Avergae fabric requirement

                          = 47568496 * 2.5 

                          = 118921240 meters

For firm 146277,
- Quantity of fabric used = Number of clothing items * Avergae fabric requirement

                          = 2822201 * 2.5 

                          = 7055502.5 meters

Another parameter that we require for calculation is the width of the fabric used. Cotton and linen fabrics are available at widths ranging from 44 inches and 56-60 inches for the production of apparels according to an [online source](https://www.cvlinens.com/blogs/styling-tips/how-wide-are-fabric-rolls#:~:text=54%2D60%20inches,suitable%20for%20larger%20garment%20pieces.). We will assume a middle ground and consider 54 inches(1.3716 meters) as the standard width of fabric. Further, we assume an average fabric GSM of 200 (0.2 kg), we can calculate the mass of textile as follows:

- Firm 1 = Length of fabric * width of fabric * GSM

         = 118921240 * 1.3716 * (0.2 /1000)
         
         = 32622.4745568 Tonnes 

- Frim 2 = Length of fabric * width of fabric * GSM

         = 7055502.5 * 1.3716 * (0.2/1000)
         
         = 1935.465448543 Tonnes 

Now lets calculate the unit of conversion for the excel column we are preparing:

- Firm 1 = Tonnage / Number of apparels

        = 32622.4745568 / 47568496

        = 0.0006858

- Firm 2 = Tonnage / Number of apparels

        = 1935.465448543 / 2822201

        = 0.0006858


Product serial number 4 of firm 146035 is measured in meters. To convert the same to tonnes, we use the above assumptions and calculate as follows:

- Mass of fabric = Length of fabric * width of fabric * GSM

                 = 2662006 * 1.3716 * (0.2/1000)

                 = 730.24148592 tonnes

- Conversion factor = 730.24148592 /  2662006

                    = 0.00027432


----

### NIC code 23952

NIC code 23952, which engages in manufacture of articles articles of concrete, cement or artificial stone (tiles, bricks etc.), we have 6 firms. Out of 6, 2 firms measure in thousands numbers. Firm 126627, manufactures cement bricks and has recorded production of 5913.57 * 1000 bricks. Cement bricks comes in standard size of 10 inch * 10 inch. From earlier, we know that the density of RCC is 2500kg/cu.mtr. So,

Volume of a square cement brick = Length^3

                                = 10 * 10 * 10 cubic inch

                                = 0.254 * 0.254 * 0.254 cubic meters

                                = 0.016387064 cubic meters

Mass of a square brick  = Volume * Density

                        = 0.016387064 * 2500kg/cubic meter

                        = 40.96766 kg

Mass of all concrete bricks produced (DSL=126627) = Mass per brick * Value of outputs

                                                  = 40.96766 * 5913.57 (this 5913.57 is measured in thousand numbers. So the resultant value will be mass in tonnes)

                                                  = 242265.1251462 tonnes


Firm 215515 manufactures bricks and non ceramic tiles. Since we dont have the ratio in which they produce both these products, we will assume that 50% of the putput is bricks and 50% is ceramic tiles. The total output quantity manufactured is 180 (in thousands). So 90k bricks and 90k ceramic tiles. 

I am assuming that these are non ceramic floor tiles of the most common dimension (600mm * 600 mm). Similarly, we know from [EPD](https://www.environdec.com/library/epd6762) that the density of porcelain tile is 2380-2450 kg/m3. 

Volume of a square non ceramic tile = Length^3

                                    = 600 * 600 * 600 cubic mm

                                    = 0.6 * 0.6 * 0.6 cubic meters

                                    = 0.216 cubic meters

Mass of a square non ceramic tile  = Volume * Density

                                   = 0.216 * 2450 kg/cubic meter

                                   = 529.2 kg

Mass of all concrete bricks produced (DSL=126627) = Mass per tile * Value of outputs

                                                  = 529.2 * 90

                                                  = 47628 tonnes


Mass of 90,000 non ceramic bricks = Mass per brick * Value of outputs

                                  = 40.96766 * 90

                                  = 3687.0894 tonnes

Total mass of output produced = Mass of bricks + Mass of tiles

                              = 3687.0894 + 47628

                              = 51315.0894 tonnes

So, the conversion factor = Total mass  / Value of output

                          = 51315.0894 / 180

                          = 285.08383


----


### NIC Code 27201

NIC code 27201 which involves firms engaged in the manufacture of primary cells and primary batteries and rechargable batteries, cells containing manganese oxide, mercuric oxide silver oxide or other material. 

For firm 127317, the most common type of battery packs that I came across in the internet is the Lithium ion battery packs. The firms sells one battery pack at INR 1574.23. 12Ah Lithium ion batteries sell at prices closer to this value and I assume that each pack sold by the firm is the same. After inspecting various sources (listed below), the weight of the specified battery pack is assumed to be 1.6 kgs.

Mass of battery packs = Value of output * mass per pack

                      = 19106 * 1.6/1000

                      = 30.5696 tonnes

Links for battery weight:
- https://www.amazon.com/Feuruetc-12V-Maintenance-Free-Rechargeable-12A/dp/B0CD72H9XF
- https://www.flipkart.com/agastya-energy-12v-12ah-lithium-ion-battery-bms-solar/p/itmf3152b4ac9e36
- https://lrsa.in/product/12v-12ah-lithium-ion-rechargeable-battery-lrsa-technology-pvt-ltd/
- https://www.amazon.com/Feuruetc-12V-Maintenance-Free-Rechargeable-12A/dp/B0CD72H9XF



Firm 204106 manufactures battery plates and sells at a per unit price of INR 177. Battery plates are sold in bulk orders. From what I could gather from the internet sources, the per unit price charged by this unit is really high and most probably is a 210 mm tubular plate. These tubular battery plates are used for the production of 150Ah batteries commonly seen in household inverters. 

150 Ah battery = 6 cells 

1 cell = 15 plates

Therefore, 1 battery = 6 * 15

                     = 90 plates

Dry weight of a battery is assumed to 33 kgs which is the mean of the ChatGPT sourced table below.

So, weight per plate = 33 / 90
                     = 0.367 kgs

Mass of all plates = 0.367 * 2417458.25 /1000 tonnes

                   = 887.20717775 tonnes


conversion factor = 0.367 /1000

                  = 0.000367



Links for checking weight:
- https://www.batteryestore.com/products/luminous-battery-150-ah-ec-18036-tall-tubular-battery-estore?variant=39689380921446&country=IN&currency=INR

- Chat GPT results:



| **Brand & Model**                   | **Dry Weight** | **Source**                                                                                                                        |                                                                                                                                                                                           |
| ----------------------------------- | -------------- | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ZunVolt Xtra 150Ah**              | 29 kg          | [Zunpulse](https://www.zunpulse.com/products/electric-power-and-solar/ZV222032/zunvolt-xtra-150-ah-tall-tubular-inverter-battery) |                                                                                                                                                                                           |
| **Luminous BC18048ST 150Ah**        | 27 kg          | [Battery Anywhere](https://batteryanywhere.in/product/luminous-bc18048st-150ah-battery/)                                          |                                                                                                                                                                                           |
| **Exide Inva Tubular IT500 150Ah**  | 40 kg          | [Battery Mantra](https://www.batterymantra.com/product/exide-it500-tubular-inverter-battery-150-ah)                               |                                                                                                                                                                                           |
| **Exide InvaMaster IMTT1500 150Ah** | 38 kg          | [Flipkart](https://www.flipkart.com/exide-imtt1500-150ah-tall-tubular-battery-60-month-warranty-inverter/p/itm8d3f47c07c2f7)      |                                                                                                                                                                                           |
| **Dynex DTT1536 150Ah**             | 35 kg          | [Battery Mantra](https://www.batterymantra.com/product/dynex-dtt1536-150ah-tall-tubular-inverter-battery)                         |                                                                                                                                                                                           |
| **Su-Kam Big Warrior 150Ah**        | 29 kg          | [Su-Kam](https://www.su-kam.com/product/150ah-tubular-battery/)                                                                   |                                                                                                                                                                                           |
| **UTL 150Ah**                       | 28.55 kg       | [UTL Solar](https://www.upsinverter.com/product/utl-150ah-inverter-battery/)                                                      |                                                                                                                                                                                           |
| **Genus 150Ah**                     | 40 kg          | [Flipkart](https://www.flipkart.com/genus-150ah-tall-tubular-battery-825va-inverter/p/itm47a6c63762f06)                           | 




---
### NIC Code 28299

NIC code 28299 conatins one firm which engages in the manufacture of other special-purpose machinery.

Firm 127721 manufactures 5 separate products. The first product goes by the description "Electric instantaneous or storage water heaters and immersion heaters; electric space heating apparatus and soil heating apparatus; ovens; cookers, cooking plates, boiling rings, grillers and roasters". Since the product description covers a wide range of products which has a heating coil in common. So, we assume that this special purpose machinery is the "heating element" thats goes into ovens, water heaters, grills etc. The per unit sales  price of this heating element is recorded as INR 7884.15. The closest product I could find was Copper Hetaing Element operating in 220V and delivering 3000W. This product is expected to weigh between 150g to 250g, and we take the average at 200g(0.2 kg).

The firm produces 152726.97 units of this product. So,

mass of copper heating element coils = 152726.97 * 0.2 /1000

                                     = 30.545394 tons

Conversion factor = 0.2/1000 = 0.0002





Links to copper heating elements:
- https://www.desertcart.in/products/734378949
- https://www.google.com/search?q=3000w+copper+heating+element+weight&ie=UTF-8



Firm 127721 produces 177.34 industrial fans which is sold at INR 24185.99. I found two results matching this price ranging:
- (Industrial Exhaust Fan 1) [https://lanfest.in/collections/industrial-exhaust-fans/products/smc-industrial-exhaust-fan]
- (Industrial Exhaust Fan 2) [https://lanfest.in/products/industrial-exhaust-fan-metal?variant=35373876379801&country=IN&currency=INR]

They record a weight of nearly 50 kgs per product.

So, mass of fans = 177.34 * 50 /1000

                 = 8.867 tonnes

Conversion factor = 50/1000
                
                   = 0.05

The last product produced by 127721 is "Machinery parts, non-electrical". This is a vague description and we have to assume that these are small machine parts and the weight is one-thousandth of the number of units produced, that is 

Mass of machine parts = 1004.77 * 0.001
                      
                      = 1.00477 tonnes


---

### NIC Code 12008

For NIC Code 12008 which comprises of firms engaged in the manufacture of pan masala and related products.We have one firm (DSL = 123720) producing 2 products namely, "Guthka (Panparag, Shekhar, Teranga, Madhu, etc.)"  and "Other manufactured tobacco and manufactured tobacco substitutes". The latter is measured in thousand numbers and ambigous. Since its measured in thousand numbers, we have to assume these are 20g (0.02 kg) sachet packets which is the most common packet size as is present in [Paan Shop Online](https://www.paanshopsonline.com/Pan-Masala-Tinn-Pouch-Zipper-Boxes-chewing-Paan-Mouth-freshner?product_id=397&sort=rating&order=ASC&limit=50).

Mass of packets = 52003 * 0.02

                = 1040.06 tonnes (its in tonnes because 52,003 is also in thousands. So need not divide by 1000)



Apart from the above mentioned cases, we have undertaken the following general rules:
- Kilograms were converted to tonnes by multiplying the output with 0.001.
- Kilowatts were converted to megawatts  by multiplying the output with 0.001.
- Numbers (Nos.) were converted to Thousand Numbers (Th. Nos.) by multiplying the output with 0.001.