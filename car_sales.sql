create database car_sales;
use car_Sales;
-- check the number of unique records in table
select count(distinct(vin)) from sales_data;
-- add saledate in yyyy-mm-dd format
ALTER TABLE sales_data
ADD COLUMN sale_date DATE;

UPDATE sales_data
SET sale_date = DATE_ADD('1899-12-30', INTERVAL saledate DAY);

-- delete saledate column
alter table sales_data
drop column saledate;

-- check the manfature year of cars range
select min(model_year) as 'min' , max(model_year) as 'max' from sales_data;

-- car brands and count of cars sold
select car_brand, count(car_brand) from sales_data group by car_brand;

-- brand, model where transmission is null with count
select model_year, car_brand, transmission, count(transmission) from sales_data where transmission = '' group by model_year,car_brand,transmission;

-- we found the topmost are nissian altima 2.5 and 2.5s based on our research after 2011 there is no manual 
select model_year, transmission, count(transmission) from sales_data where model in ('Altima 2.5', 'Altima 2.5 S') group by transmission,model_year order by model_year,transmission,count(transmission);

-- we are gonna replace null values until 2011 with manual because there is pattern that manual is empty on these columns
update sales_data
set transmission = "Manual" 
where model in ("Altima 2.5", "Altima 2.5 S")
and model_year <= 2011
and transmission = '';

-- we are gonna replace rest null values with automatic
update sales_data
set transmission = "Automatic" 
where model in ("Altima 2.5", "Altima 2.5 S")
and (transmission is null or transmission = '');

-- check number the number of transmission blank with model year along with how many automatic and how many manual 
select model_year, transmission, count(transmission) from sales_data where model = 'F-150 Xlt'  group by transmission,model_year order by model_year,transmission,count(transmission);

-- after reserach we found that ford xlt vehicle stops manual transmission from 2003 onwards so we will fillup the data with manual before that where there is null or gap
update sales_data
set transmission = "Manual" 
where model = 'F-150 Xlt'
and model_year <= 2003
and transmission = '';

-- for rest we fill with automatic whether it is manual or '' 
update sales_data
set transmission = "Automatic" 
where model = 'F-150 Xlt'
and model_year > 2003
and (transmission = '' or transmission = 'Manual');

-- check for overall cars transmission null values  
select model, model_year, transmission, count(transmission) from sales_data  
    group by transmission,model_year,model order by model,model_year,transmission;
    
    
    
-- after looking at columns we found that mostly manual is missing so filling empty rows with manual
 update sales_data
set transmission = "Manual" 
where transmission = '';

-- check unique values in VIN column 
select count(distinct VIN) from sales_data;

-- check unique values in state column 
select state,count(state) from sales_Data group by state;

select `condition`,count(`condition`) from sales_Data group by `condition`;