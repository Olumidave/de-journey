import pandas as pd
pd.set_option("display.max_columns", None)
pd.set_option("display.width", 200)

df = pd.read_csv("data/order.csv")

df["customer"] = df["customer"].str.strip().str.title()
df["status"] = df["status"].str.strip().str.title()
df["city"] = df["city"].str.strip().str.title()
df["city"] = df["city"].replace({"Ph": "Port Harcourt"})

df["unit_price"] = df["unit_price"].str.replace("₦", "").str.replace(",", "")
df["unit_price"] = pd.to_numeric(df["unit_price"], errors="coerce")

df["total"] = df["unit_price"] * df["quantity"]

print(df)
print()
print(df.isna().sum())

bad_rows = df[df["customer"].isna() | df["unit_price"].isna()]
good_rows = df.dropna(subset=["customer", "unit_price"])

print()
print("Bad rows:", len(bad_rows))
print(bad_rows)
print("Good rows:", len(good_rows))
print(good_rows)

paid = good_rows[good_rows["status"] == "Paid"]
print()
print(paid[["order_id", "customer", "total "]])

print()
print(paid.groupby("city")["total"].sum().sort_values(ascending=False))

print()
print("Total paid:", paid["total"].sum())

good_rows.to_csv("output/clean_orders_pandas.csv", index=False)
bad_rows.to_csv("output/rejected_orders_pandas.csv", index=False)