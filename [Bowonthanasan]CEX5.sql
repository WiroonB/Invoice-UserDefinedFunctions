# CEX5 Wiroon Bowonthanasan




DROP DATABASE IF EXISTS invoice;
CREATE DATABASE IF NOT EXISTS invoice;
USE invoice;


/*

Task 0: Create a function named TaxConversion which accepts only a value 
and returns it as a percentage in decimal form

Values: 6%, 
		12%, 
		21.9%

Convert the specified values using the taxConverison function.

*/

DELIMITER //
CREATE FUNCTION taxConversion(V DECIMAL(10,3))
RETURNS DECIMAL(10,3)

BEGIN
	DECLARE TConv DECIMAL(10,3);

	SET TConv = V / 100;
	
	RETURN TConv;
END //
DELIMITER ;

SELECT taxConversion(6) AS 'Percent 1';
SELECT taxConversion(12) AS 'Percent 2';
SELECT taxConversion(21.9) AS 'Percent 3';

---------------------------------------------------------------------

/*

Task 1: Create a function named totalCost which accepts only the name of 
an item, cost of an itemn and the sales tax percentage and returns the 
total cost of the item.

Item 		Cost 		SaleTax

Helmet 		$123.45		8%
Armor		$768.76 	11%,
Weapon		$1378.50 	2.9%

Calulate the total cost for each of the specified items using 
the totalCost fucntion

*/

DELIMITER //
CREATE FUNCTION totalCost2(Cost DECIMAL(10,2), Tax DECIMAL(4,2))
RETURNS DECIMAL(10,2)

BEGIN
	DECLARE TCost DECIMAL(10,2);

	SET TCost = Cost + (Cost * taxConversion(Tax));
	
	RETURN TCost;
END //
DELIMITER ;

SELECT totalCost2(100,8) AS 'TC2';


DELIMITER //
CREATE FUNCTION totalCost(I VARCHAR(25), Cost DECIMAL(10,2), Tax DECIMAL(4,2))
RETURNS VARCHAR(50)

BEGIN
	DECLARE RV VARCHAR(50);
	DECLARE TCost DECIMAL(10,2);

	SET TCost = Cost + (Cost * taxConversion(Tax));
	SET RV = CONCAT(I, ' total cost is $',TCost, ' dollars');	
	
	RETURN RV;
END //
DELIMITER ;

SELECT totalCost('Helmet',123.45,8) AS 'Helmet';
SELECT totalCost('Armor',768.76,11) AS 'Armor';
SELECT totalCost('Weapon',1378.50,2.9) AS 'Weapon';



---------------------------------------------------------------------

/*

Task 2: Create a function named totalItemsCost which accepts only 
the number and type of item to be purhcased(all of same type) and 
returns the total price of the items.

Item Choices 	Cost 		Sales Tax 		Number Purchased

Radio 			$213.00		10% 			2
Scanner 		$855.40 	8%				12
Grenade			$12.75		2%				100

Calculate the total cost of the specified number of items using 
the totalItemCost function

*/


DELIMITER //
CREATE FUNCTION totalItemsCost(N INT, I VARCHAR(25))
RETURNS VARCHAR(50)

BEGIN
	DECLARE RV VARCHAR(50);
	DECLARE TCost DECIMAL(10,2);
	DECLARE R DECIMAL(10,2); 
	DECLARE S DECIMAL(10,2); 
	DECLARE G DECIMAL(10,2);
	DECLARE RTax INT; 
	DECLARE STax INT; 
	DECLARE GTax INT;

	SET R = 213.00; 
	SET S = 855.40; 
	SET G = 12.75;
	SET RTax = 10; 
	SET STax = 8; 
	SET GTax = 2;

	IF I = 'Radio' THEN
		SET TCost = totalCost2(R,RTax) * N;
	END IF;
	IF I = 'Scanner' THEN
		SET TCost = totalCost2(S,STax) * N;
	END IF;
	IF I = 'Grenade' THEN
		SET TCost = totalCost2(G,GTax) * N;
	END IF;
	SET RV = CONCAT('Total cost of ',N,' ',I, ' is $', TCost, ' dollars');	
	
	RETURN RV;
END //
DELIMITER ;

SELECT totalItemsCost(2,'Radio') AS 'Radio';
SELECT totalItemsCost(12,'Scanner') AS 'Scanner';
SELECT totalItemsCost(100,'Grenade') AS 'Grenade';


---------------------------------------------------------------------

/*

Task 3: Create a function named invoice3Item which accepts 3 items, 
the number of each item purchased, the cost associated with each item,
the tax on each item and returns an invoice(see format)of the items.


xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Item 		Cost  		Sales Tax 	Count 	Total Cost

Radio 		$213.00		10% 		3
Scanner 	$855.40 	8%			6		
Grenade		$12.75		2%			10	

			Invoice total 						  $xxxx.xx							
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


Display the invoice using th invoice3Item function.


*/


DELIMITER //
CREATE FUNCTION invoice3Item(Item1 VARCHAR(25), Item1Cost DECIMAL(10,2), Item1Tax INT, Item1Count INT,
Item2 VARCHAR(25), Item2Cost DECIMAL(10,2), Item2Tax INT, Item2Count INT,
Item3 VARCHAR(25), Item3Cost DECIMAL(10,2), Item3Tax INT, Item3Count INT)
RETURNS VARCHAR(500)

BEGIN
	DECLARE IL1 VARCHAR(50); 
	DECLARE IL2 VARCHAR(50); 
	DECLARE IL3 VARCHAR(50); 
	DECLARE IL4 VARCHAR(50); 
	DECLARE IL5 VARCHAR(50);
	DECLARE HL VARCHAR(100);
	DECLARE BL VARCHAR(100);
	DECLARE TCI_1 DECIMAL(10,2); 
	DECLARE TCI_2 DECIMAL(10,2); 
	DECLARE TCI_3 DECIMAL(10,2);
	DECLARE INVTotal DECIMAL(10,2);
	DECLARE IChart VARCHAR(500);

	SET TCI_1 = totalCost2(Item1Cost,Item1Tax) * Item1Count;
	SET TCI_2 = totalCost2(Item2Cost,Item2Tax) * Item2Count;
	SET TCI_3 = totalCost2(Item3Cost,Item3Tax) * Item3Count;
	SET INVTotal = TCI_1 + TCI_2 + TCI_3;
	SET HL = CONCAT('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',char(10));
	SET BL = CONCAT('                                                                                 ',char(10));
	SET IL1 = CONCAT('Item',char(9),'Cost',char(9),char(9),'Sales Tax',char(9),'Count',char(9),'Total Cost',char(10));
	SET IL2 = CONCAT(Item1,char(9),'$',Item1Cost,char(9),char(9),Item1Tax,'%',char(9),char(9),Item1Count,char(9),'$',TCI_1,char(10));
	SET IL3 = CONCAT(Item2,char(9),'$',Item2Cost,char(9),char(9),Item2Tax,'%',char(9),char(9),Item2Count,char(9),'$',TCI_2,char(10));
	SET IL4 = CONCAT(Item3,char(9),'$',Item3Cost,char(9),char(9),Item3Tax,'%',char(9),char(9),Item3Count,char(9),'$',TCI_3,char(10));
	SET IL5 = CONCAT(char(9),char(9),char(9),'Invoice Total',char(9),char(9),char(9),'$',INVTotal,char(10));
	SET IChart = CONCAT(HL,IL1,BL,IL2,IL3,IL4,BL,IL5,HL);
	
	RETURN IChart;
END //
DELIMITER ;

SELECT invoice3Item('Radio',213.00,10,3,'Scanner',855.40,8,6,'Grenade',12.75,2,10) AS 'INVOICE';


