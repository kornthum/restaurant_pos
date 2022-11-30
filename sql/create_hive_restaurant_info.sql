CREATE TABLE restaurant(
	  restaurant_name string, 
	  rating int, 
	  num_rating int, 
	  cuisine string, 
	  location string)
	ROW FORMAT DELIMITED 
	  FIELDS TERMINATED BY ',' 
	  LINES TERMINATED BY '\n' 
	STORED AS INPUTFORMAT 
	  'org.apache.hadoop.mapred.TextInputFormat' 
	OUTPUTFORMAT 
	  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
	LOCATION
	  '/tmp/file/sink/'