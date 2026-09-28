# Class 4 - Functions and Loops
# Zenith Retail Data Pipeline Simulation

# ---- FUNCTIONS ----

def calculate_final_price(price, tax_rate=0.075):
    tax = price * tax_rate
    final_price = price + tax
    return final_price

def clean_customer_name(raw_name):
    name = raw_name.strip()
    name = name.title()
    return name

def categorize_sale(amount):
    if amount < 5000:
        return "Small Sale"
    elif amount < 50000:
        return "Medium Sale"
    else:
        return "Large Sale"


def apply_discount(price, discount_rate = 0.10):
    discount_amount = price * discount_rate
    discounted_price = price - discount_amount
    return discounted_price

# ---- DATA ----

products = [
    {"name": "  laptop dell  ", "price": 450000},
    {"name": "WIRELESS MOUSE", "price": 8500},
    {"name": "usb hub   ", "price": 4200},
    {"name": "  MONITOR LG  ", "price": 185000},
    {"name": "keyboard logitech", "price": 12000},
]

# ---- PIPELINE ----

print("=" * 50)
print("ZENITH RETAIL - PRODUCT PROCESSING PIPELINE")
print("=" * 50)

total_revenue = 0

for product in products:
    clean_name = clean_customer_name(product["name"])
    final_price = calculate_final_price(product["price"])
    category = categorize_sale(product["price"])
    apply_discounted_price = apply_discount(product["price"])  # Applying a 10% discount
    total_revenue += final_price


    print(f"\nProduct:     {clean_name}")
    print(f"Base Price:  {product['price']:,.2f}")
    print(f"Final Price: {final_price:,.2f}")
    print(f"Category:    {category}")
    print(f"Discount Price: {apply_discounted_price:,.2f}")

print("\n" + "=" * 50)
print(f"TOTAL REVENUE: {total_revenue:,.2f}")
print("=" * 50)

# Class 4 Task - apply_discount function

def apply_discount(price, discount_percent):
    discount_amount = price * (discount_percent / 100)
    final_price = price - discount_amount
    return final_price

# Testing it
print(apply_discount(10000, 10))   # 10% off  → 9000.0
print(apply_discount(50000, 25))   # 25% off  → 37500.0
print(apply_discount(8500, 5))     # 5% off   → 8075.0