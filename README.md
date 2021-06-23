# Invoice - UserDefinedFunctions(SQL)

User-defined functions

### Overview

There are four different tasks completed using user-defined functions.

  - **Task 0**: Create a function named TaxConversion which accepts only a value 
    and returns it as a percentage in decimal form.
 
    | **Values** | 6% | 2% | 21.9% |
    | ----------- | ----------- | ----------- | ----------- |
    
    Convert the specified values using the taxConverison function.
  
  - **Task 1**: Create a function named totalCost which accepts only the name of 
    an item, cost of an itemn and the sales tax percentage and returns the 
    total cost of the item.
   
    | **Item** | **Cost** | **SaleTax** |
    | ----------- | ----------- | ----------- |
    | Helmet | $123.45 | 8% |
    | Armor | $768.76 | 11% |
    | Weapon | $1378.50 |2.9%|
    
    Calulate the total cost for each of the specified items using 
    the totalCost fucntion.

  - **Task 2**: Create a function named totalItemsCost which accepts only 
    the number and type of item to be purhcased(all of same type) and 
    returns the total price of the items.
  
    | **Item Choices** | **Cost** |	**Sales Tax** |	**Number Purchased** |
    | ----------- | ----------- | ----------- | ----------- |
    | Radio |	$213.00	|	10% |	2 |
    | Scanner |	$855.40 | 8% | 12 |
    | Grenade	|	$12.75 | 2%	|	100 |
    
    Calculate the total cost of the specified number of items using 
    the totalItemCost function.
    
  - **Task 3**: Create a function named invoice3Item which accepts 3 items, 
    the number of each item purchased, the cost associated with each item,
    the tax on each item and returns an invoice(see format)of the items.
    **xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx**

    | **Item** | **Cost** | **Sales Tax** | **Count** | **Total Cost** |
    | ----------- | ----------- | ----------- | ----------- | ----------- |
    | Radio | $213.00 | 10% | 3 | $xxxx.xx |
    | Scanner | $855.40 | 8% | 6	| $xxxx.xx |
    | Grenade | $12.75 | 2% | 10 | $xxxx.xx |
    | |**Invoice total**|	| | $xxxx.xx |
    
    
    **xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx**
    
    Display the invoice using th invoice3Item function.

