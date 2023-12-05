import os
from dotenv import load_dotenv
import openai
import time
import json
import sys

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

def llm(model,message):
    max_retries = 3  # Maximum number of retries
    retries = 0

    while retries < max_retries:
        try:
            #print(f"Requesting")
            start_time = time.time()  # Start time
            output = openai.ChatCompletion.create(model=model, messages=message)
            end_time = time.time()  # End time

            time_taken = end_time - start_time  # Calculate time taken
            query = output["choices"][0]["message"]["content"]

            return (time_taken, query)  # Return the result if successful
        except Exception as e:
            print(f"Error: {e}")
            print("Retrying...")
            retries += 1
            time.sleep(60)  # Sleep for 1 minute before retrying

    print("Max retries reached. Unable to complete the operation.")
    return None

def main():
    log_file = f"./output_log.txt"
    for i in range(1,100):
        prompt_path = f"../prompts/oneshot-prompt{i}.txt"
        response_time_path = f"../response_times/oneshot-response-time{i}.txt"
        query_path = f"../SQL-queries/oneshot-sqlquery{i}.sql"

        with open(prompt_path,"r") as f:
            prompt = f.read()
        prompt = json.loads(prompt)
        
        #time_taken, query = llm("gpt-3.5-turbo",prompt)
        print(f"query {i} being requested")
        time_taken, query = llm("gpt-4",prompt)
        
        with open(response_time_path,"w") as f:
            f.write(str(time_taken))
        with open(query_path,"w") as f:
            f.write(query)

       
        with open(log_file, "a") as log:
            log.write(f"File {query_path} created.\n")
        
        time.sleep(60) #45s time delay to ensure that the API isn't throttled

if __name__ == "__main__":
    main()