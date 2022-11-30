CREATE TABLE default.transactions(
   customer_id         int
   restaurant_name  string
  ,customer_order  	string
  ,order_timestamp	bigint
  ,pos_type         string
) 
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|' 
LINES TERMINATED BY '\n' 
STORED AS INPUTFORMAT 
'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
'/tmp/flume/sink/'