import pandas as pd

# Load data
df = pd.read_csv("../data/security_logs.csv")

# Filter failed logins
failures = df[df["event_type"] == "login_failure"]

# Group by IP + username
grouped = (
    failures.groupby(["src_ip", "username"])
    .size()
    .reset_index(name="failed_attempts")
    .sort_values("failed_attempts", ascending=False)
)

# Suspicious brute-force threshold
suspicious = grouped[grouped["failed_attempts"] >= 10]

print("Top brute-force style login attempts:")
print(suspicious.head(20))
