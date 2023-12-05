import tarfile
import os
import random
import pandas as pd

# Define the path for the uploaded tar.gz file and the target directory to extract its contents
#extract_target_dir = '/workspace/data/cs598-tpcds/data/dataset-spider/'
extract_target_dir = '/workspace/data/cs598-tpcds/data/dataset/'

# List the contents of each subdirectory to get an overview of the specific files contained within
nlq_contents = os.listdir(f"{extract_target_dir}/NLQ")
sql_contents = os.listdir(f"{extract_target_dir}/SQL")

# Load a random sample of 5 files from each NLQ and SQL for content analysis
random_sample_nlq = random.sample(nlq_contents, 5)
random_sample_sql = random.sample(sql_contents, 5)

# Define helper function to load contents of the files
def load_file_contents(file_list, directory):
    contents = {}
    for file in file_list:
        with open(os.path.join(directory, file), 'r', encoding='utf-8') as f:
            contents[file] = f.read().strip()
    return contents

# Load the contents
nlq_sample_contents = load_file_contents(random_sample_nlq, f"{extract_target_dir}/NLQ")
sql_sample_contents = load_file_contents(random_sample_sql, f"{extract_target_dir}/SQL")

# Prepare for match analysis by checking for corresponding pairs
# We'll use the fact that file names without extensions should match between NLQ and SQL
file_stems_nlq = set(file_name.replace(".txt", "") for file_name in nlq_contents)
file_stems_sql = set(file_name.replace(".sql", "") for file_name in sql_contents)
matched_files = file_stems_nlq.intersection(file_stems_sql)
unmatched_nlq = file_stems_nlq - matched_files
unmatched_sql = file_stems_sql - matched_files

# Prepare for statistical analysis by calculating lengths and word counts for all files
def calculate_statistics(file_list, directory):
    lengths, word_counts = [], []
    for file in file_list:
        with open(os.path.join(directory, file), 'r', encoding='utf-8') as f:
            content = f.read().strip()
            lengths.append(len(content))
            word_counts.append(len(content.split()))
    return lengths, word_counts

# Calculate statistics for NLQ and SQL
nlq_lengths, nlq_word_counts = calculate_statistics(nlq_contents, f"{extract_target_dir}/NLQ")
sql_lengths, sql_word_counts = calculate_statistics(sql_contents, f"{extract_target_dir}/SQL")

# Create dataframes for statistical summary
nlq_stats_df = pd.DataFrame({'Lengths': nlq_lengths, 'Word Counts': nlq_word_counts})
sql_stats_df = pd.DataFrame({'Lengths': sql_lengths, 'Word Counts': sql_word_counts})

# Calculate basic descriptive statistics
nlq_descriptive_stats = nlq_stats_df.describe()
sql_descriptive_stats = sql_stats_df.describe()

# Print sample contents for content analysis and the descriptive statistics for statistical analysis
print(f"NLQ Sample contents:", nlq_sample_contents) 
print(nlq_descriptive_stats)
#print(unmatched_nlq) 
print(f"SQL Sample contents:", sql_sample_contents)
print(sql_descriptive_stats) 
#print(unmatched_sql)


