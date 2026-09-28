branches = ["Lagos", "Abuja", "Kano"]

# Add an item to the end
branches.append("Ibadan")
print(branches)  # ["Lagos", "Abuja", "Kano", "Ibadan"]

# Remove an item
branches.remove("Kano")
print(branches)  # ["Lagos", "Abuja", "Ibadan"]

# How many items are in the list
print(len(branches))  # 3

# Check if something is in the list
print("Lagos" in branches)   # True
print("Kano" in branches)    # False

# Sort the list alphabetically
branches.sort()
print(branches)  # ["Abuja", "Ibadan", "Lagos"]

# Raw sales amounts coming from a database
raw_sales = [15000, 8500, 0, 42000, -500, 91000, 0, 7800]

# Clean the data - remove zeros and negative numbers
clean_sales = []

for sale in raw_sales:
    if sale > 0:
        clean_sales.append(sale)

print(f"Raw data: {raw_sales}")
print(f"Clean data: {clean_sales}")
print(f"Removed {len(raw_sales) - len(clean_sales)} bad records")

#dictionary
store = {
    "storeid": 101,
    "city": "Lagos",
    "revenue": 125000,
    "is_active": True
}

print(store["city"])
print(store["revenue"])
print(store["is_active"])

store = {"store_id": 101, "city": "Lagos", "revenue": 125000}

# Add a new key
store["manager"] = "Olumide David"
print(store)

# Update an existing value
store["revenue"] = 150000
print(store["revenue"]) 

# Check if a key exists
print("city" in store)  
print("discount" in store)  

# Get all keys
print(store.keys())

# Get all values
print(store.values()) 

# This is what data from a database looks like in Python
stores = [
    {"store_id": 101, "city": "Lagos", "revenue": 125000},
    {"store_id": 102, "city": "Abuja", "revenue": 89000},
    {"store_id": 103, "city": "Kano", "revenue": 204000},
    {"store_id": 104, "city": "Ibadan", "revenue": 67000},
]

# Loop through every store and print a summary
for store in stores:
    print(f"Store {store['store_id']} in {store['city']}: ₦{store['revenue']:,}")







