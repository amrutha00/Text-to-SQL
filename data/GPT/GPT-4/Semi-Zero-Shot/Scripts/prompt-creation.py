setup = "With the TPC-DS dataset as a reference, using the table and field names from the TPC-DS benchmark, convert natural language directive provided as input into an SQL query in the Netezza dialect?\nInput: "

path = "../../raw/NLQ-Converted/GPT-NLQ/query"
for i in range(1,100):
    read_file_path = f"../../raw/NLQ-Converted/GPT-NLQ/query{i}.txt"
    with open(read_file_path,'r') as f:
        nlq = f.read().strip()
    prompt = setup + nlq
    write_file_path = f"./prompts/prompt{i}.txt"
    with open(write_file_path,'w') as f:
        f.write(prompt)




