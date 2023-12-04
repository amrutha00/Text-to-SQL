import duckdb
import os
import time

# Define the connection parameters
query_path='/workspace/data/tpcds-insights/data/sql/sql_files_sf100'
query_result='/workspace/data/duckdb/results/tpcds/100/golden/'
query_time_file='/workspace/data/duckdb/results/tpcds/100/golden/query_time.csv'

# Connect to the DB 
db_con = duckdb.connect()

# Load the TPCDS database
db_con.execute("IMPORT DATABASE '/workspace/data/duckdb/build/release/tpcdssf100'")

print("Loading of TPCDS DB complete.")

# Create a folder to store query results
os.makedirs(query_result, exist_ok=True)

query_files = [f for f in os.listdir(query_path) if os.path.isfile(os.path.join(query_path, f))]
query_files = sorted(query_files)

# Iterate through the queries and execute them
for query_file in query_files:
    print("Executing ", query_file)
    # extract query number from the query file name.
    query_name = os.path.splitext(query_file)[0]

    # Read the query from the file
    with open(os.path.join(query_path, query_file), 'r') as f:
        query=f.read()

    # Execute the query and measure execution time
    try:
        start_time = time.time()
        result = db_con.execute(query)
        execution_time = time.time()-start_time
    
        # Save the query result to a file
        output_file_path = query_result + query_name + ".csv"
        with open(output_file_path, "w") as out_file:
            for row in result.fetchall():
                out_file.write(str(row) + "\n")
        with open(query_time_file, "a") as time_file:
                time_file.write(f'Query {query_name} executed in {execution_time:.2f} seconds' + "\n")

        print(f'Query {query_name} executed in {execution_time:.2f} seconds')
    except Exception as e: 
        print(f'Query {query_name} executed in error: {e}')
# Close the database connection
db_con.close()

