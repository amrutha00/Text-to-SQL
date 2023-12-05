# Generate a histogram bin for SQL keywords in the SQL statistics for the dataset. Take all the 7000 SQL samples for this. Generate a histogram graph where the x-axis shows the different SQL keywords while the yaxis shows the frequency distribution. 


import tarfile
import os

#extract_target_dir = '/workspace/data/cs598-tpcds/data/dataset-spider/'
extract_target_dir = '/workspace/data/cs598-tpcds/data/dataset/'

sql_directory = f"{extract_target_dir}/SQL"
sql_files = os.listdir(sql_directory)  # List out the SQL files for analysis
len(sql_files), sql_files[:5]  # Check the count and see first five file names to ensure everything is in order


import matplotlib.pyplot as plt
from collections import Counter
import re

# Define SQL keywords to search for in the SQL files
sql_keywords = [
    'CREATE TABLE', 'DROP TABLE', 'INSERT INTO', 'ALTER TABLE', 'PARTITION BY',
    'ADD', 'ALL', 'AND', 'ANY', 'AS', 'ASC', 'BACKUP', 'BETWEEN', 'CASE', 'CHECK', 'COLUMN',
    'CONSTRAINT', 'DATABASE', 'DEFAULT', 'DELETE', 'DESC', 'DISTINCT', 'EXEC', 'EXISTS',
    'FOREIGN', 'FROM', 'FULL', 'GROUP', 'HAVING', 'IN', 'INDEX', 'INNER', 'INTERSECT', 'INTO', 'IS', 'JOIN',
    'LEFT', 'LIKE', 'LIMIT', 'NOT', 'NULL', 'OR', 'ORDER', 'OUTER', 'PRIMARY', 'PROCEDURE', 'RIGHT', 'ROWNUM',
    'SELECT', 'SET', 'TABLE', 'TOP', 'TRUNCATE', 'UNION', 'UNIQUE', 'UPDATE', 'VALUES', 'VIEW', 'WHERE', 
    'ROW_NUMBER', 'DENSE_RANK', 'RANK', 'COUNT', 'SUM', 'AVG', 'MIN', 'MAX', 'ROUND'
    ] 

# Initialize a Counter object to count occurrences of SQL keywords
keyword_counts = Counter()

# Define a regex pattern to match SQL keywords followed by either a space, comma, or end of line
pattern = re.compile(r'\b(' + '|'.join(sql_keywords) + r')\b', re.IGNORECASE)

# Load and count keywords from all SQL files
for sql_file in sql_files:
    with open(os.path.join(sql_directory, sql_file), 'r', encoding='utf-8') as f:
        content = f.read().upper()  # Convert to upper case to match SQL keywords
        matches = pattern.findall(content)  # Find all matches in the content
        keyword_counts.update(matches)  # Update the Counter with the matches found

# Prepare data for plotting
keywords, frequencies = zip(*keyword_counts.items())

for keyword, frequency in zip(keywords, frequencies):
    print(f"{keyword}: {frequency}")

# Plot the histogram
plt.figure(figsize=(15, 5))
plt.bar(keywords, frequencies, color='skyblue')
plt.xlabel('SQL Keywords')
plt.ylabel('Frequency')
plt.xticks(rotation=90)
plt.title('Frequency Distribution of SQL Keywords in SQL Dataset')
plt.tight_layout()  # Adjust layout to not cut off labels
# plt.show()
plt.savefig('sql_keywords_plot.pdf', format='pdf')



