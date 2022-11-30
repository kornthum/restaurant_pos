CREATE EXTERNAL TABLE transactions_cln(
  id         int
  ,restaurant_name  string
  ,order_menu string
  ,order_price int
  ,order_timestamp	bigint
  ,pos_type         string
) 
STORED AS PARQUET
LOCATION '/tmp/default/transactions_cln/'