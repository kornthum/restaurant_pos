import sys
from pyspark import SparkContext
from pyspark.streaming import StreamingContext
from pyspark.sql import Row, SparkSession
from pyspark.sql.functions import *
from pyspark.sql.types import *

spark = SparkSession.builder.appName("strm_spark_job").enableHiveSupport().getOrCreate()
spark.conf.set("spark.sql.streaming.checkpointLocation", "/tmp/checkpoints")

userSchema = StructType().add("id", "integer").add("restaurant_name", "string").add("order", "string").add("order_timestamp", "integer").add("pos_type", "string")

strmDF = spark \
    .readStream \
    .schema(userSchema) \
    .option("sep", "|") \
    .csv("/tmp/flume/sink")

split_col = split(strmDF['order'], ' ')
strmDF = strmDF.withColumn('order_menu', split_col.getItem(0)) \
.withColumn('order_price', split_col.getItem(1).cast('integer')) \
.withColumn("order_timestamp",from_unixtime(col("order_timestamp"),'dd-MM-yyyy HH:mm:ss').cast('string'))


query = strmDF \
    .selectExpr('id', 'restaurant_name','order_menu','order_price','order_timestamp', 'pos_type') \
    .writeStream \
    .outputMode("append") \
    .format("parquet") \
    .option("path", "/tmp/default/transactions_cln") \
    .start()

query.awaitTermination()