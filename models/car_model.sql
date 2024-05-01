
{{ config(materialized='table') }}

-- extract car model company name and origin and create car model
with source_data as (

    select  
        row_number() OVER (ORDER BY car_name DESC) as id,
        car_name as model_name,
        car_name as company_name,
        origin as origin_country
    from 
        TECREO_DEV.TECH_POC.CAR_DETAILS
    group by car_name, origin
)

-- create model car
select * from source_data