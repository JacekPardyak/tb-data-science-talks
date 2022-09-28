#!/usr/bin/python -tt
# -*- coding: utf-8 -*-

import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.window import Window
from datetime import datetime
seed = int(round(datetime.now().timestamp()))

import os
os.environ['PYSPARK_PYTHON'] = '/usr/bin/python3'

# https://spark.apache.org/docs/latest/configuration.html
spark = SparkSession.builder\
.appName("JCK-crontab")\
.config("spark.cores.max","4")\
.config("spark.executor.memory","10g")\
.config("spark.dynamicAllocation.enabled","false")\
.config("spark.sql.warehouse.dir","/home/spark/production/warehouse")\
.enableHiveSupport()\
.getOrCreate()

print (spark)
