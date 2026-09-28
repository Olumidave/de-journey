# Class 5 - Lists, Dictionaries and Files
import csv

# ---- STEP 1: LOAD ----
print("STEP 1: Loading data...")
stores = []

with open("month-1/data/stores.csv", "r") as file:
    reader = csv.DictReader(file)
    for row in reader:
        stores.append(row)

print(f"Loaded {len(stores)} store records")

# ---- STEP 2: CLEAN ----
print("\nSTEP 2: Cleaning data...")
cleaned_stores = []

for store in stores:
    cleaned = {
        "store_id": int(store["store_id"]),
        "city": store["city"].strip().title(),
        "revenue": float(store["revenue"]),
        "is_active": store["is_active"] == "True"
    }
    cleaned_stores.append(cleaned)

print(f"Cleaned {len(cleaned_stores)} records")

# ---- STEP 3: ANALYZE ----
print("\nSTEP 3: Analyzing...")
total_revenue = 0
active_stores = []
inactive_stores = []

for store in cleaned_stores:
    total_revenue += store["revenue"]
    if store["is_active"]:
        active_stores.append(store["city"])
    else:
        inactive_stores.append(store["city"])

average_revenue = total_revenue / len(cleaned_stores)

# ---- STEP 4: REPORT ----
print("\n" + "=" * 45)
print("   ZENITH RETAIL - STORE ANALYSIS REPORT")
print("=" * 45)
print(f"Total Stores:    {len(cleaned_stores)}")
print(f"Active Stores:   {len(active_stores)} → {active_stores}")
print(f"Inactive Stores: {len(inactive_stores)} → {inactive_stores}")
print(f"Total Revenue:   ₦{total_revenue:,.2f}")
print(f"Average Revenue: ₦{average_revenue:,.2f}")
print("=" * 45)

# ---- STEP 5: SAVE ----
print("\nSTEP 5: Saving report...")

with open("month-1/data/report.txt", "w") as file:
    file.write("ZENITH RETAIL - STORE ANALYSIS REPORT\n")
    file.write("=" * 45 + "\n")
    file.write(f"Total Stores: {len(cleaned_stores)}\n")
    file.write(f"Total Revenue: {total_revenue}\n")
    file.write(f"Average Revenue: {average_revenue}\n")

print("Report saved!")
print("\nPipeline complete! ✓")