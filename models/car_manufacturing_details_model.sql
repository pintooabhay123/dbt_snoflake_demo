
{{ config(materialized='table') }}

-- extract car manufacturing details and create manufacturing detail model
with mfr_data as (

    select  
        cm.id as car_model_id,
        cd.ACCELERATION,
        cd.CYLINDERS,
        cd.MPG,
        cd.DISPLACEMENT,
        cd.MODEL_YEAR,
        cd.HORSEPOWER,
        cd.WEIGHT   
    from 
        TECREO_DEV.TECH_POC.CAR_DETAILS as cd
    left join
        (
            select  
                row_number() OVER (ORDER BY car_name DESC) as id,
                car_name as model_name,
                car_name as company_name,
                origin as origin_country
            from 
                TECREO_DEV.TECH_POC.CAR_DETAILS
            group by car_name, origin
        ) as cm 
    on 
        cd.car_name=cm.model_name and cd.origin=cm.origin_country    
)

-- create model car
select * from mfr_data