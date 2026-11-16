import csv

with open("data/orders.csv", "r", encoding="utf-8", newline="") as file:
    reader = csv.DictReader(file)
    orders = list(reader)

print("Rows read:", len(orders))
print(orders[1])
print(orders[1]["unit_price"], type(orders[1]["unit_price"]))
