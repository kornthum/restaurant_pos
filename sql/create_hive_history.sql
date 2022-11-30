CREATE EXTERNAL TABLE history(
id int
,restaurant_name string
,order string,
,spend_amount int
) 
PARTITIONED BY (data_dt string)
STORED AS ORC
LOCATION '/tmp/default/loyalty/'