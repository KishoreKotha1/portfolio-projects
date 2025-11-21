import pandas as pd

df = pd.read_csv("../data/security_logs.csv")

# Count events per country
country_events = df.groupby("country").size().reset_index(name="event_count")

# Highlight countries with high critical incidents
critical_events = df[df["severity"].isin(["High", "Critical"])]
critical_by_country = critical_events.groupby("country").size().reset_index(name="critical_count")

print("Total events by country:")
print(country_events.sort_values("event_count", ascending=False).head(10))

print("\nHigh/Critical events by country:")
print(critical_by_country.sort_values("critical_count", ascending=False).head(10))
