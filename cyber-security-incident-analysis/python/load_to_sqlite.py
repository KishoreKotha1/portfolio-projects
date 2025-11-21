import pandas as pd
import sqlite3

# Load the CSV file
df = pd.read_csv("../data/security_logs.csv")

# Connect to SQLite database (creates file if it doesn't exist)
conn = sqlite3.connect("security_logs.db")

# Write DataFrame to SQL table
df.to_sql("security_logs", conn, if_exists="replace", index=False)

conn.close()

print("Loaded security_logs.csv into SQLite database (security_logs.db)")
