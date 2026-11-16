import pandas as pd
pd.set.option("display.max_columns", None)
pd.set.option("display.width", 200)

df = pd.read_csv("data/orders.csv")

print(df)
print()
print("Rows and columns:", df.shape)
print()
print(df.dtypes)
print()
print(df.isna().sum())