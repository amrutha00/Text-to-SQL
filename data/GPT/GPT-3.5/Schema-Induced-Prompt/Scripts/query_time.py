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
print(f"Mean execution time of one-shot GPT3.5 and 4 are {mean_times[0]} and {mean_times[1]} respectively.")
print(f"Max execution time of one-shot GPT3.5 and 4 are {max_times[0]} and {max_times[1]} respectively.")
print(f"Min execution time of one-shot GPT3.5 and 4 are {min_times[0]} and {min_times[1]} respectively.")
print(f"STD_DEV execution time of one-shot GPT3.5 and 4 are {std_dev[0]} and {std_dev[1]} respectively.")
# # Plotting a line graph of query number versus time of generation
# query_numbers = np.arange(1, len(query_times) + 1)
# plt.figure(figsize=(10, 6))
# plt.plot(query_numbers, query_times, marker='o', linestyle='-')
# plt.title('Query Generation Time')
# plt.xlabel('Query Number')
# plt.ylabel('Time (seconds)')
# plt.grid(True)

# # Save the line plot as an image (e.g., PNG)
# plt.savefig('query_generation_line_plot.png')
# plt.show()

# # Computing statistics
# max_time = np.max(query_times)
# min_time = np.min(query_times)
# mean_time = np.mean(query_times)
# std_dev = np.std(query_times)

# print(f"Maximum Time: {max_time} seconds")
# print(f"Minimum Time: {min_time} seconds")
# print(f"Mean Time: {mean_time} seconds")
# print(f"Standard Deviation: {std_dev} seconds")

# # Plotting the distribution of query generation times
# plt.figure(figsize=(8, 6))
# plt.hist(query_times, bins=15, alpha=0.7, color='skyblue')
# plt.title('Distribution of Query Generation Time')
# plt.xlabel('Time (seconds)')
# plt.ylabel('Frequency')
# plt.grid(True)

# # Save the histogram plot as an image (e.g., PNG)
# plt.savefig('query_generation_histogram.png')
# plt.show()
