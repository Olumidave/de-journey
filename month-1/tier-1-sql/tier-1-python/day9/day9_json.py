import json

with open("data/orders.json", "r", encoding="utf-8") as file:
    orders = json.load(file)

for order in orders:
    order_total = 0
    for item in order["items"]:
        order_total += item["quantity"] * item["unit_price"]

    name = order["customer"]["name"]
    city = order["customer"].get("city", "Unknown")
    print(order["order_id"], name, city, order_total)