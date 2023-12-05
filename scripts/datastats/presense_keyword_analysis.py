# Generate a histogram graph where the x-axis shows the different SQL keywords while the yaxis measures the count of the queries that has the specific keyword. If the SQL keyword is present in a query then count it as one and dont increment. It should only include the no of SQL files that has the specific and unique SQL keyword. 
import matplotlib.pyplot as plt
from collections import Counter
import os
import re

#extract_target_dir = '/workspace/data/cs598-tpcds/data/dataset-spider/'
extract_target_dir = '/workspace/data/cs598-tpcds/data/dataset/'

sql_directory = f"{extract_target_dir}/SQL"
sql_files = os.listdir(sql_directory)  # List out the SQL files for analysis
len(sql_files), sql_files[:5]  # Check the count and see first five file names to ensure everything is in order

# Initialize a Counter object to count occurrences of SQL keywords
keyword_counts = Counter()
# Define SQL keywords
complex_sql_keywords = [
    'CREATE TABLE', 'DROP TABLE', 'INSERT INTO', 'ALTER TABLE', 'PARTITION BY',
    'ADD', 'ALL', 'AND', 'ANY', 'AS', 'ASC', 'BACKUP', 'BETWEEN', 'CASE', 'CHECK', 'COLUMN',
    'CONSTRAINT', 'DATABASE', 'DEFAULT', 'DELETE', 'DESC', 'DISTINCT', 'EXEC', 'EXISTS',
    'FOREIGN', 'FROM', 'FULL', 'GROUP', 'HAVING', 'IN', 'INDEX', 'INNER', 'INTERSECT', 'INTO', 'IS', 'JOIN',
    'LEFT', 'LIKE', 'LIMIT', 'NOT', 'NULL', 'OR', 'ORDER', 'OUTER', 'PRIMARY', 'PROCEDURE', 'RIGHT', 'ROWNUM',
    'SELECT', 'SET', 'TABLE', 'TOP', 'TRUNCATE', 'UNION', 'UNIQUE', 'UPDATE', 'VALUES', 'VIEW', 'WHERE', 
    'ROW_NUMBER', 'DENSE_RANK', 'RANK', 'COUNT', 'SUM', 'AVG', 'MIN', 'MAX', 'ROUND'
]

# Reset the keyword counts dictionary with the complex and single keywords
keyword_counts = {keyword: 0 for keyword in complex_sql_keywords}

# Function to count complex keywords in a file content
def count_complex_keywords_in_file(file_content):
    # Normalize file content to uppercase for case-insensitive matching
    content_upper = file_content.upper()
    # For each complex keyword, use regex search to find exact matches
    for complex_keyword in complex_sql_keywords:
        # Use regex word boundary to ensure exact match; escape to handle potential regex metacharacters
        pattern = r'\b' + re.escape(complex_keyword) + r'\b'
        if re.search(pattern, content_upper, re.IGNORECASE):
            keyword_counts[complex_keyword] += 1

# Process each SQL file and count the occurrences of complex keywords
for sql_file in sql_files:
    with open(os.path.join(sql_directory, sql_file), 'r', encoding='utf-8') as file:
                count_complex_keywords_in_file(file.read())

# Remove keywords with zero occurrences from the dictionary before plotting
filtered_keyword_counts = {k: v for k, v in keyword_counts.items() if v > 0}
sorted_keyword_counts = dict(sorted(filtered_keyword_counts.items()))

tmp = '\t'
for entry,value in sorted_keyword_counts.items():
    print(entry,tmp , value)
#print(sorted_keyword_counts)
# Plotting the histogram with the updated counts
plt.figure(figsize=(18, 8))
plt.bar(sorted_keyword_counts.keys(), sorted_keyword_counts.values(), color='skyblue')
plt.xlabel('SQL Keywords')
plt.ylabel('Number of Files Containing the Keyword')
plt.title('Occurrence of Complex SQL Keywords in SQL Files')
plt.xticks(rotation=90)  # Rotate labels for better readability
plt.tight_layout()  # Adjust layout to accommodate all x labels

# Save and display the new histogram
plt.savefig('presence_sql_keywords_plot.pdf', format='pdf')
#plt.show()  # Show the plot

