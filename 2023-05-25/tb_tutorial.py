from __future__ import annotations

# [START tutorial]

# implement pip as a subprocess:
import sys
import subprocess
def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])
install('seaborn')

# [START import_module]
from datetime import datetime, timedelta
from textwrap import dedent

# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG

# Operators; we need this to operate!
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator

# Functions to manipulate data frames


# [END import_module]
import urllib.request
import zipfile
import glob
import pandas

def _retrieve():
    urllib.request.urlretrieve("https://github.com/JacekPardyak/tb-data-science-talks/raw/master/2023-/retail-and-retailers-sales-time-series-collection.zip", "retail-and-retailers-sales-time-series-collection.zip")
    with zipfile.ZipFile("retail-and-retailers-sales-time-series-collection.zip", 'r') as zip_ref:
        zip_ref.extractall()
    files = glob.glob("*.csv")
    df = []
    for file in files:
        tmp = pandas.read_csv(file, parse_dates=['date'])
        tmp['file'] = file.replace(".csv", "" )
        df.append(tmp)
    df = pandas.concat(df)
    df = df[['file', 'date','value']]
    df.to_csv('out.txt')

import seaborn as sns
import matplotlib.pyplot as plt

def _represent():
  df = pandas.read_csv('out.txt', parse_dates=['date'])
  # Create a grid : initialize it
  g = sns.FacetGrid(df, col='file', hue='file', col_wrap=4, )
  # Add the line over the area with the plot function
  g = g.map(plt.plot, 'date', 'value')
  # Fill the area with fill_between
  g = g.map(plt.fill_between, 'date', 'value', alpha=0.2).set_titles("{col_name} file")
  # Control the title of each facet
  g = g.set_titles("{col_name}")
  # Add a title for the whole plot
  plt.subplots_adjust(top=0.92)
  g = g.fig.suptitle('Retail and Retailers Sales Time Series Collection')
  # Show the graph
  #plt.show()
  plt.savefig("Retail.png") # also .svg
 
# [START instantiate_dag]
with DAG(
    "tb_tutorial",
    # [START default_args]
    # These args will get passed on to each operator
    # You can override them on a per-task basis during operator initialization
    default_args={
        "depends_on_past": False,
        "email": ["airflow@example.com"],
        "email_on_failure": False,
        "email_on_retry": False,
        "retries": 1,
        "retry_delay": timedelta(minutes=5),
        # 'queue': 'bash_queue',
        # 'pool': 'backfill',
        # 'priority_weight': 10,
        # 'end_date': datetime(2016, 1, 1),
        # 'wait_for_downstream': False,
        # 'sla': timedelta(hours=2),
        # 'execution_timeout': timedelta(seconds=300),
        # 'on_failure_callback': some_function,
        # 'on_success_callback': some_other_function,
        # 'on_retry_callback': another_function,
        # 'sla_miss_callback': yet_another_function,
        # 'trigger_rule': 'all_success'
    },
    # [END default_args]
    description="A simple tutorial DAG",
    schedule=timedelta(days=1),
    start_date=datetime(2021, 1, 1),
    catchup=False,
    tags=["example"],
) as dag:
    # [END instantiate_dag]

    # t1, t2 and t3 are examples of tasks created by instantiating operators
    # [START basic_task]
    
    t1 = PythonOperator(
        task_id="retrieve",
        python_callable=_retrieve
    )

    t2 = PythonOperator(
        task_id="represent",
        python_callable=_represent
    )

#    t7 = PythonOperator(
#        task_id="list",
#        python_callable=_list
#    )



    # [END basic_task]

    # [START jinja_template]
    templated_command = dedent(
        """
    {% for i in range(5) %}
        echo "{{ ds }}"
        echo "{{ macros.ds_add(ds, 7)}}"
    {% endfor %}
    """
    )

    t4 = BashOperator(
        task_id="templated",
        depends_on_past=False,
        bash_command=templated_command,
    )
    # [END jinja_template]

    t1 >> t2 >> t4 
# [END tutorial]
