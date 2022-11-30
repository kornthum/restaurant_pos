CREATE EXTERNAL TABLE transactions_cln(
   customer_id         int
  ,restaurant_name  string
  ,customer_order  	string
  ,order_timestamp	bigint
  ,pos_type         string
) 
STORED AS PARQUET
LOCATION '/tmp/default/transactions_cln/'