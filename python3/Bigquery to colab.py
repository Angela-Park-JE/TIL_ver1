# @title Setup
from google.colab import auth
from google.cloud import bigquery
from google.colab import data_table

# user권한
from google.colab import auth
auth.authenticate_user()

# Replace 'project_id' with your BigQuery project ID
from google.cloud import bigquery
project = 'challenge'   # Project ID inserted based on the query results selected to explore
location = 'US'         # Location inserted based on the query results selected to explore
client = bigquery.Client(project=project, location=location)

#Replace 'dataset_name' with your actual dataset name
#Replace 'table_name' with the name of the table you want to query
sql_query = ('''SELECT *
                FROM DB.log_data
                ''')

# get the data with dataframe
results = client.query(sql_query).to_dataframe()
