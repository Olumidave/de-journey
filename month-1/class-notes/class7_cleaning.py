import pandas as pd

df = pd.read_csv(r"C:\Users\OLUMIDE\de-journey\month-1\data\messy_stores.csv")


import pandas as pd

df = pd.read_csv(
    r"C:\Users\OLUMIDE\de-journey\month-1\data\messy_stores.csv",
    encoding="utf-16"
)

print(df)


print("RAW DATA:")
print(df)
print("\nShape:", df.shape)
print("\nData types:")
print(df.dtypes)
print("\nMissing values per column:")
print(df.isnull().sum())

# Check missing values
print("missing values before cleaning")
print(df.isnull().sum())

# Fix missing revenue - replace with 0
df["revenue"] = df["revenue"].fillna(0)

# Fix missing manager - replace with "Unknown"
df["manager"] = df["manager"].fillna("Unknown")

# Fix missing is_active - replace with False
df["is_active"] = df["is_active"].fillna(False)

print("\nMissing values after cleaning:")
print(df.isnull().sum())



# Fix city names - remove spaces and fix capitalization
df["city"] = df["city"].str.strip()   # Remove extra spaces
df["city"] = df["city"].str.title()   # Fix capitalization

# Fix manager names - fix capitalization
df["manager"] = df["manager"].str.title()

print("Cities after cleaning:")
print(df["city"].unique())

# Revenue of -9999 means missing data - replace with 0
df["revenue"] = df["revenue"].replace(-9999, 0)

# Show revenues after fix
print("Revenue after fixing invalid values:")
print(df["revenue"])


print(f"Rows before removing duplicates: {len(df)}")

# Remove completely duplicate rows
df = df.drop_duplicates()

print(f"Rows after removing duplicates: {len(df)}")
print(df)


df["date_opened"] = pd.to_datetime(df["date_opened"]) 
df["is_active"] = df["is_active"].astype(bool)
df["revenue"] = df["revenue"].astype(int)

print(df.dtypes)


print("Data types before fixing:")
print(df.dtypes)

# Convert date column to proper datetime type
df["date_opened"] = pd.to_datetime(df["date_opened"])

# Convert is_active to boolean properly
df["is_active"] = df["is_active"].astype(bool)

# Convert revenue to integer (no decimal points needed)
df["revenue"] = df["revenue"].astype(int)

print("\nData types after fixing:")
print(df.dtypes)


print("\n" + "=" * 50)
print("DATA VALIDATION REPORT")
print("=" * 50)
print(f"Total records:        {len(df)}")
print(f"Missing values:       {df.isnull().sum().sum()}")
print(f"Duplicate rows:       {df.duplicated().sum()}")
print(f"Negative revenues:    {(df['revenue'] < 0).sum()}")
print(f"Cities found:         {df['city'].unique()}")
print(f"Active stores:        {df['is_active'].sum()}")
print(f"Inactive stores:      {(~df['is_active']).sum()}")
print("=" * 50)
print("\nAll checks passed! ✓" if df.isnull().sum().sum() == 0 else "⚠️ Still has issues!")

print(f"Total Records:           {len(df)}")
print(f" Negetive Revenue:        {(df['revenue'] < 0).sum()}")