import pandas as pd

# Create a simple DataFrame from scratch
data = {
    "store_id": [101, 102, 103, 104],
    "city": ["Lagos", "Abuja", "Kano", "Ibadan"],
    "revenue": [125000, 89000, 204000, 67000],
    "is_active": [True, True, False, True]
}

df = pd.DataFrame(data)
print(df)

import pandas as pd

df = pd.read_csv("month-1/data/stores.csv")
print(df)


import pandas as pd

df = pd.read_csv("month-1/data/stores.csv")

# How many rows and columns?
print(df.shape)

# What are the column names?
print(df.columns)

# What data types is each column?
print(df.dtypes)

# Show first 3 rows
print(df.head(3))

# Show last 2 rows
print(df.tail(2))

# Quick statistical summary
print(df.describe())


df = pd.read_csv("month-1/data/stores.csv")

print(df["city"])
print(df[["city", "revenue"]])


import pandas as pd

df = pd.read_csv("month-1/data/stores.csv")

# Show only active stores
active = df[df["is_active"] == True]
print(active)

# Show only stores with revenue above 100000
high_revenue = df[df["revenue"] > 100000]
print(high_revenue)

# Combine two conditions - active AND high revenue
top_stores = df[(df["is_active"] == True) & (df["revenue"] > 100000)]
print(top_stores)



import pandas as pd

df = pd.read_csv("month-1/data/stores.csv")

# Add a tax column (7.5% of revenue)
df["tax"] = df["revenue"] * 0.075

# Add a revenue after tax column
df["revenue_after_tax"] = df["revenue"] + df["tax"]

# Add a performance label
df["performance"] = df["revenue"].apply(
    lambda x: "High" if x > 100000 else "Low"
)

print(df)


import pandas as pd

# Bigger dataset
data = {
    "city": ["Lagos", "Lagos", "Abuja", "Abuja", "Kano"],
    "product": ["Laptop", "Phone", "Laptop", "TV", "Phone"],
    "sales": [450000, 85000, 420000, 195000, 78000]
}

df = pd.DataFrame(data)

# Total sales by city
by_city = df.groupby("city")["sales"].sum()
print(by_city)

# Average sales by city
avg_by_city = df.groupby("city")["sales"].mean()
print(avg_by_city)


import pandas as pd

df = pd.read_csv("month-1/data/stores.csv")

# Add new column
df["revenue_after_tax"] = df["revenue"] * 1.075

# Save to new CSV file
df.to_csv("month-1/data/stores_processed.csv", index=False)

print("File saved!")


# Class 6 - pandas Full Practice
# Zenith Retail Store Analysis

import pandas as pd

print("=" * 50)
print("ZENITH RETAIL - pandas PIPELINE")
print("=" * 50)

# LOAD
print("\n1. Loading data...")
df = pd.read_csv("month-1/data/stores.csv")
print(f"Shape: {df.shape}")
print(df.head())

# EXPLORE
print("\n2. Data types:")
print(df.dtypes)

# FILTER
print("\n3. Active stores only:")
active_df = df[df["is_active"] == True]
print(active_df[["store_id", "city", "revenue"]])

# ADD COLUMNS
print("\n4. Adding calculated columns...")
df["tax"] = df["revenue"] * 0.075
df["final_revenue"] = df["revenue"] + df["tax"]
df["performance"] = df["revenue"].apply(
    lambda x: "High" if x > 100000 else "Low"
)

# SUMMARY
print("\n5. Summary:")
print(f"Total Revenue:   ₦{df['revenue'].sum():,.2f}")
print(f"Average Revenue: ₦{df['revenue'].mean():,.2f}")
print(f"Highest Revenue: ₦{df['revenue'].max():,.2f}")
print(f"Lowest Revenue:  ₦{df['revenue'].min():,.2f}")


# SAVE
print("\n6. Saving processed data...")
df.to_csv("month-1/data/stores_processed.csv", index=False)
print("Saved to stores_processed.csv")

print("\n" + "=" * 50)
print("Pipeline complete! ✓")
print("=" * 50)