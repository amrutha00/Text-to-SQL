#import matplotlib.pyplot as plt
import numpy as np
import os
# Read query generation times from the text file
query_times = [[],[]]
count = 0
for i in range(1,100):
    path = f"../gpt-3.5/response-time/query_response_time_{i}.txt"
    try:
        with open(path, 'r') as file:
            
            query_times[0].append(float(file.read().strip()))
            print(path,query_times[0][-1])
    except FileNotFoundError as e:
        continue

for i in range(1,100):
    path = f"../gpt-4/response-time/query_response_time_{i}.txt"
    try:
        with open(path, 'r') as file:
            query_times[1].append(float(file.read().strip()))
    except FileNotFoundError as e:
        continue

# print(count)
# print(len(query_times[0]),len(query_times[1]))
# print(query_times[0])
# print(query_times[1])

mean_times= [np.mean(query_times[0]), np.mean(query_times[1])]
max_times = [np.max(query_times[0]), np.max(query_times[1])]
min_times = [np.min(query_times[0]), np.min(query_times[1])]
std_dev = [np.std(query_times[0]), np.std(query_times[1])]
print(f"Mean execution time of zero-shot GPT3.5 and 4 are {mean_times[0]} and {mean_times[1]} respectively.")
print(f"Max execution time of zero-shot GPT3.5 and 4 are {max_times[0]} and {max_times[1]} respectively.")
print(f"Min execution time of zero-shot GPT3.5 and 4 are {min_times[0]} and {min_times[1]} respectively.")
print(f"STD_DEV execution time of zero-shot GPT3.5 and 4 are {std_dev[0]} and {std_dev[1]} respectively.")
