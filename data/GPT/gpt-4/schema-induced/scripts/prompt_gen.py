'''
messages = [
    {"role": "system", "content": "You are an expert Text-to-SQL assistant. Your goal is to provide correct SQL queries to the given text description. Your output only contains the SQL code. No explanation or introductory sentences surrounding the SQL response is needed. You are given schema information containing table names in <tableName> tags and columns in <columns> tags. Here is the schema information:"},
    {"role": "user", "content": schema_info},
    {"role": "system", "content": "Here is the user question:"},
    {"role": "user", "content": user_query},
    {"role": "system", "content": "Here are the 3 critical rules for the interactions you must abide:\n<rules>1.do not  Wrap the generated SQL code within SQL code markdown format. Also, do not include the SQL keyword in the beginning of the response.\n2. If I don't tell you to find a limited set of results, limit to 100.\n3. Only use tables and columns from the list provided, where each table name can be found within <tableName> and columns within <columns></rules>"},
]
'''
'''
schema_info : ./data/GPT/tpcds-schema/
user_query: ./data/dataset/NLQ/
'''
import os
import json


output_directory = os.path.abspath("../prompts")
if not os.path.exists(output_directory):
   
    os.makedirs(output_directory)


for i in range(1, 100):
<<<<<<< Updated upstream
    schema_file_path = f"../../../tpcds-schema/query_{i}.txt"
    user_query_path = f"../../../../dataset/NLQ/query{i}.txt"
=======
    schema_file_path = os.path.abspath(f"../schema/query_{i}.txt")
    user_query_path = os.path.abspath(f"../../../../dataset/NLQ/query{i}.txt")
>>>>>>> Stashed changes
    output_file_path = f"{output_directory}/oneshot-prompt{i}.txt"

    with open(schema_file_path, 'r') as schema_file, open(user_query_path, 'r') as query_file:
        schema_info = schema_file.read()
        user_query = query_file.read()

        message = [
            {"role": "system", "content": "You are an expert Text-to-SQL assistant. Your goal is to provide correct SQL queries in accordance with the given text description. Please use the SQL dialect compatible with duckDB. Your output should only contain the SQL code. No explanation or introductory sentences surrounding the SQL response is needed. You are given schema information containing table names in <tableName> tags and columns in <columns> tags. Here is the schema information:"},
            {"role": "user", "content": schema_info},
            {"role": "system", "content": "Here is the user question:"},
            {"role": "user", "content": user_query},
            {"role": "system", "content": "Here are the 3 critical rules for the interactions you must abide:\n<rules>1.do not  Wrap the generated SQL code within SQL code markdown format. Also, do not include the SQL keyword in the beginning of the response.\n2. If I don't tell you to find a limited set of results, limit to 100.\n3. Only use tables and columns from the list provided, where each table name can be found within <tableName> and columns within <columns></rules>"}
        ]

        with open(output_file_path, 'w') as output_file:
            #so that messages can be loaded as a list of dictonaries in accordance with the expectation
            #of messages field in the OpenAI call
            json.dump(message, output_file, indent=4) 

        print(f"File {output_file_path} created.")

