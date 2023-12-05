import duckdb
import os
import time
import csv
import random

db_con = duckdb.connect()
#dir_path = "/workspace/data/cs598-tpcds/data/duckdb/tpcds_sf1"
dir_path = "/workspace/data/cs598-tpcds/data/duckdb/tpcds_sf100"
db_populate = db_con.execute(f"import database '{dir_path}';")
db_info = db_con.execute("select * from information_schema.tables;")
db_populated = len(db_info.fetchall())
if db_populated > 0: 
<<<<<<< Updated upstream
    zeroshot_path = "/workspace/data/cs598-tpcds/data/GPT/"
=======
    zeroshot_path = "/data/GPT/"
>>>>>>> Stashed changes
    gpt_model = os.path.join(zeroshot_path,"gpt-4/semi-zero-shot")
    output_dir = os.path.join(gpt_model,"results")
    log_dir =  os.path.join(gpt_model,"logs")
    response_time_dir = os.path.join(gpt_model,"execution-time")
    seed_value = 42
 
    count_fail = 0
    for i in range(1,100):
        print(f"Executing query {i}")
        sql_file_path = os.path.join(gpt_model,f"queries/semi-zero-shot-query{i}.sql")
        output_file_path = os.path.join(output_dir,f"/query-output{i}.csv")
        log_file_path = os.path.join(log_dir,f"query-output-log{i}.csv")
        response_file_path = os.path.join(response_time_dir,f"query-execution-time{i}.txt")
        result = None
        res_time = None
        try:
            with open(sql_file_path,'r') as f:
                sql_query = f.read()
                start_time = time.time()
                result = db_con.execute(sql_query)
                res_time = time.time()-start_time
            
            column_names = [col[0] for col in result.description]
            output = result.fetchall()
            
            with open(output_file_path, 'w', newline='') as csv_file:
                csv_writer = csv.writer(csv_file)
                csv_writer.writerow(column_names)
                csv_writer.writerows(output)

            with open(log_file_path,'w') as f:
                f.write("Sucess")

            with open(response_file_path,'w') as f:
                f.write(str(res_time))

            print(f"Completed query{i} execution")

        except Exception as e:
            count_fail += 1
            with open(log_file_path,'w') as f:
                f.write(str(e))
            print(f"Error in query{i}: {str(e)}")
            continue

    

print("Done")
print("Number of failed executions are",count_fail)

