# please note the definition of the complexity is far more superior than the SPIDER difficulty levels. The SPIDER dataset lacked weighs for nested and complex subqueries which are very hard for text-to-sql models to capture and generate responses. Nested and subqueries are very common in TPC-DS benchmark and in practical situations and the SPIDER dataset definitions could distinguish them appropriately. 

# There were many rules we considered prior redefining the complexity specifically for our usecase. At high level we differ from SPIDER dataset definitions on several grounds rules: 
#.	Refine SQL Components Definitions:
#	- Break down SQL components 1 into more detailed sub-components, such as different types of JOIN (e.g., INNER JOIN, LEFT JOIN, etc.) or OR conditions inside and outside of WHERE clauses.
#	- Differentiate between simple and complex uses of LIKE, such as those with wildcards at different positions.
#.	Introduce Weighting for Components:
#	- Assign weights to the components based on their perceived complexity. For example, NESTED queries and multiple uses of UNION, INTERSECT, and EXCEPT could be given higher weights.
#.	Count Occurrences:
#	- Instead of counting the presence of a component as a binary condition, count the number of occurrences. Multiple occurrences would contribute to a higher difficulty level.
#.	Consider Query Length:
#	- Longer queries are often more complex. Consider adding the overall length of the query as a factor in determining difficulty.
#.	Add Specific Subquery Rules:
#	- Subqueries, especially nested ones, add a layer of complexity. Count the levels of nesting as a factor.
#.	Evaluate Joins and Sub-Selects:
#	- Multiple joins or sub-selects can increase complexity, especially if they involve multiple tables or subqueries.
#.	Incorporate Aggregation Complexity:
#	- Queries with multiple aggregated columns, especially with different aggregation functions, can be more complex.
#   Integers and math operations are complex for LLMs to handle. 
#   - The more the number of integers the higher the chance of going wrong in LLM generation. 

# Using the above analysis we define the difficulty levels for queries as follows:
#	Easy: SQL queries that use only basic SELECT and FROM clauses, with at most one simple condition in the WHERE clause.
#	Medium: SQL queries with up to two joins or a single subquery, and limited use of aggregation.
#	Hard: SQL queries with multiple joins, subqueries, or complex aggregation, but without deeply nested queries or complex set operations.
#	Extra Hard: SQL queries that contain deeply nested subqueries, multiple complex set operations, or a high number of aggregated columns and conditions.
# Additional subrules for LLM complexity: 
#   The presence of integers will be checked by looking for digits within the query and will be given a high complexity weight.
#   Mathematical operations (AVG, COUNT, SUM, MIN, MAX, ROUNDUP, etc.) will also increase the complexity score but to a lesser extent than integers.


import matplotlib.pyplot as plt
from collections import Counter
import os
import re

#extract_target_dir = '/workspace/data/cs598-tpcds/data/dataset-spider/'
extract_target_dir = '/workspace/data/cs598-tpcds/data/dataset/'
top_level_contents = os.listdir(extract_target_dir)  # Get the list of contents in the top-level directory

# The extracted contents are within a directory named 'sql_files_sf100', let's list the contents of that directory.
extracted_sql_files_path = os.path.join(extract_target_dir, "SQL")
extracted_sql_files = os.listdir(extracted_sql_files_path)  # List of extracted SQL files
len(extracted_sql_files)  # The count of extracted SQL files for confirmation

# Redefine the classify_difficulty function with added rules for mathematical operations and numbers
def classify_difficulty_updated(sql_query, filename):
    # Count the basic components used in classification
    num_select_from = len(re.findall(r'\bSELECT\b.*?\bFROM\b', sql_query, re.IGNORECASE | re.DOTALL))
    num_joins = len(re.findall(r'\bJOIN\b', sql_query, re.IGNORECASE))
    num_subqueries = len(re.findall(r'\bSELECT\b', sql_query, re.IGNORECASE)) - num_select_from
    num_aggregations = len(re.findall(r'\b(AVG|COUNT|MAX|MIN|SUM|ROUNDUP|NOT)\b', sql_query, re.IGNORECASE))
    num_set_operations = len(re.findall(r'\b(UNION|INTERSECT|EXCEPT)\b', sql_query, re.IGNORECASE))
    num_nested = len(re.findall(r'\((\s*SELECT\b)', sql_query, re.IGNORECASE)) # Count only nested SELECTs
    num_integers = len(re.findall(r'\b\d+\b', sql_query, re.IGNORECASE))
    num_math_ops = num_aggregations + len(re.findall(r'\b(ROUND|ROUNDUP|CEIL|FLOOR|ABS)\b', sql_query, re.IGNORECASE))

    # Scoring adjustments
    complexity_score = (
        num_joins +
        num_subqueries * 2 +
        num_set_operations * 2 +
        num_nested * 5 + # capturing nesting is hard for LLMs. 
        num_math_ops * 8+ # Higher weight for math as they are easy to make mistakes by LLMs. 
        num_integers * 10 # Giving a higher weight for the presence of integers as LLM dont do well with numbers. More numbers higher chance of going wrong.
    )
    # Classify with the new combined rule set, considering numbers and mathematical operations
    if complexity_score <= 10:
        return 'Easy'
    elif complexity_score <= 25:
        return 'Medium'
    elif complexity_score <= 125:
        return 'Hard'
    else:
        return 'Extra Hard'

# Analyze the complexity for sql_files
difficulty_counts= Counter()

# Process each file and classify its difficulty
for file_name in extracted_sql_files:
    file_path = os.path.join(extracted_sql_files_path, file_name)
    with open(file_path, 'r', encoding='utf-8') as file:
        sql_query = file.read()
        difficulty_level = classify_difficulty_updated(sql_query, file_name)
        difficulty_counts[difficulty_level] += 1



# Modify the existing Counter object to include the missing 'Easy' field with a count of 0
if 'Easy' not in difficulty_counts:
    difficulty_counts['Easy'] = 0 

if 'Medium' not in difficulty_counts:
    difficulty_counts['Medium'] = 0 

if 'Hard' not in difficulty_counts:
    difficulty_counts['Hard'] = 0 

if 'Extra Hard' not in difficulty_counts:
    difficulty_counts['Extra Hard'] = 0 

# Ensure the keys are sorted in the order of difficulty level
sorted_difficulty_levels = ['Easy', 'Medium', 'Hard', 'Extra Hard']
sorted_counts = [difficulty_counts[level] for level in sorted_difficulty_levels]

# Redraw the bar chart with the updated and sorted data
plt.figure(figsize=(10, 6))
plt.gca().tick_params(axis='x', pad=5) 
plt.bar(sorted_difficulty_levels, sorted_counts, color='purple')
plt.xlabel('Difficulty Level',fontsize=24,fontweight="bold")
plt.ylabel('Number of Queries',fontsize=24,fontweight="bold")
#plt.title('Distribution of SQL Query Difficulty',fontsize=20)

plt.xticks(fontsize=20) 
# Save the updated figure as a PDF file in the provided path
plt.savefig('complexity_analysis.pdf', format='pdf')
#plt.show()

# Return the raw counts for reference
print(f"{difficulty_counts} : {sorted_counts}")
