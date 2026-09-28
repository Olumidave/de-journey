# Class 3 - Data Types in Data Engineering
# Simulating a simple sales record from Zenith Retail

# Store information - using different data types
store_name = "Zenith Retail Lagos"     # string
store_id = 101                          # integer
is_active = True                        # boolean

# Sales data for today
total_orders = 342                      # integer
revenue = 125430.50                     # float
average_order_value = revenue / total_orders  # Python calculates this

# Customer data that came in messy (common in real pipelines)
raw_customer_count = "1500"            # string - came in wrong type!
clean_customer_count = int(raw_customer_count)  # fixed!

# Display a simple report
print("=" * 40)
print("ZENITH RETAIL - DAILY SUMMARY")
print("=" * 40)
print(f"Store: {store_name}")
print(f"Store ID: {store_id}")
print(f"Active: {is_active}")
print(f"Total Orders: {total_orders}")
print(f"Revenue: ₦{revenue:,.2f}")
print(f"Avg Order Value: ₦{average_order_value:,.2f}")
print(f"Customers Today: {clean_customer_count}")
print("=" * 40)

# Check the data types
print("\nData Type Check:")
print(f"store_name is: {type(store_name)}")
print(f"store_id is: {type(store_id)}")
print(f"revenue is: {type(revenue)}")
print(f"is_active is: {type(is_active)}")
