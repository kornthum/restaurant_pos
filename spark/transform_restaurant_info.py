"""
< TBA information >
"""

import json
from pyspark.sql import SparkSession
from pyspark.sql.functions import regexp_extract, col, udf, StringType

def mapper(location_data):
    def mapper_(col):
        return location_data.get(col)
    return udf(mapper_, StringType())

spark = SparkSession.builder.appName("restaurant_job_spark_job").getOrCreate()
file_path = "/tmp/file/source/raw_less_restaurant_info.csv"

location_data = {
    "Hyderabad":"Silom",
    "Patna":"Sathorn",
    "Mumbai":"Rama 9",
    "Jaipur":"Thong Lo"
}

restaurant = spark.read.option("header", "true").option("inferSchema", "true")\
    .csv(file_path)\

# Get columns name
columns_name = list(restaurant.schema.names)

# Drop index column
restaurant = restaurant.drop(str(columns_name[0]))

## Data Cleaning 

# 1. Restaurant Name: Delete the index number 
# Ex. 1. Deccan Pavilion -> Deccan Pavilion
restaurant = restaurant.withColumn('Restaurant Name', regexp_extract(col('Restaurant Name'), '(^[\d]+. )(.*)', 2))

# 2. Rating: I only want the float value of rating
# Ex. 5.0 of 5 bubbles -> 5.0
restaurant = restaurant.withColumn('rating', regexp_extract(col('Rating'), '(^[\d].[\d])(.*)', 1))

# 3. Number of rating: I will select only value
# Ex. 953 reviews -> 953
restaurant = restaurant.withColumn('Number of Ratings', regexp_extract(col('Number of Ratings'), '(\d*)(\W\D*)', 1))

# 4. Location: I will map to my own location
# Ex. Hyderabad -> Siam
restaurant = restaurant.withColumn('Location', mapper(location_data)("Location"))

# 5. Finalize data & Rename
restaurant = restaurant.select(col("Restaurant Name").alias("restaurant_name"),
                                col("Rating").alias("rating"),
                                col("Number of Ratings").alias("num_rating"),
                                col("Cuisine").alias("cuisine"),
                                col("Location").alias("location"))


#Then we will save it into our HDFS
restaurant.write.csv("/tmp/file/sink/restaurant_info.csv")
spark.stop()