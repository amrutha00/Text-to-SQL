# The State of the Text-to-SQL LLM models: Insights From TPC-DS Benchmarks 

This repository contains the artifacts of the research work titled, "The State of the Text-to-SQL LLM models: Insights From TPC-DS Benchmarks". The work is done as part of Fall 2023 UIUC CS598 course project taught by Prof Daniel Kang.

# Abstract
In the evolving data analytics domain, the integration of Large Language Models (LLMs) is transforming SQL-based data interactions and retrieval. This research introduces a comprehensive framework to evaluate Text-to-SQL LLMs using the industry-standard Transaction Processing Performance Council's Decision Support specification (TPC-DS) specification, that effectively simulates a data warehouse environment. We meticulously transform TPC-DS benchmark queries into natural language queries (NLQs) to form a unique dataset for Text-to-SQL model input. Recognizing the inadequacy of conventional complexity metrics, especially for nested and intricate subqueries, we introduce new SQL query complexity rules tailored for practical industrial and enterprise applications.  This end-to-end framework is designed with an ultimate goal to evaluate LLMs' effectiveness in SQL query generation and their accuracy on actual databases. Despite advances, our findings reveal significant challenges in applying Text-to-SQL models to complex, real-world scenarios, with issues like binding errors, parsing difficulties, and semantic disparities in LLM-generated queries. While queries generated by GPT4 and SQLCoder-34B show up to 13.1$\times$ and 481.2$\times$, respectively, faster response times compared to handcrafted queries, the end-to-end execution is significantly hindered (upto 22.7$\times$ and 281.96$\times$ for GPT4 and SQLCoder-34B, respectively) by the LLMs' inference time, underscoring the necessity of further optimizing in LLM generation for practical considerations.


# Quick Start 

In order to start using our work, all you need to do is install the requirements file, download the required datasets and then work with respective set of files. 
Setting up the enviroment is as simple as 

```
#pull nvidia docker container and set up your directory where you want to persist your data in host location.  
docker pull nvcr.io/nvidia/pytorch:23.09-py3
docker run -itd --gpus all --privileged --shm-size=16g -p 8888:8888 -v <host location>:/workspace/data --name tpcdsinsights nvcr.io/nvidia/pytorch:23.09-py3 bash
docker exec -it tpcdsinsights bash 
cd /workspace/data/
git clone https://github.com/Bhagyashreet20/cs598-tpcds.git
cd cs598-tpcds
```

## Minimum hardware and software requirements

Minimum Hardware requirements: 
```
16 core x86 CPU
256GB RAM
NVIDIA Ampere generation or above GPU card.
512GB of diskspace
```

Software requirements:
The codebase has been tested with NVIDIA NGC [Pytorch:23.09 containers](nvcr.io/nvidia/pytorch:23.09-py3). 
Install necessary packages to install DuckDB by following steps discussed in [DuckDB Install](https://duckdb.org/#quickinstall)
We also require OpenAI API keys to access their models. 
Since we will be using GPT3.5 and GPT4 models in our evaluation, you must register with OpenAI and have available credits of atleast $10 to start. 


## Downloads
1. Download TPC-DS Text-to-SQL dataset from here: [Google drive](ADD LINK)
You need to copy the downloaded dataset in this location of the repository.
```
mv ~/Downloads/tpcds_dataset.tar.gz /workspace/data/cs598-tpcds/data/tpcds/NLQ/
cd /workspace/data/cs598-tpcds/data/tpcds/NLQ/
tar xvzf <>
```

2. Due to licensing requirements, we do not provide TPC-DS source code to generate queries or dataset publicly.
One can raise a request to [TPC-DS committee](https://www.tpc.org/tpc_documents_current_versions/current_specifications5.asp) and get these tools.  
Download TPC-DS dsdqgen tool after accepting their licensing terms. The tool is filled with errors, and we are open to providing the patch on-request. 
Note: If you are a core developer of the project, you can raise a request by emailing primary author. 

We are providing generated golden queries only for SF100 dataset in this folder: 
We expect the user generates SF100 dataset using the following commands. (This should take close to 1hr on Gen4 SSD).
```
python data/duckdb/gen_sf_data.py
```
On successful generation, you should be able to see the dataset stored in parquet format in `data/tpcds/tpcds_sf100`.
If successful generation fails, then it can be either you ran out of memory or disk space or you are using older version of duckdb. 

3. If you plan to test [SQLCoder-34B](https://github.com/defog-ai/sqlcoder), execute data/sqlcoder/sqlcoder.ipynb script.

4. If you plan to train or test SQLize, download the models from here: [Google drive](ADD LINK). 
Copy the models to this location of the repository 
```
mv ~/Downloads/tpcds_models.tar.gz ./models/
cd ./models
tar xvzf <>
```

# End-to-end evaluation

## Executing Golden queries 
You can execute golden queries is quite easy. Please follow the below script.

```
python data/sql/scripts/execute_golden_queries.py
```
 

## Executing Text-to-SQL LLM queries. 
We split the execution of SQL generation using LLM and executing the generated SQL in DuckDB database engine in two different files for ease of use and to reduce cost. 
We have two different scripts created depending on the choice of the model. 
This is because OpenAI GPT3.5 and GPT4 are required to be accessed via end-point while the SQLCoder-34B and SQLize are local host models and requires to be accessed locally. 

For GPT3.5 models. 
1. Generate SQL using: 
2. Execute the generated SQL on DuckDB using:

For GPT4 models: 
1. Generate SQL using: 
2. Execute the generated SQL on DuckDB using:


For SQLCoder-34B and SQLize models, a lot of manual intervension is required to extract the SQL query from the LLM response. 
1. Generate SQL using: 
2. Manually extract the generated SQL queries and update the sql scripts.
2. Execute the generated SQL on DuckDB using:i



# SQLize Training and Fine-tuning
Please follow the notebook described below for the purpose. 




# Dataset keyword and complexity analysis 

Complexity analysis script is available here: 
Keyword analysis script is available here: 
Presence keyword analysis script is available here: 


# Contribute
We have many improvements we'd like to implement. Please help us! If you would like to contribute, please contact us. 

# Contact us
Reach out to btaleka2 at illinois dot edu
