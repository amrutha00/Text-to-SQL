import duckdb

# Connect to DuckDB
con = duckdb.connect()

# Install the TPC-DS extension
con.execute("INSTALL tpcds")

# Load the TPC-DS extension
con.execute("LOAD tpcds")

print("Generating TPCDS data.")
# Call dsdgen to generate data with a scaling factor of 1
#con.execute("CALL dsdgen(sf=1)")
con.execute("CALL dsdgen(sf=100)")

# Export the database in Parquet format
print("Saving TPCDS data.")
con.execute("EXPORT DATABASE '/workspace/data/cs598-tpcds/data/duckdb/tpcds_sf100' (FORMAT PARQUET)")
#con.execute("EXPORT DATABASE '/workspace/data/cs598-tpcds/data/duckdb/tpcds_sf1' (FORMAT PARQUET)")

# Close the connection
con.close()
print("Generation complete.")
