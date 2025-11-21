import pandas as pd
import numpy as np

df = pd.read_csv("../data/security_logs.csv")

# Calculate z-score for bytes_in and bytes_out
df["bytes_in_z"] = (df["bytes_in"] - df["bytes_in"].mean()) / df["bytes_in"].std()
df["bytes_out_z"] = (df["bytes_out"] - df["bytes_out"].mean()) / df["bytes_out"].std()

# Flag anomalies
anomalies = df[(df["bytes_in_z"].abs() > 3) | (df["bytes_out_z"].abs() > 3)]

print("Traffic anomalies:")
print(anomalies[["timestamp", "src_ip", "dest_ip", "bytes_in", "bytes_out"]].head(20))
